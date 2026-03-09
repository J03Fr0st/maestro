---
name: frontend-design
description: >
  Build distinctive, production-grade frontend interfaces with exceptional aesthetic quality. Use
  this skill whenever the user says "make it look good", "UI design", "CSS styling", "visual polish",
  "responsive layout", "build a landing page", "create a component", "style this", "beautify",
  "make it pretty", or "design a page". Make sure to use this skill whenever the user mentions
  building web UI, styling components, or creating visually polished interfaces, even if they
  don't explicitly ask for design guidance.
---

# Frontend Design

Build distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

## Workflow

1. **Understand requirements** -- what the interface does, who uses it, and any technical constraints (framework, performance, accessibility)
2. **Choose an aesthetic direction** -- commit to a bold, intentional design direction before writing code
3. **Implement** -- build working code (HTML/CSS/JS, React, Vue, etc.) that is production-grade and visually striking
4. **Refine** -- polish spacing, transitions, edge cases, and responsiveness until every detail feels intentional

## Design Thinking

Before coding, commit to a BOLD aesthetic direction:

- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick a strong direction: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc.
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work -- the key is intentionality, not intensity.

## Output Format

- For **single components** (button, card, modal): deliver a single file with the component code and its styles.
- For **pages or layouts**: deliver the page component plus any sub-components, organized by framework conventions (e.g., React component files, or a single HTML file for vanilla).
- For **full applications**: organize into a standard project structure with clear separation of components, styles, and logic.

Include inline comments explaining non-obvious design decisions (e.g., why a specific animation timing was chosen).

## Aesthetics Guidelines

### Typography

Choose fonts that are beautiful, unique, and characterful. Pair a distinctive display font with a refined body font.

Avoid generic defaults (Arial, Inter, Roboto, system fonts) -- these signal "no design thought was given."

Example pairings:
- **Editorial**: Playfair Display + Source Serif Pro
- **Modern tech**: Space Mono + DM Sans
- **Luxury**: Cormorant Garamond + Montserrat
- **Playful**: Fredoka One + Nunito
- **Brutalist**: JetBrains Mono + Archivo Black

Vary font choices across projects. Do not converge on the same fonts repeatedly.

### Color & Theme

Commit to a cohesive palette. Use CSS variables for consistency. A dominant color with sharp accents outperforms a timid, evenly-distributed palette.

Example palette structures:
- **Monochrome + accent**: all grays with a single vivid accent (electric blue, hot coral)
- **Analogous warmth**: amber, rust, cream -- feels organic and grounded
- **High contrast dark**: near-black backgrounds with neon or pastel highlights
- **Muted pastels**: soft lavender, sage, blush -- feels calm and modern

Avoid the cliched purple-gradient-on-white look.

### Motion & Animation

Prioritize CSS-only solutions for HTML. Use Motion library for React when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals creates more delight than scattered micro-interactions.

Use scroll-triggering and hover states that surprise.

### Spatial Composition

Use unexpected layouts: asymmetry, overlap, diagonal flow, grid-breaking elements. Generous negative space OR controlled density -- both work when intentional.

### Backgrounds & Textures

Create atmosphere and depth rather than defaulting to solid colors. Consider gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, and grain overlays.

## Avoid Generic AI Aesthetics

Avoid these patterns because they signal "generated, not designed":
- Overused font families (Inter, Roboto, Arial)
- Purple gradients on white backgrounds
- Predictable card grids with uniform spacing
- Cookie-cutter component patterns without context-specific character

Interpret creatively. Make unexpected choices that feel genuinely designed for the context. No two designs should look the same.

Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations. Minimalist designs need restraint, precision, and careful attention to spacing and typography.

## Examples

### Example 1: Hero Section (Brutalist aesthetic)

```html
<section style="
  background: #0a0a0a;
  color: #f5f5f0;
  font-family: 'Archivo Black', sans-serif;
  padding: 8rem 2rem;
  border-bottom: 8px solid #ff3e00;
">
  <h1 style="
    font-size: clamp(3rem, 10vw, 8rem);
    line-height: 0.9;
    text-transform: uppercase;
    letter-spacing: -0.03em;
    max-width: 900px;
  ">
    Break<br>the<br>rules.
  </h1>
  <p style="
    font-family: 'JetBrains Mono', monospace;
    font-size: 0.875rem;
    margin-top: 3rem;
    max-width: 400px;
    opacity: 0.7;
  ">
    Design systems are guardrails, not cages.
    Build interfaces that people remember.
  </p>
</section>
```

### Example 2: Pricing Card (Soft/pastel aesthetic)

```html
<div style="
  background: linear-gradient(135deg, #fdf2f8, #ede9fe);
  border-radius: 24px;
  padding: 2.5rem;
  max-width: 340px;
  font-family: 'Nunito', sans-serif;
  box-shadow: 0 8px 32px rgba(0,0,0,0.06);
">
  <span style="
    font-family: 'Fredoka One', cursive;
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: #a855f7;
  ">Most Popular</span>
  <h3 style="font-size: 1.75rem; margin: 0.5rem 0; color: #1e1b4b;">Pro Plan</h3>
  <p style="font-size: 2.5rem; font-weight: 800; color: #7c3aed;">
    $29<span style="font-size: 1rem; font-weight: 400; color: #6b7280;">/mo</span>
  </p>
  <ul style="list-style: none; padding: 0; margin: 1.5rem 0; color: #4b5563;">
    <li style="padding: 0.5rem 0; border-bottom: 1px solid rgba(0,0,0,0.05);">Unlimited projects</li>
    <li style="padding: 0.5rem 0; border-bottom: 1px solid rgba(0,0,0,0.05);">Priority support</li>
    <li style="padding: 0.5rem 0;">Custom domains</li>
  </ul>
  <button style="
    width: 100%;
    padding: 0.875rem;
    background: #7c3aed;
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 1rem;
    font-weight: 700;
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
  " onmouseover="this.style.transform='translateY(-2px)';this.style.boxShadow='0 4px 16px rgba(124,58,237,0.4)'"
     onmouseout="this.style.transform='';this.style.boxShadow=''">
    Get Started
  </button>
</div>
```

Remember: Claude is capable of extraordinary creative work. Commit fully to a distinctive vision.
