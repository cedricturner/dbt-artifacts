# Raw directory index preview

## Goal

Create a standalone HTML preview that reinterprets the dbt artifacts homepage as an intentionally raw, monochrome folder of personal notes. It should feel like Cedric left useful explainers in a folder for other people to find, while remaining immediately understandable and easy to navigate.

The existing `index.html` and every existing destination remain unchanged.

## Audience and job

The page is for people browsing Cedric Turner's dbt explainers. Its single job is to let a visitor scan the collection and open one of the six existing walkthroughs.

## Visual direction

- Use an off-white background, near-black text, and neutral grays only.
- Use Inter for headings, descriptions, instructions, and navigation text.
- Use a system monospace stack only for filenames and small file-like metadata.
- Present the collection as a raw file-server index rather than cards.
- Avoid gradients, icons, shadows, rounded corners, decorative color, and ornamental animation.
- Make hover and keyboard focus unmistakable by inverting a complete row from light to black.
- Keep the page precise and spacious enough to evoke Notion without adopting Notion's polished component styling.
- Prefer literal, plain-language labels over file-server jargon or cryptic interface language.

## Content and structure

1. A compact utility line reading `Cedric Turner · shared notes`.
2. A plain title: `dbt notes and explainers`.
3. A direct first-person note explaining why the collection exists and telling visitors to open any topic below.
4. A literal instruction heading: `Open an explainer`.
5. Six linked rows using the real destinations from the current homepage:
   - `dbt-vs-stored-procs/`
   - `dbt-vs-notebooks/`
   - `dbt-connection-modes/`
   - `dbt-ai-llm/`
   - `dbt-wizard/`
   - `dbt-state/`
6. Each row includes a readable topic name, its underlying filename, a plain description of what it explains, and its approximate duration.
7. Column labels use `Topic`, `What it explains`, and `Time`.
8. A subdued source link and the note `These were sitting in a folder, so I put them here.` appear in the footer.
9. Do not use ambiguous file-server jargon such as `READ-ONLY`, `0 loose files`, or `EOF`.

## Interaction and responsive behavior

- Each full row is clickable and preserves the existing relative URL.
- Rows invert on hover and `:focus-visible`.
- The layout uses semantic HTML and remains navigable by keyboard.
- On narrow screens, metadata wraps beneath the filename and description without horizontal scrolling.
- Reduced-motion preferences are respected; the design does not require motion.

## Deliverable and verification

- Add one standalone preview file named `raw-directory-index.html` at the repository root.
- Do not modify or replace the current homepage.
- Verify that all six relative links resolve to existing directories.
- Verify the file is valid enough to render locally at desktop and mobile widths.
- Launch the preview in the user's default browser after verification.
