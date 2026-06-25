---
name: encase-design
description: encase is a design system for the web
---

# Encase
## 1. Executive Summary
We are moving away from subtle gradients and soft shadows. The new component library (attached above) represents the launch of "JEMO CORE," a design language built on absolute contrast, industrial containment, and tactical clarity.
This system is not just about "dark mode"; it is about maximizing readability and creating a UI that feels heavy, reliable, and unapologetic.
## 2. Core Philosophy: "The Tactical Monolith"
Jemo Core is defined by three pillars:
* Binary Contrast: We communicate in absolutes. If it's not Black (#000000), it's White (#FFFFFF). Gray is a utility, not a personality.
* Hard Containment: Every element lives in a defined space. We do not use whitespace alone to separate content; we use thick, deliberate borders to "crate" information.
* Softened Industrial: While our contrast is harsh, our geometry is approachable. We use consistent rounded corners to prevent the interface from feeling too aggressive or sharp.
## 3. Visual Specifications
### A. The "Onyx" Palette
Our palette is monochromatic. Color is reserved for content (images), never for structure.
* True Black (Component Fill): #000000. Used for Navbars, Sidebars, Modals, and Primary Buttons.
* Stark White (Text/Borders): #FFFFFF. Used for text on black backgrounds and the defining 2px-3px borders.
### B. Typography: "Loud & Clear"
* Headers & Labels: All structural text (Nav items, Button labels, Modal headers) is UPPERCASE and BOLD. This denotes architecture.
* Body Copy: Sentence case is reserved strictly for user feedback and descriptions (e.g., the modal body text).
* Font Family: A geometric Sans-Serif (e.g., Montserrat, Roboto, or similar) that maintains legibility at high weights.
### C. The "Container" Rule (Borders & Radius)
* Borders are Mandatory: Every interactive component (Nav, Sidebar, Buttons, Inputs) must have a high-contrast border.
	* Black components get White borders.
	* White components get Black borders.
* Corner Radius: We utilize a medium radius (~8px to 12px). It is large enough to look friendly but small enough to maintain structural integrity. No pill shapes for large containers.
## 4. Component Taxonomy
### Navigation (The "Command Center")
The Navbar and Sidebar are not just lists of links; they are control panels.
* State: Active states are denoted by a high-contrast inversion (e.g., the "HOME" tab in the sidebar uses a dark grey/lighter black fill to show depth).
* Branding: The JEMO LIFE logo is always prominent, encased in its own "plaque."
* Actions (Buttons)
* Primary Action: Solid Black Fill + White Text + White Border. (High prominence).
* Secondary Action: White Fill + Black Text + Black Border. (Alternate path).
* Destructive/Cancel: White Fill + Black Text + Thick Borders.
### Feedback (Modals & Alerts)
* Modals: These are "interruptive." They take over the screen with a massive black header bar. The "CONFIRM ACTION?" text size is intentionally oversized to prevent user error.
* Toasts/Alerts: Floating black tiles with white iconography. They look like physical notifications or "stickers" applied to the screen.
### 5. Implementation Directives

* Icons: Use filled or heavy-stroke glyphs. No thin-line icons. They must match the weight of the typography.
* Spacing: maintain tight padding inside the containers, but generous margins outside them. The components are heavy; give them room to breathe.



