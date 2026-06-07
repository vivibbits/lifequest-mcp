# Skill: GPT Image Prompt Writer

Turn a rough idea into a detailed, production-ready prompt for GPT Image 2 (or any AI image generator). No image is generated — the output is a polished text prompt the user can copy and use anywhere.

---

## When to Activate

Activate this skill when the user:
- Describes an image they want to create
- Says "write me a prompt for...", "make a prompt for...", "I want an image of..."
- Has a visual idea but doesn't know how to phrase it for AI image tools

Do NOT call any image generation API. Output only the prompt text.

---

## Process

### Step 1 — Identify the category

| Category        | Typical User Request                                  |
|-----------------|-------------------------------------------------------|
| E-commerce      | Product photo, packaging shot, lifestyle product      |
| Ad / Campaign   | Banner, poster, brand campaign, social media ad       |
| Portrait        | Person, character, model, headshot, lifestyle scene   |
| Poster          | Event poster, movie poster, travel poster, editorial  |
| Character       | OC, game character, reference sheet, mascot           |
| UI / Mockup     | App screen, social media post mockup, web design      |
| Illustration    | Art piece, concept art, scene, watercolor, anime      |

### Step 2 — Clarify if needed (optional, only if the idea is very vague)

Ask one short question to unlock critical details:
- **Product:** "What's the product and what mood — clean/minimal or dramatic/luxury?"
- **Portrait:** "Real photo style or illustrated? Any specific setting or vibe?"
- **Poster:** "What's the subject and what format — vertical, horizontal, square?"

Skip clarification if the idea already has enough detail.

### Step 3 — Build the prompt

Use this structure:

```
[Subject] + [Environment/Setting] + [Lighting] + [Composition] + [Style/Aesthetic] + [Quality modifiers]
```

Always include:
- Specific subject description (not just "a bottle" but "a dark amber glass perfume bottle")
- At least one lighting descriptor
- A style/aesthetic tag
- Quality closer: `photorealistic`, `4K`, `cinematic`, `editorial quality`, etc.

### Step 4 — Output format

Return exactly this:

```
Here's your prompt:

---
[THE PROMPT]
---

**Tips to adjust it:**
- To make it [more dramatic] → add "deep shadows, moody contrast"
- To make it [more minimal] → add "white background, clean composition"
- To change style → swap [current style tag] with [alternative]
```

---

## Prompt Templates by Category

### E-Commerce Product

```
A [product description] placed on [surface/environment]. [Surrounding props if any].
[Lighting: e.g. soft studio lighting / dramatic side light / golden hour glow].
[Composition: e.g. centered / rule of thirds / flat lay].
[Aesthetic: e.g. luxury commercial photography / minimal lifestyle / editorial].
Photorealistic, 4K, high detail.
```

**Example output:**
> A dark amber glass perfume bottle placed on a white marble surface, surrounded by dried rose petals and a single gold ring. Soft directional studio lighting with a warm glow on the glass. Centered composition, shallow depth of field. Luxury commercial photography aesthetic. Photorealistic, 4K.

---

### Advertising / Campaign

```
A [format: poster / banner / ad] for [product or brand]. [Hero visual description].
[Color palette]. [Mood/tone: bold / elegant / playful / cinematic].
[Typography placement if needed: tagline space at bottom / logo top-left].
[Aesthetic: high-fashion editorial / streetwear urban / minimalist luxury].
[Aspect ratio if relevant: vertical 9:16 / horizontal 16:9 / square].
```

**Example output:**
> A luxury watch advertisement poster. A sleek chronograph watch centered on a polished obsidian surface, dramatic side lighting, deep shadows. Black and silver color palette. Tagline space at the bottom. High-end commercial photography, cinematic quality. Vertical 9:16.

---

### Portrait / Photography

```
A [style: cinematic portrait / street photo / fashion editorial] of [subject description].
[Setting/environment]. [Lighting: Rembrandt / golden hour / studio strobe / natural].
[Camera feel: 35mm film grain / sharp digital / CCD vintage aesthetic].
[Mood/expression]. [Composition: close-up / mid-shot / rule of thirds].
[Avoid: no watermark, no plastic skin, no overexposure].
```

**Example output:**
> A cinematic portrait of a young woman in a vintage denim jacket standing on a rain-wet city street at night. Neon reflections on the pavement behind her. Rembrandt lighting on her face, soft bokeh background. 35mm film grain, warm color grading. Mid-shot, subject slightly off-center. No watermark, no plastic skin.

---

### Poster / Illustration

```
A [type: travel poster / movie poster / event poster / art print] for [subject].
[Visual technique: double-exposure / silhouette / layered collage / painterly].
[Color palette: e.g. muted earth tones / neon on black / pastel watercolor].
[Composition rule: S-curve / centered hero / dynamic diagonal].
[Typography notes if any: title at top, subtitle below].
[Format: vertical 9:16 / horizontal 16:9].
```

**Example output:**
> A vintage-modern travel poster for Kyoto. Double-exposure technique layering a torii gate silhouette with cherry blossom branches. Muted rose and ink-blue color palette. S-curve composition, title "KYOTO" in clean serif font at the top. Vertical 9:16 format.

---

### Character Design

```
A [type: character reference sheet / key visual / concept art] for [character description].
[Art style: anime / Pixar 3D / pixel art / ink illustration].
[Pose or layout: front-facing / dynamic action / 4-view reference sheet].
[Color palette and clothing details].
[Background: white background / atmospheric environment / transparent].
[Quality: professional game art / anime key visual quality].
```

**Example output:**
> An official character reference sheet for a teenage girl mage. Anime style, clean line art. Four views: front, 3/4, side, back. White background. Wearing a deep purple cloak with gold trim, silver staff in hand. Warm amber hair, green eyes. Flat colors with subtle shading. Professional game art quality.

---

### UI / Mockup

```
A [type: mobile app screen / social media post mockup / web UI / live stream overlay].
[Platform or context if relevant: iOS dark mode / Instagram square / Twitch overlay].
[Content visible on screen: describe key UI elements].
[Design style: glassmorphism / flat minimal / brutalist / neumorphic].
[Color theme]. [Realistic device frame: yes/no].
```

**Example output:**
> A realistic iPhone mockup showing a dark-mode fitness tracking app. Home screen with a circular progress ring for daily steps, weekly chart below, and a bottom navigation bar. Glassmorphism cards, deep navy and electric blue color theme. Clean sans-serif typography. Device frame visible, screen-only focus.

---

## Style Modifier Cheat Sheet

Append any of these to strengthen a prompt:

| Goal              | Add This                                                      |
|-------------------|---------------------------------------------------------------|
| More cinematic    | `cinematic lighting, anamorphic lens, film grain, movie still`|
| More luxurious    | `luxury editorial, high-end commercial, Hasselblad quality`   |
| More dramatic     | `deep shadows, moody contrast, dramatic side lighting`        |
| More minimal      | `white background, clean composition, negative space`         |
| Vintage/film look | `35mm film, CCD aesthetic, analog grain, muted color grade`   |
| Anime/illustrated | `anime style, clean line art, studio Ghibli warmth, 2D flat`  |
| Photorealistic    | `photorealistic, 4K, ultra HD, no CGI feel`                   |
| Dark/moody        | `noir aesthetic, deep blacks, single light source`            |

---

## Source

Prompt patterns sourced from:
**[awesome-gpt-image-2-API-and-Prompts](https://github.com/EvoLinkAI/awesome-gpt-image-2-API-and-Prompts)** — 706+ production prompts, CC0 license.
