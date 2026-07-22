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
- Render code on a light neutral surface with dark ink and sufficient contrast.
- Keep error and warning annotations legible with restrained red and amber rules.
- Use literal expand/collapse language: `open dbt version` and `close dbt version`.

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
