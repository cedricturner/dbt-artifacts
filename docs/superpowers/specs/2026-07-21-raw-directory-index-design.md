# Raw directory index preview

## Goal

Create a standalone HTML preview that reinterprets the dbt artifacts homepage as an intentionally raw, monochrome directory listing. It should feel minimally rendered and slightly cryptic while remaining immediately understandable and easy to navigate.

The existing `index.html` and every existing destination remain unchanged.

## Audience and job

The page is for people browsing Cedric Turner's dbt explainers. Its single job is to let a visitor scan the collection and open one of the six existing walkthroughs.

## Visual direction

- Use an off-white background, near-black text, and neutral grays only.
- Use a restrained serif for the directory title and a system monospace stack for filenames, metadata, and utility text.
- Present the collection as a raw file-server index rather than cards.
- Avoid gradients, icons, shadows, rounded corners, decorative color, and ornamental animation.
- Make hover and keyboard focus unmistakable by inverting a complete row from light to black.
- Keep the page precise and spacious enough to evoke Notion without adopting Notion's polished component styling.

## Content and structure

1. A compact utility line identifying the page as `INDEX`.
2. A directory title: `/cedric/dbt-artifacts/`.
3. A small `README.txt` passage that explains the collection in plain language.
4. Six linked directory rows using the real destinations from the current homepage:
   - `dbt-vs-stored-procs/`
   - `dbt-vs-notebooks/`
   - `dbt-connection-modes/`
   - `dbt-ai-llm/`
   - `dbt-wizard/`
   - `dbt-state/`
5. Each row includes its existing short description and compact type/duration metadata.
6. A subdued source link in the footer.

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

