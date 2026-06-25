---
name: mhid
description: Material Design Human Interface Design
---
# Material Human Interface Design (MHID) Specification Document
## I. The MHID Manifesto: Philosophy and Core Principles
### 1.0 Executive Summary and Strategic Advantage
This document serves as the foundational design specification for Material Human Interface Design (MHID), a proprietary system architected to unify two leading philosophies in digital product creation: the structural expressiveness of Google's Material Design 3 (M3) Expressive 1 and the content-forward minimalism and user clarity championed by Apple’s Human Interface Guidelines (HIG).3
#### 1.0.1 Vision
MHID is designed to provide the rigorous component architecture, platform adaptability, and emotional connection inherent in M3 Expressive, while strictly enforcing the high polish, minimalist aesthetic, and low cognitive load characteristic of Apple’s design language.4 This synthesis moves beyond simply adopting components; it defines a new design grammar where content clarity is paramount, and underlying structure is both consistent and highly adaptable. The goal is to create interfaces that feel sophisticated, familiar, and fundamentally user-centric.
#### 1.0.2 Strategic Advantage
The integration of these systems yields a significant competitive advantage. Extensive research on Material Design 3 Expressive indicated a strong user preference for emotionally resonant interfaces, translating to a substantial 34% increase in the perceived "modernity" of the brand.1 However, unrestricted expressiveness can often lead to visual noise and compromised clarity.5
MHID strategically manages this risk by coupling M3’s architectural benefits—such as advanced tokenization, motion physics, and component systems—with HIG’s strict visual minimalism and emphasis on negative space and clean lines.6 By imposing strict constraints on the application of color, shape, and depth, MHID secures the strategic advantage: it achieves the M3 modernization and user delight boost _without_ sacrificing the usability, polish, and operational efficiency inherent in a minimalist, content-focused design. This methodology ensures MHID delivers both emotional resonance and high task completion rates.
### 1.1 MHID Guiding Principles: The Synthesis Equation
MHID operates under three core, synthesized principles that bridge the philosophical divide between M3’s physical material metaphor (stacked components) and HIG’s virtual depth metaphor (window into another world).8
#### 1.1.1 Hierarchy: Content First, Structure Second
The highest purpose of the interface is to serve as an unobtrusive frame for the content.3 All controls and interface elements must be designed to elevate and distinguish the content beneath them.3 This principle demands that hierarchy be established primarily through proximity (generous negative space, which is a key feature of minimalist design 5) and subtle tonal layering (minimalist elevation), not through aggressive use of color, heavy drop shadows, or large, visually distracting elements. The structure must guide the user seamlessly, with navigation systems and related actions consciously grouped to enhance clarity and reduce cognitive load.9
#### 1.1.2 Expressive Subtlety
MHID deliberately limits the visual _presence_ of expressiveness to uphold the design mandate of restraint.10 Direct, bold implementation of M3 Expressive elements, such as highly varied shapes or complex color palettes, is considered excessive and detrimental to the minimalist aesthetic.4 Instead, MHID maximizes the _impact_ of expressiveness by delegating personality primarily to feedback mechanisms and state transitions.
The personality of the design is communicated through the fluidity of interaction, achieved using the physics-based motion system, and selective, constrained personalization, such as the subtle application of Dynamic Color. This approach ensures the interface feels alive and engaging, yet maintains the clean, disciplined aesthetic mandated by the minimalist look. The interface actively communicates state through movement and subtle tonal changes rather than resting on heavy, static ornamentation.11
#### 1.1.3 Harmonic Consistency
The design must feel natural, seamless, and predictable.9 This requires aligning the software interface with the concentric design of the underlying hardware and system experience, ensuring harmony between interface elements, system features, and devices.3
Consistency is mandated by adopting platform conventions wherever beneficial (e.g., native text rendering, scrolling physics, system-level component behavior) and ensuring that the design continuously adapts across window sizes and displays.9 This is achieved by defining the visual identity not through rigid, hardcoded styles, but through the universal application of the MHID Design Token System (MHTS). The use of MHTS tokens allows the visual system to inherit platform-native characteristics while retaining the specific MHID identity. This approach ensures that an MHID application feels "at home" on every platform it supports.12
## II. System Architecture and Implementation Standards
### 2.0 Document Scope and Governance
This document outlines the visual language, interaction guidelines, and technical specifications for MHID foundations and core components.
#### 2.0.1 Target Audience Definitions
This specification is directed at three primary audiences:
1.  **Design Team:** To establish the foundational visual rules necessary for creating new components and maintaining fidelity to the MHID aesthetic.
1.  **Front-End Engineering Team:** To provide the concrete specifications and token hierarchy required for implementation across various frameworks (e.g., React, Flutter, Swift/Compose).4 Developers must prioritize the platform alignment enforced by the token system.13
1.  **Executive Leadership:** To provide a comprehensive blueprint of the product’s user interface strategy and its adherence to the stated synthesis goals.
#### 2.0.2 Governance and Versioning
The MHID Specification Document (DSD) employs Semantic Versioning (Major.Minor.Patch). Any changes to foundational tokens (`mh.ref` or `mh.sys`) necessitate a Major or Minor version increment. All changes must be recorded in the Document History, ensuring clear traceability and change management across development cycles.13 Regular review and updates are mandated to maintain documentation quality and relevance.13
### 2.1 The MHID Design Token System (MHTS)
MHTS is the mandated technical backbone for MHID. Design tokens are defined as name and value pairings that represent small, repeatable design decisions, replacing hardcoded values like hex codes, font sizes, or specific motion durations.15 The use of tokens (`mh.*`) is non-negotiable for all interface development, as it simplifies design and development handover, enables rapid, global theming (e.g., Dark Mode), and is crucial for visual consistency.16
#### 2.1.1 Token Philosophy and Benefits
MHTS adopts the rigorous hierarchical structure defined by Material Design 3, ensuring scalable and maintainable styles.15 By applying a single token update, style changes propagate consistently through an entire product suite, effectively minimizing the finding and replacing of hardcoded values across applications.16
#### 2.1.2 MHID Token Classes
MHTS uses three distinct classes of tokens, each serving a specific purpose in the system architecture 15:
1.  **Reference Tokens (****`mh.ref`****):** These are the static, foundational constants of the system, such as specific color hex codes (e.g., `ref.color.blue.500`) or raw measurement units. They are considered read-only and do not change based on usage context. They represent the entire list of approved visual options available in the system.
1.  **System Tokens (****`mh.sys`****):** These tokens define the abstract roles and contextual properties of the design system. They are mandatory for global properties like surface colors (`sys.color.surface.default`) or standard motion durations (`sys.motion.duration.standard`). System tokens are context-aware; they change their underlying reference value for global modes (e.g., switching to Dark Mode or High Contrast) while their name and role remain constant.
1.  **Component Tokens (****`mh.comp`****):** These tokens assign specific system tokens to individual component properties (e.g., `comp.button.primary.container.color`). This layer provides precise control over component styling and state management, ensuring that even if a system token value changes, its assignment to a component property is tracked consistently.15
#### 2.1.3 Naming Convention Schema (Directive)
MHID mandates a precise, dot-separated naming convention to ensure absolute clarity between design documentation and engineering implementation:
$$
mh.<class>.<category>.<element>.<state>.<property>
$$
_Example:_ `mh.comp.button.primary.hover.color`
#### 2.1.4 Critical Implementation Requirement: Token-for-Platform Mapping
A critical requirement for MHID is the execution of a strategy that links the abstract MHID System Tokens to specific native platform implementations. While M3 Expressive components are often optimized for Google frameworks 4, MHID requires universal harmonic consistency.3
To achieve this, MHTS tokens must function as the semantic layer, defining _intent_ rather than _fixed_ implementation details. Developers are required to map MHID System Tokens (e.g., `mh.sys.color.surface.elevated`) to the native visual equivalent that aligns with the platform's conventions. For example, on Apple platforms, this token might map to a system-defined visual material, such as a transparent or blurred material, which reinforces the "Liquid Glass" effect and seamlessly integrates the interface with the device environment.9 On other platforms, it may map to a pure tonal color shift or a constrained shadow.
This strategy allows the _visual representation_ (the resulting color or effect) to dynamically adjust to the operating system's native conventions, ensuring the MHID app feels aesthetically consistent with the host OS, while the _semantic role_ and _usage intent_ defined by the token name remain consistent across all products.
Table: MHID Token Architecture (MHTS)
|**Class Prefix**|**M3 Equivalence**|**MHID Role**|**Developer Action**|**Alignment**|
|---|---|---|---|---|
|`mh.ref`|Reference tokens|Static, foundational constants (colors, sizes).|Read-only; Defines approved values.|HIG (Strict, Pure Definition)|
|`mh.sys`|System tokens|Contextual, role-based definitions (primary color, surface).|Required for global properties (surfaces, text color).|M3 (Adaptability, Theming) 15|
|`mh.comp`|Component tokens|Specific element styling and state assignment.|Required for component customization and state management.|Synthesis (Handoff Clarity)|
## III. Visual Foundations: The Minimalist Aesthetic
### 3.1 Color Palette and Tonal Application
MHID utilizes the expressive color roles defined by Material Design but imposes severe constraints on their deployment to maintain clarity and minimalism.7 The strategy focuses on using color for purpose and meaning, not decoration.
#### 3.1.1 The Minimalist Color Mandate
MHID mandates that the interface defaults to a reserved, neutral palette for 90% of all interface elements (Surfaces, Backgrounds, Primary Text). Expressive color is a limited resource, reserved exclusively for the following functional roles: primary calls-to-action (CTAs), navigational indicators (selected state), critical status communication (e.g., error states), and data visualization.5 This restraint strengthens the visual impact of the chosen colors when they are finally deployed.7
#### 3.1.2 Dynamic Color Usage (Synthesized Restraint)
Material Design 3 Expressive features dynamic theming, tailoring UI color palettes based on user wallpapers for a personalized experience.10 MHID permits this functionality but strictly limits its influence to prevent the interface from becoming visually chaotic. Dynamic color must _only_ impact the `mh.sys.color.primary` token and associated tonal surface tokens. Crucially, the system requires fixed, high-contrast, neutral text colors for content, ensuring that legibility is never compromised by an unpredictable primary color derived from the user’s theme. This ensures personalization without sacrificing the core HIG principle of clarity.
#### 3.1.3 Accessibility and Contrast
All color role assignments are built upon M3’s accessible color pairings, which algorithmically ensure adequate contrast between surfaces and content.17 MHID mandates strict adherence to WCAG AA standards. Designers must audit all custom `mh.comp` token assignments to ensure a minimum 4.5:1 contrast ratio for text and 3:1 for graphical elements, guaranteeing legibility for all users.18
Table: MHID Approved Color Roles and Usage Intent
|**M3 Role (Base)**|**MHID Usage Intent**|**Constraint (Minimalism)**|**Exception for Expressiveness**|
|---|---|---|---|
|Primary|High-emphasis CTA; Core branding element.|Must be used sparingly (maximum one prominent primary action per screen).|Permitted to be dynamically themed.|
|Secondary|Supporting, non-critical actions; Component state differentiation.|**Restricted.** Defaults to a subtle tonal variant of Primary or a Neutral tone.|Used for specific, subtle iconography or background elements that need distinction.|
|Tertiary|Accents, personality, decorative flourishes.|**Prohibited in general interface.**|Only for non-functional illustrations, data visualization, or complex charts to aid data parsing.|
|Surface|Backgrounds, containers, content cards.|Heavily utilized for establishing elevation hierarchy.|Must maintain high contrast with Text/On-Surface tokens.18|
### 3.2 Typography and Readability
Typography is treated as a core expressive element within MHID, tasked with conveying information with maximum clarity and legibility.7
#### 3.2.1 Hierarchical Type Scale
MHID adopts a robust typographic hierarchy, leveraging the structured scale definitions (Display, Headline, Title) found in M3 guidance.19 This hierarchy, enforced via `mh.sys.typography` tokens, must clearly distinguish content types, aligning directly with the HIG principle of establishing visual hierarchy.3
#### 3.2.2 Minimalist Font Strategy
To eliminate visual noise and focus user attention, MHID strictly limits the number of font families to one primary brand typeface and one system fallback font.5 The design should maximize clarity by emphasizing generous line height and ample negative space between blocks of text and individual components, which are foundational features of effective minimalist interfaces.7
#### 3.2.3 Scalability Requirement
The type scale must be systematically responsive and scalable. Text must be able to resize without breaking the layout, directly addressing accessibility requirements for text accommodation and legibility.18
### 3.3 Shape and Form
#### 3.3.1 Unified Geometry
To achieve visual harmony and high polish, all components and containers must utilize a consistent, subtle corner radius scale. Excessive rounding or irregular geometric variation, which can be symptomatic of highly expressive M3 implementations, is strictly prohibited. The geometry must align with the general concentric design of the underlying hardware.9
#### 3.3.2 Tokenized Shape Scale
A constrained set of component tokens for radii must be defined (`mh.shape.corner.s`, `mh.shape.corner.m`, `mh.shape.corner.l`). The maximum permissible radius size is constrained to prevent visually distracting, fully circular elements, which are only sanctioned for specific, high-emphasis components like the Floating Action Button (FAB).
## IV. Spatial Language: Elevation and Material
MHID defines its spatial relationship and depth model using **Purposeful Tonal Layering**. This approach is crucial to synthesize the two dimensional models: it rejects the heavy shadow defaults associated with traditional Material Design depth 8 in favor of a subtle, content-blending depth that aligns with HIG’s preference for transparent or blurred materials.8
### 4.0 MHID Depth Model: Tonal Elevation
MHID treats the interface as having infinite depth (HIG perspective 8) that is only subtly revealed through light and tone, not aggressive physical stacking cues. To enforce minimalism while preserving the structural integrity offered by M3’s elevation system, tonal contrast is defined as the primary visual indicator of elevation.21 Shadows are limited to providing subtle, ambient context, maximizing clarity and minimizing the visual noise of overlapping surface edges.5
#### 4.1 Elevation Token Mapping and Constraints
MHID utilizes the M3 six-level elevation system (0 to +5 dp) but rigorously constrains its use to ensure visual discipline.22 Elevation tokens (`mh.sys.elevation`) codify distance on the z-axis, allowing platforms to determine the specific shadow or tonal values.22
#### 4.1.1 Resting State Constraint
To reduce visual distraction and maintain high clarity 5, MHID strictly enforces a maximum of two resting elevation levels above the base surface (`elev.level.0`): `elev.level.1` and `elev.level.2`. Levels +3, +4, and +5 are reserved exclusively for focus states, user interaction (hover/drag), and transient elements like dialogs or system alerts.21
#### 4.1.2 Shadow Specifications
When shadows are employed to depict elevation, they must be highly constrained. MHID mandates that shadows be smaller and sharper to indicate a close proximity of the elevated surface to the background plane.21 This creates the perception of a subtle lift, aligning with the fluid, "liquid glass" metaphor of modern interfaces 9, rather than the thick, distinct layer separation of traditional stacking models.
Table: MHID Elevation Synthesis Map
|**MHID Token (dp)**|**M3 Equivalence**|**Primary Visual Depiction**|**Shadow Specification (Constrained)**|**Usage Mandate**|
|---|---|---|---|---|
|`elev.level.0` (0dp)|Baseline|Base Surface Color (Neutral)|No Shadow|Background, Stationary Content|
|`elev.level.1` (+1dp)|Small lift|Subtle Tonal Shift (+2% Surface tone)|Minimal, sharp shadow (Close proximity)|Static Toolbars, Content Cards at rest|
|`elev.level.2` (+2dp)|Medium lift|Moderate Tonal Shift (+4% Surface tone)|Small, diffused shadow|Elevated Buttons, Modals, Primary Nav Rail|
|`elev.level.3` (+4dp)|Focused state|Strong Tonal Shift (+6% Surface tone)|Medium, soft shadow|Hover/Focus State, Context Menus|
|`elev.level.4` (+5dp)|Highest priority|Distinct Tonal Shift + Scrim|Large, soft shadow (Max distance)|Dialogs, System Alerts, Draggable Elements|
||||||
## V. Interaction Language: Motion and Feedback
MHID leverages the fluid, expressive capabilities of M3's motion physics system while strictly adhering to HIG principles that motion must be purposeful and non-distracting, quickly guiding the user to the destination.8
### 5.0 Motion Philosophy: Physics Meets Purpose
The philosophical goal for MHID motion is to be **Fast, Fluid, and Functional**. M3 Expressive introduces complex, often emphasized motion curves that provide a sense of life and physical interaction.2 However, the default durations often exceed the optimal time for a swift, non-distracting experience (e.g., M3 Emphasized at 500ms).25
To reconcile this, MHID utilizes the _Expressive curves_ (for rich fluidity and substantial feel) but enforces _shorter durations_ (for efficiency and subtlety). The subtle "bounce" or "spring" of Expressive curves imbues feedback with necessary personality and weight, making interactions feel substantial, but the reduced duration ensures the animation is swift and efficient, fulfilling the HIG requirement that motion support the experience without overshadowing it.23
#### 5.0.2 Motion Tokenization
All animation properties, including easing curves (e.g., Decelerate, Accelerate) and durations, must be defined and applied using component tokens (e.g., `mh.motion.duration.standard`, `mh.motion.easing.decelerate`). This tokenization ensures global changes to motion timing can be applied rapidly to maintain a consistent speed-of-interaction across the entire system.
### 5.1 Required Transition Specifications
MHID mandates four core transition patterns, prioritizing speed and clarity over prolonged visual flair.25
Table: MHID Standard Motion Tokens and Specs
|**Transition Type**|**MHID Easing Token**|**M3 Base Curve (For Fluidity)**|**MHID Duration Standard**|**HIG Alignment**|
|---|---|---|---|---|
|**Screen Entry (Decelerate)**|`mh.motion.easing.enter`|Standard Decelerate|250ms|Seamless guidance, quick visual acquisition.|
|**Screen Exit (Accelerate)**|`mh.motion.easing.exit`|Standard Accelerate|150ms|Rapid, non-distracting dismissal.25|
|**Component Feedback**|`mh.motion.easing.expressive`|Expressive Default Effects|200ms|Immediate, substantial feedback feel.24|
|**Full System Transition**|`mh.motion.easing.spatial`|Standard Default Spatial|350ms|Cleanly reinforce spatial relationships between views.|
#### 5.1.3 Accessibility Requirement (Critical)
In alignment with HIG best practices, motion must never be gratuitous or excessive, as it can distract users or cause physical discomfort.23 Furthermore, motion cannot be the sole mechanism for communicating critical information. Developers must ensure that system preferences for "Reduce Motion" or equivalent accessibility settings are fully respected. When this preference is active, the `mh.motion.easing` and `mh.motion.duration` tokens must default to linear or zero-duration opacity changes, maintaining functionality without movement.
## VI. Component Specifications and Patterns
MHID components utilize the robust component architecture provided by the M3 system but apply MHID foundational tokens to strictly enforce the minimalist aesthetic, content-first hierarchy, and efficiency goals.
### 6.1 Action Components (Buttons)
#### 6.1.1 Inverted Emphasis Hierarchy
Material Design typically designates Filled or Elevated buttons as high-emphasis primary actions.27 However, strict minimalism demands visual restraint, ensuring that the interface is not overloaded with highly prominent elements.5
To satisfy the minimalism requirement, MHID implements an **Inverted Emphasis Hierarchy** for standard action components. The goal is to substantially reduce the visual prominence of the default action state, ensuring that when the highest-emphasis visual style _is_ used, its impact is maximized.
The MHID default for **medium-emphasis** actions (the most common type) will be the **Tonal Button** or the **Outlined Button**. These components utilize subtle color or elevation cues but avoid the overwhelming visual weight of a fully filled shape. The traditional M3 **Filled** or **Elevated Button** is strictly reserved for the **High-Emphasis** category—specifically for critical, final transactional actions (e.g., ‘Confirm Purchase,’ ‘Finalize Submission’) where visual command is essential. This measured constraint preserves clarity and directs the user's attention precisely when and where it is needed.27
Table: MHID Button Visual Emphasis Redefinition
|**MHID Emphasis Level**|**M3 Component Type Used**|**MHID Visual Style**|**Usage Mandate**|
|---|---|---|---|
|High|Filled Button (Primary Color)|Minimal Corner Radius, Subtly Elevated (+2dp)|Reserved only for critical, irreversible actions (maximum one high-emphasis button per screen).27|
|Medium (Default)|Tonal Button or Outlined Button|Uses subtle tonal fill or outline; Base elevation (+1dp)|Primary action for standard tasks; Default prominence to maintain low visual noise.|
|Low|Text Button or Icon Button|No fill, no elevation (0dp)|Supplementary, optional actions; Used heavily for clarity and simplified navigation.5|
### 6.2 Navigation Patterns
MHID defines a responsive navigation shell that seamlessly adapts to different viewports, synthesizing the robust M3 system with HIG's emphasis on simplicity and guided structure.
#### 6.2.1 The MHID Navigation Shell
The standard global navigation component defines behavior based on the available screen width:
1.  **Mobile/Small Viewports:** The component uses a horizontal **Bottom Navigation Bar** (M3). This adheres to the HIG philosophy that apps should simplify navigation, ideally offering five or fewer core functions, which improves comprehension and usability on small screens.8
1.  **Tablet/Desktop/Wide Viewports:** The system automatically transitions to the vertical **Navigation Rail** (M3) on the leading edge of the window.28 The navigation rail must utilize the `mh.sys.elevation.level.1` token (subtle tonal shift) to distinguish it from the main content surface. This ensures that the global structure is immediately clear, supporting the Hierarchy principle.
#### 6.2.2 Contextual Navigation
For secondary, in-app navigation that manages view state, MHID strongly prefers the minimalist **Segmented Control** (influencing the adoption of HIG patterns). This preference is based on the superior clarity and simplicity of segmented controls over complex Material tab systems when the number of options is limited, furthering the goal of clarity.9
## VII. Governance, Accessibility, and Future Roadmap
### 7.0 Accessibility Standards and Implementation
MHID mandates that accessibility is not an optional feature but a foundational requirement, demanding compliance with WCAG 2.1 AA standards across all interface elements.18
#### 7.0.1 Perceivable Content
The system must ensure all content is perceivable through multiple channels. This includes mandatory use of semantic markup for screen readers, comprehensive Alt Text for images, and adherence to the tokenized color contrast requirements defined in Section 3.1.3.
#### 7.0.2 Operable Interface
Interfaces must be operable and navigable by all users. All components must support full keyboard navigation. Focus indicators are critical for keyboard users; MHID mandates that these indicators (subtle, high-contrast outlines or rings) must be defined and visible, overriding any M3 defaults that might rely solely on subtle tonal changes for the focus state.18 This ensures keyboard users can effectively interact with and navigate the interface.
### 7.1 Cross-Platform and Future Adaptation
#### 7.1.1 Cross-Platform Toolkit Recommendation
While the MHID specification is framework-agnostic, successful implementation requires engineering teams to prioritize modern development toolkits (such as Flutter, Jetpack Compose, or SwiftUI) that natively support the architecture of the M3 component system and, crucially, token-based styling. The MHTS architecture is specifically designed to streamline the handover and implementation process across diverse platforms.4
#### 7.1.2 Future Readiness (Spatial UI)
The MHID architecture is intentionally structured to be forward-compatible with emerging interaction paradigms, specifically spatial user interfaces (AR/VR/Foldables) supported by M3 Expressive.2
The MHID focus on **Tonal Elevation** and subtle materials (echoing the "Liquid Glass" metaphor 9) is a deliberate strategic architectural choice. Interfaces defined primarily by tonal changes and constrained elevation tokens are inherently better suited for translation into dynamic 3D spatial layouts than interfaces relying on opaque, hard-edged material sheets. This disciplined approach ensures that the design system can easily scale and adapt to new input methods and three-dimensional environments by simply remapping the underlying reference values of the established `mh.sys.elevation` tokens, preparing the company for the next generation of computing experiences.2
## VIII. Conclusions and Actionable Recommendations
The Material Human Interface Design (MHID) specification successfully resolves the core design challenge of blending Google’s structural expressiveness with Apple’s minimalist clarity. The system’s robustness lies in its architectural discipline, enforced by the MHTS token system.
The immediate actionable recommendation for development teams is the **mandatory adoption and strict utilization of the MHID Design Token System (MHTS)**, particularly the defined system and component tokens. Implementation success hinges on the technical execution of the **Token-for-Platform Mapping** strategy, ensuring that visual tokens dynamically resolve to native OS conventions to achieve Harmonic Consistency.12
For design teams, the key directive is adherence to the **Minimalist Color Mandate** and the **Inverted Emphasis Hierarchy** for action components. This restraint ensures that MHID products leverage the emotional impact of M3 Expressive while maintaining the disciplined focus on content and usability that characterizes highly polished minimalist applications. The combination of M3's physics-based motion with constrained durations provides a substantial, yet swift, user experience, positioning MHID as a design system optimized for both modern aesthetic preference and operational efficiency..
[](5e823674-0762-4743-af83-6f8aa02513e4)


