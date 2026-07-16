#!/usr/bin/env node

/**
 * scan-config.mjs
 * Scans .config directory and shell config to inventory available tools.
 * Run once per session to orient the agent to this machine.
 */

import { readdirSync, readFileSync, existsSync } from "fs";
import { join, basename } from "path";
import { execSync } from "child_process";

const HOME = process.env.HOME || "/home/jemo";
const CONFIG_DIR = join(HOME, ".config");
const ZSHRC = join(HOME, ".zshrc");
const OPENCODE_CONFIG = join(CONFIG_DIR, "opencode", "opencode.json");
const SKILLS_DIRS = [
  join(HOME, "dot-file", ".agents", "skills"),
  join(HOME, "dot-file", ".opencode", "skills"),
];

function getInstalledTools() {
  const tools = [];
  const candidates = [
    "nvim", "git", "node", "npm", "npx", "python", "python3",
    "uv", "bun", "dart", "flutter", "lazygit", "tv", "fzf",
    "zoxide", "atuin", "oh-my-posh", "bat", "eza", "ripgrep",
    "jq", "curl", "wget", "docker", "cargo", "rustc",
    "go", "java", "javac", "gcc", "g++", "make",
    "code", "cursor", "trae", "opencode",
  ];

  for (const tool of candidates) {
    try {
      const path = execSync(`which ${tool} 2>/dev/null`, {
        encoding: "utf-8",
      }).trim();
      if (path) tools.push({ name: tool, path });
    } catch {
      // not installed
    }
  }

  return tools;
}

function getShellAliases() {
  if (!existsSync(ZSHRC)) return [];

  const content = readFileSync(ZSHRC, "utf-8");
  const aliases = [];
  const aliasRegex = /^alias\s+(\w+)=(['"])(.+?)\2\s*$/gm;
  let match;

  while ((match = aliasRegex.exec(content)) !== null) {
    aliases.push({ alias: match[1], expandsTo: match[3] });
  }

  return aliases;
}

function getConfigDirs() {
  try {
    return readdirSync(CONFIG_DIR, { withFileTypes: true })
      .filter((d) => d.isDirectory())
      .map((d) => d.name)
      .filter((name) => !name.startsWith("."));
  } catch {
    return [];
  }
}

function getMcpServers() {
  if (!existsSync(OPENCODE_CONFIG)) return [];

  try {
    const config = JSON.parse(readFileSync(OPENCODE_CONFIG, "utf-8"));
    return Object.keys(config.mcp || {});
  } catch {
    return [];
  }
}

function getSkills() {
  const skills = [];

  for (const dir of SKILLS_DIRS) {
    try {
      const entries = readdirSync(dir, { withFileTypes: true });
      for (const entry of entries) {
        if (entry.isDirectory()) {
          const skillPath = join(dir, entry.name, "SKILL.md");
          if (existsSync(skillPath)) {
            skills.push({
              name: entry.name,
              location: dir.includes(".agents") ? ".agents/skills" : ".opencode/skills",
            });
          }
        }
      }
    } catch {
      // directory not accessible
    }
  }

  return skills;
}

function main() {
  console.log("# Environment Scan\n");

  console.log("## Installed Tools\n");
  const tools = getInstalledTools();
  if (tools.length === 0) {
    console.log("No tools detected.\n");
  } else {
    console.log(
      tools.map((t) => `- **${t.name}** → ${t.path}`).join("\n") + "\n"
    );
  }

  console.log("## Shell Aliases\n");
  const aliases = getShellAliases();
  if (aliases.length === 0) {
    console.log("No aliases found.\n");
  } else {
    console.log(
      aliases.map((a) => `- \`${a.alias}\` → \`${a.expandsTo}\``).join("\n") +
        "\n"
    );
  }

  console.log("## Config Directories\n");
  const configs = getConfigDirs();
  console.log(configs.join(", ") + "\n");

  console.log("## MCP Servers\n");
  const mcps = getMcpServers();
  if (mcps.length === 0) {
    console.log("No MCP servers configured.\n");
  } else {
    console.log(mcps.map((m) => `- ${m}`).join("\n") + "\n");
  }

  console.log("## Available Skills\n");
  const skills = getSkills();
  if (skills.length === 0) {
    console.log("No skills found.\n");
  } else {
    console.log(
      skills.map((s) => `- **${s.name}** (${s.location})`).join("\n") + "\n"
    );
  }

  console.log("## Summary\n");
  console.log(
    `- ${tools.length} tools installed\n` +
      `- ${aliases.length} shell aliases\n` +
      `- ${configs.length} config directories\n` +
      `- ${mcps.length} MCP servers\n` +
      `- ${skills.length} skills available`
  );
}

main();
