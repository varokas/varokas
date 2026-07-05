# Minimal Engineering — Design System

The visual language for varokas.com. **Spec sheet**: the site reads like a
well-set engineering document — one type family (IBM Plex) in three voices,
hairline rules, monospace annotations, a steel-blue accent, and
language-tagged code slabs.

## Principles

1. **One family, three voices.** Everything is IBM Plex: Sans for prose,
   Mono for annotations and code, Sans Thai for Thai text. Don't introduce
   other typefaces.
2. **Metadata is annotation.** Dates (ISO `YYYY-MM-DD`), read times, tags,
   and section labels are always Plex Mono, small, and muted — like margin
   notes on a drawing.
3. **One accent, spent carefully.** Steel blue marks links, the signature
   rule, and nothing else.
4. **The short rule is the signature.** A 2.5rem × 2px accent stroke,
   centered, renders every `<hr>` inside posts as a quiet section break.
   Use it only there — not as an underline on labels or the wordmark —
   and don't introduce other dividers or ornaments.

## Color tokens

Both palettes live on `:root` and flip automatically via
`prefers-color-scheme`. Never hard-code a hex in components — use the token.

| Token              | Light      | Dark       | Use |
|--------------------|------------|------------|-----|
| `--paper`          | `#FAF9F5`  | `#201E1B`  | Page background |
| `--ink`            | `#1E1C18`  | `#E8E4DC`  | Body text, headings |
| `--muted`          | `#5D594F`  | `#A19B90`  | Metadata, captions, secondary text |
| `--line`           | `#E5E2D9`  | `#383630`  | Hairline borders |
| `--accent`         | `#2D5F7E`  | `#85B5CF`  | Links, signature rule |
| `--inline-code-bg` | `#EFECE2`  | `#2C2A25`  | Inline code chips |

Code slabs are a **soft warm graphite** in both themes — dark enough for
contrast, several steps up from black so they don't punch holes in the page.
Only the two backgrounds shift slightly in dark mode:

| Token          | Light      | Dark       | Use |
|----------------|------------|------------|-----|
| `--code-bg`    | `#36332B`  | `#2B2925`  | Code slab background |
| `--code-tab`   | `#2D2A24`  | `#24221E`  | Language tab strip |
| `--code-ink`   | `#EDE9DF`  | same       | Default code text |
| `--code-muted` | `#A8A193`  | same       | Comments (italic), shell prompts, tab label |
| `--syn-kw`     | `#9CC7E2`  | same       | Keywords, tags (steel — matches accent family) |
| `--syn-str`    | `#E3C083`  | same       | Strings, attributes (amber) |
| `--syn-num`    | `#A8D3B5`  | same       | Numbers, constants (green) |

## Typography

Loaded from Google Fonts: `IBM Plex Sans` (400/500/600 + 400 italic),
`IBM Plex Mono` (400/500), `IBM Plex Sans Thai` (400/500/600 — subsetted,
only downloads on pages with Thai text).

| Role | Stack |
|------|-------|
| Sans (prose + headings) | `"IBM Plex Sans", "IBM Plex Sans Thai", system-ui, sans-serif` |
| Mono (metadata + code) | `"IBM Plex Mono", ui-monospace, SFMono-Regular, Menlo, monospace` |

### Scale

| Style | Size / line-height | Weight | Notes |
|-------|--------------------|--------|-------|
| Post title | `clamp(1.8rem, 4.5vw, 2.5rem)` / 1.15 | 600 | `letter-spacing: -0.02em`; deliberately modest — technical docs don't shout |
| Post h2 | `1.35rem` / 1.25 | 600 | |
| Post h3 | `1.125rem` / 1.3 | 600 | |
| Body | `1.0625rem` / 1.7 | 400 | 17px; drops to 16px under 40rem |
| Wordmark | `0.9rem` mono | 500 | Uppercase, `letter-spacing: 0.09em` |
| Meta / labels | `0.8rem` mono | 400–500 | Labels uppercase, `letter-spacing: 0.08em` |
| Inline code | `0.88em` mono | 400 | Relative so it tracks context |
| Code blocks | `0.9375rem` / 1.7 mono | 400 | Fixed size, on the graphite slab |
| Language tab | `0.7rem` mono | 400 | Uppercase, `letter-spacing: 0.08em` |

## Layout

- Content measure: `42rem`, centered, `1.25rem` side padding.
- Header: mono uppercase wordmark left, mono uppercase nav right, hairline
  bottom border; the signature rule sits under the wordmark.
- Vertical rhythm: sections separated by `4rem`+; in-post blocks by `1.5rem`.
- No cards, no shadows; only code slabs and images get a small radius
  (6px / 4px).

## Components

- **Section label** (`.section-label`): mono, uppercase, muted, with the
  signature rule beneath. Used for "Latest", "Archive", tag headers.
- **Post eyebrow** (`.post-eyebrow.meta`): `2026-06-27 · 3 min read ·
  macos ssh homelab` — ISO date, read time, linked tags, all mono, above
  the title. Tags live here, not in a footer.
- **Post card** (`.post-card`): sans title (1.25rem/600) → excerpt →
  mono meta line. No border; spacing separates cards.
- **Archive row** (`.archive-row`): baseline-aligned title + dotted leader +
  mono date. Years are mono `h3`s hanging in the left margin on wide screens.
- **Code slab** (`div.highlighter-rouge`): the wrapper div is the rounded
  graphite container; fenced blocks with a known language get a `::before`
  tab strip naming it (`bash`, `python`…). Plaintext/mermaid/klipse blocks
  get a plain slab. Add new languages as
  `.post-content div.language-X::before { content: "X"; }`.
- **Tag pill** (`.tag`): mono lowercase, hairline border, no fill. Used on
  the tag index (with an accent count), not on posts.
- **Post nav** (`.post-nav`): older/newer links at the foot of a post, mono
  labels + sans titles.
- **hr in prose**: rendered as the centered signature rule.
- **Blockquote**: accent left rule, muted text, no italics.
- **Ghost cards** (`.kg-bookmark-*`, `.kg-image-card`): legacy embeds from
  the Ghost migration — keep styled, hairline border, no shadow.

## Motion & accessibility

- Only transition `color`/`border-color` on hover (120ms). No entrance
  animations. Honor `prefers-reduced-motion` if anything animated is added.
- Visible `:focus-visible` outline (2px accent) on all interactive elements.
- Skip-to-content link is the first focusable element.
- Both palettes keep body text ≥ 7:1 contrast, muted text ≥ 4.5:1; syntax
  colors ≥ 4.5:1 on the graphite slab.
