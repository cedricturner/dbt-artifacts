# Stored procedures artifact redesign preview

## Goal

Create a standalone redesign preview of `dbt-vs-stored-procs/index.html` that extends the approved raw, lowercase navigation language across the complete interactive walkthrough.

The live artifact remains unchanged. The preview is added as `dbt-vs-stored-procs/redesign-preview.html`.

## Content and behavior

- Preserve all seven walkthrough sections and their order.
- Preserve expandable code translations, debugging scenarios, previous/next navigation, and English/Japanese switching.
- Preserve every existing explainer destination and the link back to the main navigation page.
- Write English interface headings and labels in lowercase except for names and acronyms such as SQL, ETL, BI, EN, and dbt product names that require their existing case.

## Visual system

- Use the navigation page's off-white paper, black ink, neutral gray text, and thin ruled structure.
- Use Inter for headings, explanations, buttons, and navigation.
- Use Space Mono for SQL, YAML, filenames, step numbers, and file-like metadata.
- Remove rounded dark cards, gradients, shadows, and ornamental animation.
- Show the seven sections as a ruled file index. The active section inverts to black with white text.
- Keep red and green only where they communicate a stored-procedure problem versus a dbt improvement.

## Code and callout treatment

- Match the verified `supercontext` context/compute callouts: white background, `1.5px solid #e8e5e0` border, `16px 18px` internal padding, and no shadow.
- Use small lowercase Space Mono labels above code or comparison content.
- Render code as a dbt-style light editor: white canvas, pale gutter, visible gray line numbers, faint indentation guides, and dark identifiers.
- Apply syntax colors that mirror the provided dbt editor reference: blue SQL keywords and aliases, purple Jinja delimiters, teal-blue dbt functions, burnt-orange strings, and gray comments.
- Use a thin filename/header rail instead of pills or decorative card chrome.
- Keep error and warning annotations legible with restrained red and amber rules.
- Use literal expand/collapse language: `open dbt version` and `close dbt version`.

## Editorial cleanup

- Remove emoji-led hints.
- Remove pill-shaped badges and decorative state treatments.
- Reduce nested full-border callouts; use spacing and a single left rule for explanatory summaries.
- Keep all existing instructional content, but make its visual hierarchy quieter so the walkthrough reads as an authored technical note rather than a stack of generated UI cards.

## Responsive and accessibility requirements

- Preserve semantic buttons and keyboard navigation.
- Maintain visible focus states.
- Stack two-column comparisons on narrow screens.
- Allow code blocks and diagrams to scroll horizontally without forcing the full page wider than the viewport.
- Respect reduced-motion preferences.

## Verification

- Confirm the live `dbt-vs-stored-procs/index.html` is unchanged.
- Confirm the preview includes seven navigation steps, both language controls, all seven panels, Space Mono, the context/compute callout tokens, and the existing interaction functions.
- Open the preview in the user's default browser.
