# Skill: GPT Image Generation

Generate professional images via the GPT Image 2 API (EvoLink AI wrapper). Covers text-to-image, image editing, and iterative refinement — sourced from 706+ production-ready prompts across 7 categories.

---

## Trigger Phrases

The agent should activate this skill when the user asks to:
- Generate, create, make, or produce an image
- Design a poster, ad, banner, product shot, portrait, UI mockup, or illustration
- Edit, retouch, or modify an existing image
- Use GPT Image, DALL-E, or AI image generation

---

## API Reference

### Endpoint

```
POST https://api.evolink.ai/v1/images/generations
```

### Authentication

```
Authorization: Bearer <EVOLINK_API_KEY>
Content-Type: application/json
```

### Request Body

```json
{
  "model": "gpt-image-2",
  "prompt": "<your detailed prompt>",
  "n": 1,
  "size": "1024x1024",
  "quality": "high",
  "response_format": "url"
}
```

| Parameter         | Values                                              | Default      |
|-------------------|-----------------------------------------------------|--------------|
| `model`           | `gpt-image-2`                                       | required     |
| `prompt`          | string (detailed description)                       | required     |
| `n`               | 1–4                                                 | `1`          |
| `size`            | `1024x1024`, `1792x1024`, `1024x1792`               | `1024x1024`  |
| `quality`         | `standard`, `high`                                  | `standard`   |
| `response_format` | `url`, `b64_json`                                   | `url`        |

### Quick cURL Example

```bash
curl --request POST \
  --url https://api.evolink.ai/v1/images/generations \
  --header 'Authorization: Bearer YOUR_API_KEY' \
  --header 'Content-Type: application/json' \
  --data '{
    "model": "gpt-image-2",
    "prompt": "A cinematic product photo of wireless earbuds on a matte black surface with soft studio lighting, 4K, photorealistic",
    "n": 1,
    "size": "1024x1024",
    "quality": "high"
  }'
```

### NPM Quick-Start

```bash
npx evolink-gpt-image -y
```

---

## Capabilities

| Feature                      | Description                                                    |
|-----------------------------|----------------------------------------------------------------|
| Text-to-image               | Generate photorealistic images, illustrations, UI mockups      |
| Image editing               | Inpainting, outpainting, style transfer on existing images     |
| Multi-turn refinement       | Iteratively adjust output via follow-up instructions           |
| High-fidelity text          | Accurate text rendering within generated images                |
| Character consistency       | Maintain consistent characters across multiple generations     |
| Aspect ratio support        | Portrait, landscape, and square outputs                        |
| Batch generation            | Up to 4 images per request (`n` parameter)                     |
| Transparency                | PNG output with alpha channel when needed                      |

---

## Prompt Engineering Patterns

### Universal Structure

```
[Subject description] + [Environment/setting] + [Lighting] + [Composition] + [Style/aesthetic] + [Technical specs]
```

**Example:**
> A luxury perfume bottle placed on a white marble surface, surrounded by dried flowers, backlit by warm golden light, centered composition with shallow depth of field, photorealistic commercial photography, 4K

### Style Modifiers (append to any prompt)

| Goal           | Modifier to Add                                               |
|----------------|---------------------------------------------------------------|
| Photorealistic | `photorealistic, 4K, studio quality, commercial photography`  |
| Cinematic      | `cinematic lighting, film grain, anamorphic lens, movie still`|
| Editorial      | `high-fashion editorial, Vogue aesthetic, Hasselblad quality` |
| Anime/Illustration | `anime style, clean line art, vibrant colors, 2D illustration`|
| Minimalist     | `minimal design, white background, clean composition`         |
| Vintage/Film   | `35mm film, CCD camera, grain, analog color grading`          |
| Dark/Moody     | `dark mode, deep shadows, dramatic contrast, noir aesthetic`  |

### Negative Prompts (what to avoid)

Append to prompt as: `...avoid: [terms]`

- Portrait quality: `no plastic skin, no watermark, no overexposure, no blurriness`
- Product shots: `no distracting backgrounds, no lens flare, no overprocessing`
- UI mockups: `no Lorem ipsum, no placeholder content, no low-res icons`

---

## Use Case Categories & Example Prompts

### 1. E-Commerce Product Photography

**Perfume / Beauty**
```
A high-end perfume bottle photographed on a white marble surface with soft, 
directional studio lighting. Surrounded by dried rose petals and gold leaf. 
Shallow depth of field, photorealistic, luxury commercial aesthetic, 4K.
```

**Food & Beverage**
```
A cinematic hero shot of a gourmet burger on a dark wooden board. Sesame bun, 
melted cheddar, crispy lettuce visible. Dramatic top-down lighting with steam 
rising, dark moody background, editorial food photography, ultra-HD.
```

**Tech Products**
```
Premium wireless earbuds in an open charging case on a matte black surface. 
Soft white side lighting, minimal composition, tech product infographic style, 
clean background, photorealistic, 4K.
```

**Fashion**
```
A sustainable white t-shirt laid flat on a light oak surface with eucalyptus 
sprigs, small succulents, and a linen swatch. Natural daylight, eco-conscious 
lifestyle aesthetic, minimalist composition.
```

**Miniature Diorama Format** *(high engagement for ads)*
```
A miniature diorama advertisement for [PRODUCT]. The product sits at the center 
of a tiny, impossibly detailed world. Soft macro photography, tilt-shift effect, 
pastel color palette, playful and premium.
```

---

### 2. Advertising & Brand Campaigns

**Luxury Watch Ad**
```
A luxury chronograph watch advertisement. Watch centered on polished obsidian 
surface, dramatic side lighting, deep shadows, silver and black color palette. 
Tagline space at bottom. High-end commercial photography, cinematic quality.
```

**Sneaker / Streetwear Poster**
```
A bold streetwear sneaker poster. Sneaker floating against a graffiti-textured 
background, neon accent lighting, dynamic diagonal composition. 
Urban, energetic, Gen-Z aesthetic. 9:16 portrait orientation.
```

**Fragrance Campaign Portrait**
```
A luxury fragrance campaign portrait. Model in a flowing silk dress in a 
sun-drenched Mediterranean courtyard. Golden hour lighting, soft bokeh 
background, editorial fashion photography, Vogue-quality composition.
```

**9-Panel TVC Storyboard**
```
A 9-panel TVC storyboard for [BRAND]. Grid layout 3×3, each panel showing 
a different scene of the campaign. Clear visual progression, consistent 
color palette [COLOR], brand logo placement visible, clean typography.
```

---

### 3. Portraits & Photography

**Cinematic Portrait**
```
A cinematic portrait of a [DESCRIPTION] person. Shot on 35mm film, slight 
grain texture, warm color grading. Subject positioned off-center per rule of 
thirds. Dramatic Rembrandt lighting. Raw, authentic emotion.
```

**Street Photography**
```
Candid street photography style. [SUBJECT] in a busy urban environment. 
CCD camera aesthetic, natural colors, midday sunlight creating harsh shadows. 
Documentary, unposed, authentic moment.
```

**Anime/Illustrated Portrait**
```
Anime-style character portrait of [DESCRIPTION]. Clean line art, vibrant 
color palette, expressive eyes, detailed hair. Studio Ghibli-inspired warmth. 
2D illustration, no photography elements.
```

**Fashion Editorial**
```
High-end fashion editorial photograph. Model wearing [OUTFIT DESCRIPTION] 
in [SETTING]. Studio strobe lighting, selective color treatment, luxury brand 
aesthetic. Minimal retouching, editorial quality.
```

---

### 4. Poster & Illustration Design

**City/Travel Poster**
```
A vintage-modern travel poster for [CITY]. Double-exposure technique layering 
iconic landmarks with local culture. S-curve composition, [COLOR PALETTE]. 
Clean sans-serif typography at top and bottom. 9:16 vertical format.
```

**Movie Poster Style**
```
A cinematic movie poster for a fictional [GENRE] film titled "[TITLE]". 
Hero character silhouette against a dramatic sky. Tagline space at bottom, 
credit block area. Hollywood poster aesthetic, moody color grading.
```

**Science Infographic**
```
A museum-quality science infographic illustrating [TOPIC]. Clean hierarchical 
layout, labeled diagrams, consistent icon system, educational tone. 
Blue and white color palette, professional scientific illustration style.
```

---

### 5. Character Design

**Character Reference Sheet**
```
An official character reference sheet for [CHARACTER NAME]. Four views: 
front, 3/4, side, back. Clean line art, flat colors, labeled clothing and 
accessories. Anime style, white background, professional game-art quality.
```

**Persona5-Style Character Card**
```
A Persona5-style character introduction card for [CHARACTER]. Diagonal 
composition, bold graphic elements, red and black color scheme. Character 
in dynamic pose, stat bars on the right, name in stylized font at top.
```

**3D Stylized Character**
```
A 3D stylized character in Pixar/Into the Spider-Verse style. [CHARACTER 
DESCRIPTION] in a dynamic skateboarding pose. Vibrant street-art color 
palette, expressive exaggerated proportions, studio lighting, clean render.
```

---

### 6. UI & Social Media Mockups

**App UI Design System**
```
A complete mobile app design system for a [APP TYPE] application. Dark mode 
interface, component library visible including buttons, cards, and navigation 
bars. Consistent design language, modern glassmorphism aesthetic.
```

**Social Media Post Mockup**
```
A realistic Instagram post mockup for [BRAND]. Square format 1:1, product 
hero shot with minimal text overlay. Aesthetic consistent with [BRAND STYLE]. 
Phone screen frame surrounding the post for context.
```

**Live Stream UI Overlay**
```
A live stream UI overlay mockup for a gaming channel. Dark transparent panels, 
chat box on the right, viewer count and donation alerts styled as game UI 
elements. Consistent color theme [COLOR], clean typography.
```

---

## Multi-Turn Refinement Examples

Once you have an initial image, guide iteration with:

```
"Make the background darker and add more dramatic shadows"
"Change the color palette to warm earth tones"
"Add the company logo to the bottom right corner"
"Make it more minimal — remove the background clutter"
"Shift the style from photorealistic to watercolor illustration"
"Adjust composition: move subject to left third of frame"
```

---

## Integration Notes for Hermes / MCP

When this skill is used through the LifeQuest MCP bridge:

1. **Tool name to call:** `generate_image` (or as exposed by LifeQuest API manifest)
2. **Key argument:** `prompt` — always expand user intent into a detailed prompt using the patterns above before calling the API
3. **Enhance sparse prompts:** If a user says "make me a cat image", expand it to include lighting, style, composition, and quality modifiers
4. **Return the image URL** from the API response to the user
5. **Offer to refine:** After each generation, ask if the user wants to adjust style, composition, or content

### Prompt Expansion Template (agent-internal)

```
User says: "[BRIEF REQUEST]"

Expanded prompt:
"[Subject with specific details] in [environment/setting], [lighting description], 
[composition rule], [style aesthetic], [quality modifiers]"
```

---

## Environment Variable Required

```
EVOLINK_API_KEY=<your key from evolink.ai>
```

Get an API key at: https://evolink.ai (registration required)

---

## Source

Prompts and patterns sourced from:
**[awesome-gpt-image-2-API-and-Prompts](https://github.com/EvoLinkAI/awesome-gpt-image-2-API-and-Prompts)**  
706+ production-ready prompts · CC0 License · 7 categories · 11 languages
