import {
	type Api,
	type AssistantMessageEventStream,
	type Context,
	type Model,
	type OAuthCredentials,
	type OAuthLoginCallbacks,
	type SimpleStreamOptions,
	createAssistantMessageEventStream,
	streamSimpleGoogle,
} from "@mariozechner/pi-ai";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const CLIENT_ID = "REDACTED_CLIENT_ID";
const CLIENT_SECRET = "REDACTED_CLIENT_SECRET";
const REDIRECT_URI = "http://localhost:36742/oauth-callback";
const SCOPES = [
	"https://www.googleapis.com/auth/cloud-platform",
	"https://www.googleapis.com/auth/userinfo.email",
	"https://www.googleapis.com/auth/userinfo.profile",
	"https://www.googleapis.com/auth/cclog",
	"https://www.googleapis.com/auth/experimentsandconfigs",
];
const CODE_ASSIST_ENDPOINT = "https://daily-cloudcode-pa.sandbox.googleapis.com";
const CODE_ASSIST_ENDPOINTS = [
	CODE_ASSIST_ENDPOINT,
	"https://autopush-cloudcode-pa.sandbox.googleapis.com",
	"https://cloudcode-pa.googleapis.com",
];
const CODE_ASSIST_HEADERS = {
	"User-Agent": "antigravity/1.15.8 linux/amd64",
	"X-Goog-Api-Client": "google-cloud-sdk vscode_cloudshelleditor/0.1",
	"Client-Metadata": '{"ideType":"IDE_UNSPECIFIED","platform":"PLATFORM_UNSPECIFIED","pluginType":"GEMINI"}',
};

const MODEL_ALIASES: Record<string, string> = {
	"gemini-3-pro-preview": "gemini-3-pro-high",
	"gemini-3-flash-preview": "gemini-3-flash",
	"gemini-claude-sonnet-4-5": "claude-sonnet-4-5",
	"gemini-claude-sonnet-4-5-thinking": "claude-sonnet-4-5-thinking",
	"gemini-claude-opus-4-5-thinking": "claude-opus-4-5-thinking",
};

const MODELS = [
	{ id: "gemini-3-pro-preview", name: "Gemini 3 Pro Preview (Antigravity)", reasoning: true, input: ["text", "image"] as const, contextWindow: 1_000_000, maxTokens: 65_536 },
	{ id: "gemini-3-flash", name: "Gemini 3 Flash (Antigravity)", reasoning: true, input: ["text", "image"] as const, contextWindow: 1_000_000, maxTokens: 65_536 },
	{ id: "gemini-2.5-pro", name: "Gemini 2.5 Pro (Antigravity)", reasoning: true, input: ["text", "image"] as const, contextWindow: 1_000_000, maxTokens: 65_536 },
	{ id: "gemini-2.5-flash", name: "Gemini 2.5 Flash (Antigravity)", reasoning: true, input: ["text", "image"] as const, contextWindow: 1_000_000, maxTokens: 65_536 },
];

function b64url(bytes: Uint8Array): string {
	return Buffer.from(bytes).toString("base64url");
}
async function pkce() {
	const raw = crypto.getRandomValues(new Uint8Array(32));
	const verifier = b64url(raw);
	const hash = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(verifier));
	return { verifier, challenge: b64url(new Uint8Array(hash)) };
}
function parseRefresh(refresh: string) {
	const [refreshToken = "", projectId = ""] = refresh.split("|");
	return { refreshToken, projectId };
}
async function fetchAccountInfo(access: string): Promise<string> {
	for (const endpoint of CODE_ASSIST_ENDPOINTS) {
		const res = await fetch(`${endpoint}/v1internal:loadCodeAssist`, {
			method: "POST",
			headers: { Authorization: `Bearer ${access}`, "Content-Type": "application/json", ...CODE_ASSIST_HEADERS },
			body: JSON.stringify({ metadata: { ideType: "IDE_UNSPECIFIED", platform: "PLATFORM_UNSPECIFIED", pluginType: "GEMINI" } }),
		});
		if (!res.ok) continue;
		const data = await res.json() as any;
		if (typeof data.cloudaicompanionProject === "string") return data.cloudaicompanionProject;
		if (typeof data.cloudaicompanionProject?.id === "string") return data.cloudaicompanionProject.id;
	}
	return "";
}
async function login(callbacks: OAuthLoginCallbacks): Promise<OAuthCredentials> {
	const { verifier, challenge } = await pkce();
	const state = crypto.randomUUID();
	const url = new URL("https://accounts.google.com/o/oauth2/v2/auth");
	url.searchParams.set("client_id", CLIENT_ID);
	url.searchParams.set("response_type", "code");
	url.searchParams.set("redirect_uri", REDIRECT_URI);
	url.searchParams.set("scope", SCOPES.join(" "));
	url.searchParams.set("code_challenge", challenge);
	url.searchParams.set("code_challenge_method", "S256");
	url.searchParams.set("state", state);
	url.searchParams.set("access_type", "offline");
	url.searchParams.set("prompt", "consent");
	callbacks.onAuth({ url: url.toString() });
	const callbackUrl = await callbacks.onPrompt({ message: "Paste the Antigravity OAuth callback URL:" });
	const got = new URL(callbackUrl);
	if (got.searchParams.get("state") !== state) throw new Error("OAuth state mismatch");
	const code = got.searchParams.get("code");
	if (!code) throw new Error("No OAuth code in callback URL");
	const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
		method: "POST",
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		body: new URLSearchParams({ client_id: CLIENT_ID, client_secret: CLIENT_SECRET, code, grant_type: "authorization_code", redirect_uri: REDIRECT_URI, code_verifier: verifier }).toString(),
	});
	if (!tokenRes.ok) throw new Error(`Antigravity token exchange failed: ${await tokenRes.text()}`);
	const token = await tokenRes.json() as { access_token: string; refresh_token: string; expires_in: number };
	const projectId = await fetchAccountInfo(token.access_token);
	return { access: token.access_token, refresh: `${token.refresh_token}|${projectId}`, expires: Date.now() + token.expires_in * 1000 - 60_000 };
}
async function refreshToken(credentials: OAuthCredentials): Promise<OAuthCredentials> {
	const { refreshToken, projectId } = parseRefresh(credentials.refresh);
	const res = await fetch("https://oauth2.googleapis.com/token", {
		method: "POST",
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		body: new URLSearchParams({ client_id: CLIENT_ID, client_secret: CLIENT_SECRET, grant_type: "refresh_token", refresh_token: refreshToken }).toString(),
	});
	if (!res.ok) throw new Error(`Antigravity token refresh failed: ${await res.text()}`);
	const token = await res.json() as { access_token: string; refresh_token?: string; expires_in: number };
	return { access: token.access_token, refresh: `${token.refresh_token ?? refreshToken}|${projectId || await fetchAccountInfo(token.access_token)}`, expires: Date.now() + token.expires_in * 1000 - 60_000 };
}

function transformSse(text: string): string {
	let pending = "";
	const out: string[] = [];
	for (const chunk of text.split("\n")) {
		const line = pending + chunk;
		pending = "";
		if (!line.startsWith("data:")) {
			out.push(line);
			continue;
		}
		const raw = line.slice(5).trim();
		if (!raw) {
			out.push(line);
			continue;
		}
		try {
			let json = JSON.parse(raw);
			if (Array.isArray(json)) json = json.find((x) => x && typeof x === "object") ?? json;
			if (json?.response) out.push(`data: ${JSON.stringify(json.response)}`);
			else out.push(line);
		} catch {
			out.push(line);
		}
	}
	return out.join("\n");
}
function patchFetch(access: string, projectId: string) {
	const original = globalThis.fetch;
	globalThis.fetch = (async (input: any, init?: RequestInit) => {
		const url = typeof input === "string" ? input : input?.url;
		if (!url?.includes("generativelanguage.googleapis.com")) return original(input, init);
		const match = String(url).match(/\/models\/([^:]+):(\w+)/);
		if (!match) return original(input, init);
		const [, rawModel, action] = match;
		const model = MODEL_ALIASES[rawModel] ?? rawModel;
		const streaming = action === "streamGenerateContent";
		const headers = new Headers(init?.headers ?? (typeof input !== "string" ? input.headers : undefined));
		headers.delete("x-goog-api-key");
		headers.set("Authorization", `Bearer ${access}`);
		headers.set("Content-Type", "application/json");
		headers.set("Accept", streaming ? "text/event-stream" : "application/json");
		for (const [k, v] of Object.entries(CODE_ASSIST_HEADERS)) headers.set(k, v);
		let body: any = init?.body;
		if (typeof body === "string") {
			const request = JSON.parse(body);
			delete request.safetySettings;
			request.sessionId ??= crypto.randomUUID();
			body = JSON.stringify({ project: projectId, model, userAgent: "antigravity", requestType: "agent", requestId: crypto.randomUUID(), request });
		}
		const res = await original(`${CODE_ASSIST_ENDPOINT}/v1internal:${action}${streaming ? "?alt=sse" : ""}`, { ...init, headers, body });
		if (!streaming || !res.body) return res;
		return new Response(res.body.pipeThrough(new TextDecoderStream()).pipeThrough(new TransformStream({ transform(chunk, ctl) { ctl.enqueue(transformSse(chunk)); } })).pipeThrough(new TextEncoderStream()), { status: res.status, statusText: res.statusText, headers: res.headers });
	}) as typeof fetch;
	return () => { globalThis.fetch = original; };
}
function streamAntigravity(model: Model<Api>, context: Context, options?: SimpleStreamOptions): AssistantMessageEventStream {
	const out = createAssistantMessageEventStream();
	(async () => {
		const access = options?.apiKey;
		const projectId = model.headers?.["x-antigravity-project"] || "";
		if (!access) throw new Error("No Antigravity access token. Run /login google-antigravity");
		const restore = patchFetch(access, projectId);
		try {
			const inner = streamSimpleGoogle({ ...model, provider: "google-antigravity", api: "google-generative-ai" } as any, context, { ...options, apiKey: "antigravity" });
			for await (const event of inner) out.push(event);
		} catch (e) {
			out.push({ type: "error", reason: "error", error: { role: "assistant", content: [], api: model.api, provider: model.provider, model: model.id, usage: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0, totalTokens: 0, cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0, total: 0 } }, stopReason: "error", errorMessage: e instanceof Error ? e.message : String(e), timestamp: Date.now() } });
		} finally { restore(); out.end(); }
	})();
	return out;
}

export default function (pi: ExtensionAPI) {
	pi.registerProvider("google-antigravity", {
		name: "Google Antigravity",
		baseUrl: "https://generativelanguage.googleapis.com/v1beta",
		api: "google-generative-ai",
		models: MODELS.map((m) => ({ ...m, cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 } })),
		oauth: {
			name: "Google Antigravity",
			login,
			refreshToken,
			getApiKey: (c) => c.access,
			modifyModels: (models, c) => models.map((m) => ({ ...m, headers: { ...(m.headers ?? {}), "x-antigravity-project": parseRefresh(c.refresh).projectId ?? "" } })),
		},
		streamSimple: streamAntigravity,
	});
}
