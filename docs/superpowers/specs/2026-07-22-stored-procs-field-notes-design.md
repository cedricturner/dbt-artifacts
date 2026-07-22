# Stored procedures field-notes alternate design

## Goal

Create a separate alternate preview of the stored-procedures walkthrough that feels like a clean notebook drawing: generous white space, near-black lines, and forms defined by outlines rather than fills. The result should feel personal and lightly unfinished without becoming hard to read or resembling a themed sketchbook.

The existing `redesign-preview.html` remains unchanged as the baseline. The alternate will be a new standalone HTML file beside it.

## Visual system

### Color

- Paper: `#ffffff`
- Primary ink: `#171717`
- Secondary ink: `#4a4a4a`
- Quiet rule: `#d8d8d4`
- Faint guide: `#eeeeea`
- Accents: reserved for architecture categories, errors, and dbt-specific meaning

Most interface elements use paper and ink only. Accent colors must communicate a distinction; they are not decoration. Surfaces remain white unless a code editor or semantic state requires otherwise.

### Type

- Inter for headings, navigation, explanations, labels, and controls
- Space Mono for SQL, Jinja, YAML, filenames, line numbers, and other code-like content
- No handwriting or sketchbook fonts
- Existing lowercase conventions remain in place except for names and acronyms

### Line language

Thin lines define the interface. Borders, paths, arrows, dividers, and architecture nodes use slightly varied curves or offsets so they feel drawn, but never wobble enough to hurt precision. Boxes are outlines rather than shaded cards. Rounded corners are subtle and inconsistent only where the SVG path itself creates them, not through ornamental CSS effects.

## Page structure

The page keeps its title, introduction, seven-step walkthrough, language toggle, and bottom navigation. The information architecture and all existing copy and interactions remain intact.

The seven tabs become a connected path. Step labels sit along a thin near-black route that changes direction as it moves through the sequence. The active step uses full ink; completed steps use secondary ink; future steps use the quiet rule. The route wraps into a deliberate multi-row path on narrow screens rather than compressing into an unreadable row.

The active section appears below the path with generous vertical space. A short opacity transition may be used when switching sections. Reduced-motion preferences disable it.

## Component treatments

### Architecture diagrams

Nodes use white interiors with colored outlines and matching dark labels. Connectors remain thin. Accent colors distinguish architecture roles such as ingestion, warehouse, dbt, semantic layer, and reporting. No shadows, gradients, or broad tinted backgrounds are used.

### Explanatory callouts

Callouts become plain text beside a short vertical ink line. Status-specific callouts may change the line color, but the background stays white. Labels state one idea and avoid decorative icons.

### Code editors

Code remains visually separate from the notebook treatment so it feels pasted from a real editor. It keeps Space Mono, line numbers, SQL and Jinja syntax coloring, readable comments, and visible error rows. The editor uses a precise rectangular boundary and does not inherit hand-drawn line effects.

### Comparisons

Two-column comparisons use open columns separated by one vertical rule. On narrow screens they stack and use a horizontal rule. Content is not enclosed in cards.

### Expandable examples

Expandable rows use a baseline rule and a plain `+` or `−` control. Expanded content opens directly below the row without a filled container. Existing click behavior and keyboard focus remain available.

### Timelines and execution bars

Execution visuals use thin outlined tracks and solid accent strokes instead of filled bars. Labels remain outside or above tracks where possible so color never carries meaning alone.

## Responsive behavior

- Desktop uses the meandering connected path and broad white margins.
- Tablet reduces horizontal gaps while preserving the path shape and readable labels.
- Mobile turns the path into a vertical route with steps placed alternately to its left and right.
- Wide code and SVG content may scroll horizontally inside their own regions; the page itself must not overflow.
- Tap targets remain at least 44 pixels even when their visible marks are small.

## Accessibility and interaction safeguards

- Text and meaningful line colors meet WCAG AA contrast against white.
- Accent categories also use labels, so color is never the only differentiator.
- All interactive controls retain visible keyboard focus.
- Existing language switching, tab navigation, expand/collapse behavior, and previous/next controls continue to work.
- The original live page and the existing redesign preview are not modified by this alternate.

## Verification

Automated checks will confirm:

- the alternate file exists and the baseline preview is unchanged;
- all seven panels and navigation steps remain present;
- the connected-path navigation styles and responsive vertical route exist;
- Inter and Space Mono retain their assigned roles;
- SQL/Jinja syntax classes and error treatments remain present;
- no handwriting font, gradient, or box shadow is introduced;
- interactive functions and language switching remain present;
- HTML/JavaScript syntax checks and whitespace checks pass.

Visual review will confirm that the page reads as white space plus line work, that accent colors are semantic and restrained, and that the result feels intentional rather than incompletely styled.
