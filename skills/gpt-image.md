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

**Example 1 — Perfume / Beauty:**
> A dark amber glass perfume bottle placed on a white marble surface, surrounded by dried rose petals and a single gold ring. Soft directional studio lighting with a warm glow on the glass. Centered composition, shallow depth of field. Luxury commercial photography aesthetic. Photorealistic, 4K.

**Example 2 — Food & Beverage:**
> A cinematic hero shot of a gourmet beef burger on a dark slate board. Sesame bun, melted cheddar, crispy lettuce, and a glistening tomato slice visible. Dramatic overhead lighting with wisps of steam rising. Dark moody background, shallow depth of field. Editorial food photography, ultra-HD.

**Example 3 — Tech Product:**
> Premium wireless earbuds in an open matte-black charging case, placed on a brushed aluminum surface. Clean white side lighting, subtle reflection below. Minimal composition with generous negative space on the right for text. Tech product photography, 4K, photorealistic.

**Example 4 — Fashion / Lifestyle:**
> A sustainable white organic cotton t-shirt laid flat on a light oak surface. Accompanied by eucalyptus sprigs, a small succulent, and a folded linen swatch. Soft natural window light from the left. Flat lay composition. Eco-conscious lifestyle aesthetic, clean and airy, photorealistic.

**Example 5 — Miniature Diorama Ad:**
> A miniature diorama advertisement for a luxury skincare cream. The product jar sits at the center of a tiny world: a microscopic spa scene with towels, candles, and a tiny fountain. Tilt-shift macro photography, pastel color palette, dreamy soft light. Whimsical yet premium commercial aesthetic, 4K.

---

### Advertising / Campaign

```
A [format: poster / banner / ad] for [product or brand]. [Hero visual description].
[Color palette]. [Mood/tone: bold / elegant / playful / cinematic].
[Typography placement if needed: tagline space at bottom / logo top-left].
[Aesthetic: high-fashion editorial / streetwear urban / minimalist luxury].
[Aspect ratio if relevant: vertical 9:16 / horizontal 16:9 / square].
```

**Example 1 — Luxury Watch:**
> A luxury chronograph watch advertisement poster. The watch centered on a polished obsidian surface, dramatic single-source side lighting, deep shadows falling behind. Black, charcoal, and silver color palette. Tagline space reserved at the bottom. High-end commercial photography, cinematic quality. Vertical 9:16.

**Example 2 — Sneaker / Streetwear:**
> A bold streetwear sneaker campaign poster. White high-top sneaker floating against a graffiti-textured concrete wall background. Neon yellow accent lighting, dynamic diagonal composition. Urban, energetic, Gen-Z aesthetic. Brand logo space top-left. Vertical 9:16.

**Example 3 — Fragrance Campaign:**
> A luxury fragrance campaign portrait. A woman in a flowing ivory silk dress standing in a sun-drenched Mediterranean courtyard with trailing bougainvillea. Golden hour lighting, soft bokeh background, warm skin tones. High-fashion editorial photography, Vogue-quality composition. Horizontal 16:9.

**Example 4 — Food Brand Poster:**
> A vibrant acai bowl product advertisement. Overhead flat-lay of a deep purple acai bowl topped with fresh strawberries, blueberries, granola, and a drizzle of honey. Bright natural lighting, clean white linen surface. Lifestyle food photography, fresh and energetic mood. Square 1:1 format.

**Example 5 — Dark Chocolate Brand:**
> A premium dark chocolate brand campaign. A broken square of glossy dark chocolate on a textured black stone surface, surrounded by scattered cocoa nibs and a dusting of cocoa powder. Moody side lighting with a single warm highlight on the chocolate's surface. Deep, rich color palette — black, deep brown, gold. Luxury editorial aesthetic, 4K.

---

### Portrait / Photography

```
A [style: cinematic portrait / street photo / fashion editorial] of [subject description].
[Setting/environment]. [Lighting: Rembrandt / golden hour / studio strobe / natural].
[Camera feel: 35mm film grain / sharp digital / CCD vintage aesthetic].
[Mood/expression]. [Composition: close-up / mid-shot / rule of thirds].
[Avoid: no watermark, no plastic skin, no overexposure].
```

**Example 1 — Cinematic Street Portrait:**
> A cinematic portrait of a young woman in a vintage denim jacket standing on a rain-wet city street at night. Neon reflections shimmering on the pavement behind her. Rembrandt lighting on her face, soft bokeh background. 35mm film grain, warm color grading. Mid-shot, subject slightly off-center. No watermark, no plastic skin.

**Example 2 — Analog / CCD Lifestyle:**
> A candid lifestyle photograph of a man in his 30s reading a book at an outdoor café, coffee cup on the table. Late afternoon sunlight casting long shadows. CCD camera aesthetic, slightly desaturated warm tones, natural grain. Unposed, authentic moment. Documentary street photography style.

**Example 3 — High Fashion Editorial:**
> A high-fashion editorial photograph of a model in an oversized structured blazer and wide-leg trousers, posing against a stark white seamless backdrop. Studio strobe lighting with strong shadows. Selective desaturation — muted tones except for a single red accessory. Vogue editorial quality, clean and bold.

**Example 4 — Anime / Illustrated Portrait:**
> An anime-style portrait of a teenage girl with long silver hair and amber eyes, wearing a school uniform, standing at a window with soft afternoon light filtering through. Studio Ghibli-inspired warmth and detail. Clean line art, painterly background, expressive face. 2D illustration, no photographic elements.

**Example 5 — Watercolor Fashion Sketch:**
> A watercolor fashion illustration of a woman in a flowing floral summer dress. Loose, expressive brushwork, soft color bleeds, white paper texture visible. Pastel pink, sage green, and cream palette. Editorial fashion sketch aesthetic, hand-crafted feel.

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

**Example 1 — Travel Poster:**
> A vintage-modern travel poster for Kyoto. Double-exposure technique layering a torii gate silhouette with cherry blossom branches. Muted rose and ink-blue color palette. S-curve composition, title "KYOTO" in clean serif font at the top, subtitle "Japan" below. Vertical 9:16 format.

**Example 2 — Movie Poster:**
> A cinematic movie poster for a fictional sci-fi thriller titled "ECLIPSE". A lone astronaut silhouette standing on a barren moon surface, a massive ringed planet looming in the sky behind them. Deep space blues and purples, single dramatic light source. Tagline space at the bottom, credit block below. Hollywood blockbuster poster aesthetic.

**Example 3 — Cultural / Ink Art Poster:**
> A Chinese ink-wash art poster featuring a misty mountain landscape with a lone pine tree on a cliff. Traditional brush strokes, monochrome with hints of deep red for a stamp seal motif. Minimalist negative space composition. Vertical scroll format, elegant and serene.

**Example 4 — Science Infographic Poster:**
> A museum-quality science infographic poster illustrating the life cycle of a monarch butterfly. Four labeled stages arranged in a circular flow diagram — egg, caterpillar, chrysalis, butterfly. Clean hierarchical layout, detailed scientific illustration style. Blue, cream, and orange color palette. A4 vertical format.

**Example 5 — Event Poster:**
> A bold music festival poster for a fictional electronic music event "NEON PULSE". Abstract geometric light beams radiating from a central point over a dark background. Electric blue, magenta, and white color palette. Festival name in large blocky display font at center, lineup names in smaller type below. High energy, rave aesthetic. Vertical 9:16.

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

**Example 1 — Anime Reference Sheet:**
> An official character reference sheet for a teenage girl mage. Anime style, clean line art. Four views: front, 3/4, side, back. White background. Wearing a deep purple cloak with gold trim, silver staff in hand. Warm amber hair, green eyes. Flat colors with subtle shading. Professional game art quality.

**Example 2 — Persona-Style Card:**
> A Persona5-style character introduction card for a rebellious high school student. Bold diagonal composition, red and black color scheme with splashes of white. Character in a dynamic leaning pose, sharp shadows. Stat bars on the right side, name in stylized angular font at the top. Tarot card proportions, vertical format.

**Example 3 — 3D Stylized Character:**
> A 3D stylized skater character in Pixar meets Into the Spider-Verse style. Teenage boy with a backwards cap, oversized hoodie, and beat-up sneakers, mid-kickflip on a skateboard. Vibrant street-art color palette — orange, teal, deep purple. Exaggerated expressive proportions, dynamic motion blur on wheels. Studio lighting, clean render, white background.

**Example 4 — Mascot Design Sheet:**
> An 18-panel mascot character design document for a friendly robot mascot named "Bleep". Grid layout 6×3. Panels show: full body front, full body back, head closeup, 6 facial expressions (happy, sad, surprised, angry, winking, thinking), 3 action poses, 2 product interaction poses, color palette swatch, logo usage example. Flat vector illustration style, consistent line weight, brand colors: sky blue and white.

**Example 5 — Pixel Art Concept:**
> A pixel art game concept board for a 16-bit RPG. Scene shows a forest village at dusk with wooden cottages, lanterns glowing warm yellow, a market stall, and a cobblestone path. Two pixel characters visible: a knight and a merchant. Rich, detailed pixel art in the style of classic SNES JRPGs. 16:9 format, dark atmospheric mood.

---

### UI / Mockup

```
A [type: mobile app screen / social media post mockup / web UI / live stream overlay].
[Platform or context if relevant: iOS dark mode / Instagram square / Twitch overlay].
[Content visible on screen: describe key UI elements].
[Design style: glassmorphism / flat minimal / brutalist / neumorphic].
[Color theme]. [Realistic device frame: yes/no].
```

**Example 1 — Mobile App:**
> A realistic iPhone mockup showing a dark-mode fitness tracking app. Home screen with a circular progress ring for daily steps, weekly bar chart below, and a tab navigation bar at the bottom. Glassmorphism card style, deep navy and electric blue color theme. Clean sans-serif typography. Device frame visible, no reflections.

**Example 2 — Social Media Post Mockup:**
> A realistic Instagram post mockup for a minimalist coffee brand. Square 1:1 format. Flat lay of a white ceramic coffee cup on a linen surface with a sprig of rosemary and scattered coffee beans. Warm neutral tones, soft natural light. Brand handle "@brandname" in top-left corner, engagement icons at the bottom. Phone screen frame surrounding the post for context.

**Example 3 — Live Stream Overlay:**
> A gaming live stream UI overlay design for a fantasy RPG streamer. Dark semi-transparent panels, health/mana bar styled as potion bottles in the top-left, chat box on the right with a medieval scroll texture, subscriber count displayed as a glowing crystal. Deep forest green and gold color theme. Clean readable typography for alerts.

**Example 4 — Web Landing Page Mockup:**
> A dark-mode marketing website landing page mockup for an AI SaaS product. Hero section with a bold headline, gradient CTA button in purple and blue, and a floating product dashboard preview below. Navigation bar at top. Grid of 3 feature cards below the fold. Glassmorphism elements, modern tech startup aesthetic. Desktop 16:9 format.

**Example 5 — Japanese Digital Ad Grid:**
> A 4-panel Japanese digital ad grid in a 2×2 layout. Each panel is a different product category: top-left = travel (Mt. Fuji at sunrise), top-right = skincare (serum bottle on marble), bottom-left = food (ramen bowl with steam), bottom-right = education (open books and stationery). Consistent clean design language, Japanese typography, soft pastel borders separating panels. Square overall format.

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
