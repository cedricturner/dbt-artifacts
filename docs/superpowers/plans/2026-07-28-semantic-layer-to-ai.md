# Semantic Layer to AI Explainer Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Redesign the existing `dbt-ai-llm/` explainer into one seven-step journey that compares semantic-layer choices first and shows governed AI consumption second.

**Architecture:** Keep the existing single-file HTML/CSS/JavaScript architecture and canonical URL. Repurpose `renderStep0()` through `renderStep6()`, keep the static navigation shell, and render a permanent source list below the dynamic step container so inline footnotes always have valid targets. Preserve the uncommitted Japanese dictionary in source, but hide the language control until the redesigned content has complete Japanese coverage.

**Tech Stack:** Static HTML, CSS, vanilla JavaScript, inline SVG/HTML diagrams, POSIX shell tests with `rg`, GitHub Pages.

## Global Constraints

- Keep the canonical URL `dbt-ai-llm/`; do not create a standalone semantic-layer directory.
- Keep exactly seven top-level steps.
- Keep the page title **From Data to Conversation**.
- Match the published `dbt-vs-stored-procs/` field-notes CSS: `#fafaf9` paper, `#1c1c1c` ink, `#e8e5e0` rules, Inter body type, Space Mono technical type, left-aligned editorial header, square ruled navigation, and no gradients or shadows.
- Use `net_revenue` by `region` as the one recurring metric example.
- Launch the redesigned page in English first.
- Preserve the existing uncommitted Japanese dictionary and localization functions; do not expose the Japanese control in the English-first build.
- Use numbered inline footnotes plus a permanent, dated primary-source list reading `Sources checked July 28, 2026`.
- Give dbt, Databricks, and Snowflake conditional recommendations; do not declare a universal winner.
- Mark every example result and business value as illustrative.
- Remove visible roadmap language, future dates, unsupported entitlement claims, and absolute accuracy or efficiency claims.
- Preserve unrelated working-tree changes.

---

### Task 1: Add a failing contract test for the redesigned explainer

**Files:**
- Create: `tests/semantic-layer-to-ai.test.sh`
- Inspect only: `dbt-ai-llm/index.html`
- Inspect only: `index.html`

**Interfaces:**
- Consumes: the current static-page structure and the approved spec at `docs/superpowers/specs/2026-07-27-semantic-layer-to-ai-design.md`
- Produces: one executable shell contract test used by every later task

- [ ] **Step 1: Record the existing localized work before editing**

Run:

```bash
git diff -- dbt-ai-llm/index.html
rg -n 'var AI_TR=|window.setLangAI|日本語|lang-toggle' dbt-ai-llm/index.html
```

Expected: the diff shows the existing English/Japanese work, and all four localization markers are present. Do not stage or alter this diff in this task.

- [ ] **Step 2: Write the failing test**

Create `tests/semantic-layer-to-ai.test.sh` with:

```sh
#!/bin/sh
set -eu

page="dbt-ai-llm/index.html"
directory="index.html"

test -f "$page"
test -f "$directory"

# Canonical page and seven-step structure.
rg -Fq '<title>dbt + AI</title>' "$page"
rg -Fq 'From Data to Conversation' "$page"
test "$(rg -c "render: renderStep[0-6]" "$page")" -eq 7

# Field-notes visual system matches the stored-procedures explainer.
rg -Fq 'class="field-notes"' "$page"
rg -Fq -- '--paper: #fafaf9' "$page"
rg -Fq -- '--ink: #1c1c1c' "$page"
rg -Fq -- '--rule-light: #e8e5e0' "$page"
rg -Fq 'family=Inter' "$page"
rg -Fq 'family=Space+Mono' "$page"
rg -Fq 'box-shadow: none' "$page"
if rg -q 'linear-gradient' "$page"; then
  echo "Field-notes page contains a prohibited gradient" >&2
  exit 1
fi

for label in \
  "Semantic foundations" \
  "Three systems" \
  "Choose a boundary" \
  "The shift to AI" \
  "Agent path" \
  "Safe use" \
  "Access & takeaway"
do
  rg -Fq "lbl: '$label'" "$page"
done

# Recurring example and three compared products.
rg -Fq 'net_revenue' "$page"
rg -Fq 'region' "$page"
rg -Fq 'dbt Semantic Layer' "$page"
rg -Fq 'Databricks Unity Catalog metric views' "$page"
rg -Fq 'Snowflake semantic views' "$page"

# Permanent source list and bidirectional footnotes.
rg -Fq 'id="sources"' "$page"
rg -Fq 'Sources checked July 28, 2026' "$page"
rg -Fq 'class="fn-ref"' "$page"
rg -Fq 'class="source-backref"' "$page"
rg -Fq 'id="source-dbt-semantic-models"' "$page"
rg -Fq 'id="source-databricks-metric-views"' "$page"
rg -Fq 'id="source-snowflake-semantic-views"' "$page"

# English-first launch preserves, but does not expose, Japanese work.
rg -Fq 'var AI_TR=' "$page"
rg -Fq 'window.setLangAI' "$page"
rg -Fq '日本語' "$page"
rg -Eq 'class="lang-toggle"[^>]*hidden|hidden[^>]*class="lang-toggle"' "$page"

# Navigation and accessibility hooks.
rg -Fq 'aria-live="polite"' "$page"
rg -Fq ':focus-visible' "$page"
rg -Fq 'prefers-reduced-motion:reduce' "$page"
rg -Fq 'onclick="nav(-1)"' "$page"
rg -Fq 'onclick="nav(1)"' "$page"

# Directory still points to the same URL and describes the expanded scope.
rg -Fq 'href="./dbt-ai-llm/"' "$directory"
rg -Fq 'semantic' "$directory"
rg -Fq 'AI' "$directory"

# Stale visible claims are prohibited outside the preserved translation dictionary.
visible_page="$(mktemp)"
trap 'rm -f "$visible_page"' EXIT
sed '/\/\* --- i18n (EN \/ JA) added --- \*\//,$d' "$page" > "$visible_page"
if rg -q 'H1 2026|H2 2026|Coming soon|MOST EFFICIENT|Full dbt stack, most powerful|automatically and accurately' "$visible_page"; then
  echo "Visible copy contains stale roadmap or unsupported absolute claims" >&2
  exit 1
fi

# No duplicate explainer is introduced.
test ! -d "dbt-semantic-layer"
test ! -d "dbt-vs-semantic-views"

echo "semantic-layer-to-ai checks passed"
```

- [ ] **Step 3: Make the test executable and verify shell syntax**

Run:

```bash
chmod +x tests/semantic-layer-to-ai.test.sh
sh -n tests/semantic-layer-to-ai.test.sh
```

Expected: shell syntax passes with no output.

- [ ] **Step 4: Run the test and verify it fails for the intended reason**

Run:

```bash
./tests/semantic-layer-to-ai.test.sh
```

Expected: FAIL on the first missing redesigned label, `Semantic foundations`.

- [ ] **Step 5: Commit the test**

```bash
git add tests/semantic-layer-to-ai.test.sh
git commit -m "test: define semantic layer to AI explainer contract"
```

---

### Task 2: Build the semantic-layer half and decision-first opening

**Files:**
- Modify: `dbt-ai-llm/index.html:1-330`
- Modify: `dbt-ai-llm/index.html:1067-1104`
- Test: `tests/semantic-layer-to-ai.test.sh`

**Interfaces:**
- Consumes: existing `.app`, `.hdr`, `.nav`, `.card`, `.ctrls`, `renderNav()`, `renderContent()`, `goTo()`, and `nav()`
- Produces: `SEMANTIC_PRODUCTS`, `renderStep0()`, `renderStep1()`, `renderStep2()`, and the first three exact `STEPS` labels for later tasks

- [ ] **Step 1: Add the decision-first opening to the static header**

First, replace the dark visual system with a dedicated field-notes CSS layer matching `dbt-vs-stored-procs/index.html`:

```html
<html lang="en" class="field-notes">
```

Load the same two type roles:

```html
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
```

Define and use these exact shared tokens:

```css
:root{
  --paper:#fafaf9;
  --ink:#1c1c1c;
  --text:#2a2a2a;
  --muted-light:#777;
  --faint-light:#aaa;
  --rule-light:#e8e5e0;
  --surface:#fff;
  --soft:#f9f8f6;
  --danger-light:#991b1b;
  --success-light:#166534;
  --warning-light:#92400e;
  --accent:#c2410c;
  --code-font:"Space Mono","SFMono-Regular",Consolas,monospace;
  --body-font:Inter,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;
}
*{box-shadow:none!important}
body{background:var(--paper);color:var(--ink);font-family:var(--body-font);font-size:15px;line-height:1.7}
.app{max-width:980px;margin:0 auto;padding:32px 24px 100px}
```

Restyle the shell to match the reference:

- left-align `.hdr`, with a thin bottom rule and no centered badge treatment;
- render `.hdr-tag` as unboxed Space Mono metadata;
- make `.nav` a zero-radius ruled index rather than a rounded card;
- invert the active navigation item to black with white text;
- render `.card` as a white editorial section with square corners and thin rules;
- render code/YAML examples as light editor surfaces with Space Mono;
- use orange only for dbt/transition emphasis, green for confirmed safe paths, and red/amber for warnings;
- remove every `linear-gradient`, visible shadow, and decorative pill treatment from the English-visible page.

Then add the decision-first opening under the existing subtitle:

Under the existing subtitle, add:

```html
<aside class="short-answer" aria-labelledby="short-answer-title">
  <div class="short-answer-label">the short answer</div>
  <h2 id="short-answer-title">Use the semantic layer that matches the boundary of your problem.</h2>
  <p>Start native when one warehouse is the durable home for definitions and consumption. Consider dbt when metrics need to travel with a governed transformation project across supported tools. Either way, the semantic layer still depends on well-modeled data underneath.</p>
</aside>
```

Add restrained CSS using the current design tokens:

```css
.short-answer{margin:0 0 40px;padding:20px 0 20px 22px;border:0;border-left:2px solid var(--accent);background:transparent}
.short-answer-label{margin-bottom:7px;font-family:var(--code-font);font-size:9px;letter-spacing:1.4px;text-transform:uppercase;color:var(--accent)}
.short-answer h2{margin:0 0 8px;font-size:18px;line-height:1.25}
.short-answer p{margin:0;max-width:760px;color:var(--muted-light);font-size:13px;line-height:1.65}
```

- [ ] **Step 2: Define the three-product comparison data**

Immediately after `var cur = 0;`, add this shared shape:

```js
var SEMANTIC_PRODUCTS = [
  {
    id: 'dbt',
    name: 'dbt Semantic Layer',
    object: 'Semantic models and metrics live with the dbt project.',
    define: 'YAML semantic model + metric',
    query: 'Semantic Layer query interface',
    boundary: 'The governed dbt project and its supported consumption interfaces',
    bestWhen: 'Metric definitions need to stay connected to transformation models and serve supported tools beyond one warehouse-native interface.',
    source: 1
  },
  {
    id: 'databricks',
    name: 'Databricks Unity Catalog metric views',
    object: 'A metric view is a securable Unity Catalog object.',
    define: 'SQL DDL, Catalog Explorer, and YAML-backed definition',
    query: 'Databricks SQL against the metric view',
    boundary: 'Unity Catalog',
    bestWhen: 'Unity Catalog and Databricks consumption surfaces are the durable operating boundary.',
    source: 3
  },
  {
    id: 'snowflake',
    name: 'Snowflake semantic views',
    object: 'A semantic view is a Snowflake schema-level object.',
    define: 'SQL DDL, Snowsight, or YAML',
    query: 'SELECT queries and supported Snowflake interfaces',
    boundary: 'The Snowflake schema and its privileges',
    bestWhen: 'Snowflake is the durable definition and consumption boundary.',
    source: 5
  }
];
```

Do not add claims beyond those supported by the primary sources in Task 4.

- [ ] **Step 3: Replace `renderStep0()` with semantic foundations**

The renderer must:

- title the card `What a semantic layer actually does`;
- label all business values as `Illustrative example`;
- show a left-to-right flow:

```text
modeled orders → entity/relationship → net_revenue metric → region dimension → generated warehouse query
```

- define metric, dimension, entity/relationship, and query interface in plain language;
- end with: `A semantic layer can organize definitions and generate queries. It cannot repair incorrect or poorly modeled inputs.`

Use `<code>net_revenue</code>` and `<code>region</code>` consistently. Do not show product-specific syntax in this step.

- [ ] **Step 4: Replace `renderStep1()` with one metric in three systems**

Render `SEMANTIC_PRODUCTS` into three parallel panels. Each panel must show:

1. `Where it lives`
2. `How it is defined`
3. `How it is queried`
4. `Governance boundary`
5. `Strong fit`

Under the panels, show short, explicitly illustrative excerpts:

```yaml
# dbt — illustrative shape
metrics:
  - name: net_revenue
    type: derived
```

```yaml
# Databricks — illustrative shape
version: "1.1"
measures:
  - name: net_revenue
```

```sql
-- Snowflake — illustrative shape
CREATE SEMANTIC VIEW revenue_semantics
  METRICS (net_revenue AS ...);
```

The labels must say `illustrative shape—not a copy/paste implementation`. Use footnote calls through the `footnote()` helper added in Task 4; until that helper exists, use literal placeholder-free links such as:

```html
<sup><a class="fn-ref" id="claim-databricks-object" href="#source-databricks-metric-views">[3]</a></sup>
```

- [ ] **Step 5: Replace `renderStep2()` with the conditional decision matrix**

Use rows:

```js
var DECISION_ROWS = [
  ['Durable boundary', 'dbt project', 'Unity Catalog', 'Snowflake schema'],
  ['Metric relationship', 'Defined on dbt semantic models', 'Defined in a metric view', 'Defined in a semantic view'],
  ['Primary query path', 'dbt Semantic Layer interfaces', 'Databricks SQL', 'Snowflake SQL and supported interfaces'],
  ['Operational owner', 'Team operating the dbt project and Semantic Layer', 'Team operating Unity Catalog and Databricks SQL', 'Team operating Snowflake schemas and privileges']
];
```

End with three equal-weight conditional callouts:

- `Start with Databricks-native when…`
- `Start with Snowflake-native when…`
- `Consider dbt when…`

Do not use winner badges, checkmarks, scores, or an overall ranking.

- [ ] **Step 6: Update the first three navigation labels**

Set the first three entries in `STEPS` exactly:

```js
{ lbl: 'Semantic foundations', render: renderStep0 },
{ lbl: 'Three systems', render: renderStep1 },
{ lbl: 'Choose a boundary', render: renderStep2 },
```

Leave renderers 3–6 and their labels unchanged until Task 3.

- [ ] **Step 7: Run focused checks**

Run:

```bash
rg -n 'net_revenue|SEMANTIC_PRODUCTS|DECISION_ROWS|Semantic foundations|Three systems|Choose a boundary' dbt-ai-llm/index.html
sh -n tests/semantic-layer-to-ai.test.sh
./tests/semantic-layer-to-ai.test.sh
```

Expected: the test advances past the first three labels and fails on missing `The shift to AI`.

- [ ] **Step 8: Commit the semantic comparison**

```bash
git add dbt-ai-llm/index.html
git commit -m "feat: add semantic layer comparison"
```

---

### Task 3: Refocus the AI half around governed consumption

**Files:**
- Modify: `dbt-ai-llm/index.html:296-1066`
- Test: `tests/semantic-layer-to-ai.test.sh`

**Interfaces:**
- Consumes: `net_revenue`, the three semantic-product boundaries, existing `stack-diagram.svg`, and the static step shell
- Produces: `AI_ACCESS_PATHS`, `SAFE_USE_CASES`, `renderStep3()` through `renderStep6()`, and the final four exact `STEPS` labels

- [ ] **Step 1: Replace `renderStep3()` with the semantic-to-AI transition**

Move the current dashboard-versus-conversation concept here and retitle it:

```text
A definition becomes useful when something consumes it
```

Show the same illustrative request, `net_revenue by region`, in:

- a fixed dashboard view; and
- a conversational follow-up flow.

Use neutral copy:

```text
The governed metric can stay the same while the interaction changes. A dashboard exposes designed views and controls. A conversational interface can accept follow-up questions. Which interface is better depends on the task and the guardrails behind it.
```

Delete absolute claims such as “the agent follows the question you're actually asking,” “most efficient,” and “automatically accurate.”

- [ ] **Step 2: Define the three agent access paths**

Add:

```js
var AI_ACCESS_PATHS = [
  {
    id: 'semantic',
    label: 'Governed semantic query',
    path: 'AI client → dbt MCP/API interface → Semantic Layer → warehouse',
    receives: 'Named metrics and allowed dimensions',
    boundary: 'Metric definition and Semantic Layer authorization, plus warehouse enforcement'
  },
  {
    id: 'discovery',
    label: 'Project discovery',
    path: 'AI client → dbt metadata/discovery interface',
    receives: 'Models, lineage, tests, and documentation exposed by the interface',
    boundary: 'Metadata access; this path does not itself return metric results'
  },
  {
    id: 'sql',
    label: 'Direct SQL fallback',
    path: 'AI client → authorized SQL execution path → warehouse',
    receives: 'Rows returned by generated or supplied SQL',
    boundary: 'SQL authorization and warehouse permissions; no metric definition is automatically enforced'
  }
];
```

- [ ] **Step 3: Replace `renderStep4()` with the agent path architecture**

Render `AI_ACCESS_PATHS` as three selectable or stacked paths. Default to `Governed semantic query`.

If `stack-diagram.svg` still depicts the approved path accurately, keep it and revise its accessible caption. If it includes removed developer-tool or roadmap claims, replace its use with an inline HTML/SVG diagram inside `renderStep4()`; do not expand scope into a site-wide diagram redesign.

The section must explicitly state:

```text
MCP is a connection mechanism, not the governance layer. The permissions and query interface behind each tool determine what the agent can request.
```

- [ ] **Step 4: Replace `renderStep5()` with four safe-use tiers**

Define:

```js
var SAFE_USE_CASES = [
  {
    id: 'metric',
    title: 'Ask a governed metric question',
    example: 'Show illustrative net_revenue by region for last month.',
    guardrail: 'Uses the named metric and allowed dimensions.'
  },
  {
    id: 'context',
    title: 'Investigate context',
    example: 'Which upstream model feeds net_revenue, and when did it last run?',
    guardrail: 'Returns available project metadata; it does not prove the business result is correct.'
  },
  {
    id: 'difference',
    title: 'Explain a difference',
    example: 'Why does this ad hoc SUM differ from net_revenue?',
    guardrail: 'Compares the governed definition with the explicit SQL assumptions.'
  },
  {
    id: 'fallback',
    title: 'Fall back to SQL',
    example: 'Explore a question for which no governed metric exists.',
    guardrail: 'Label the result ad hoc; do not present it as the governed metric.'
  }
];
```

Render each with a visible `Illustrative scenario` label. Remove the current code-generation, job-control, project-scaffolding, and “everything together” catalogs.

- [ ] **Step 5: Replace `renderStep6()` with access and takeaway**

Use a two-gate diagram:

```text
Gate 1: dbt-facing interface
Controls which semantic, metadata, or SQL tools the client can request.

Gate 2: warehouse
Enforces the warehouse identity's object, row, and column permissions.
```

Then end with:

```text
Conversational access does not remove governance. It makes the definition, authorization, and fallback boundaries more important because more questions can be asked through the interface.
```

Only include authentication mechanisms or product entitlements that Task 4 verifies in current primary documentation. Remove `H1 2026`, `H2 2026`, `Coming soon`, seat promises, and future OAuth language from visible renderers.

- [ ] **Step 6: Update the final four navigation labels**

Use exactly:

```js
{ lbl: 'The shift to AI', render: renderStep3 },
{ lbl: 'Agent path', render: renderStep4 },
{ lbl: 'Safe use', render: renderStep5 },
{ lbl: 'Access & takeaway', render: renderStep6 },
```

- [ ] **Step 7: Add live-region and focus behavior**

Change:

```html
<div id="scontent"></div>
```

to:

```html
<div id="scontent" aria-live="polite"></div>
```

Update `goTo(i)` so user-initiated navigation focuses the rendered card heading without trapping focus:

```js
function goTo(i) {
  cur = i;
  renderNav();
  renderContent();
  var heading = document.querySelector('#scontent .card-title');
  if (heading) {
    heading.setAttribute('tabindex', '-1');
    heading.focus({preventScroll:true});
  }
  window.scrollTo({top:0, behavior: prefersReducedMotion() ? 'auto' : 'smooth'});
}

function prefersReducedMotion() {
  return window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
}
```

Add visible focus CSS and reduced-motion CSS:

```css
button:focus-visible,a:focus-visible{outline:2px solid var(--blue);outline-offset:3px}
@media(prefers-reduced-motion:reduce){*,*::before,*::after{scroll-behavior:auto!important;transition:none!important}}
```

- [ ] **Step 8: Run the contract test**

Run:

```bash
./tests/semantic-layer-to-ai.test.sh
```

Expected: the test advances through all seven labels and fails on the not-yet-added permanent Sources section.

- [ ] **Step 9: Commit the AI refocus**

```bash
git add dbt-ai-llm/index.html
git commit -m "feat: connect semantic governance to AI use"
```

---

### Task 4: Add verified footnotes, permanent sources, and English-first behavior

**Files:**
- Modify: `dbt-ai-llm/index.html`
- Test: `tests/semantic-layer-to-ai.test.sh`

**Interfaces:**
- Consumes: claim anchors emitted by Tasks 2 and 3
- Produces: `SOURCE_DATA`, `footnote(number, claimId)`, `renderSources()`, permanent `#sources`, and hidden-but-preserved localization controls

- [ ] **Step 1: Verify each primary source before finalizing copy**

Open and read these exact primary pages:

```text
https://docs.getdbt.com/docs/build/semantic-models
https://docs.getdbt.com/docs/build/metrics-overview
https://docs.databricks.com/aws/en/uc-semantics/metric-views
https://docs.databricks.com/aws/en/uc-semantics/metric-views/manage
https://docs.snowflake.com/en/user-guide/views-semantic/overview
```

For the AI half, navigate from the current dbt Developer Hub to the current official pages for the dbt MCP server, Semantic Layer query interfaces, and authorization. Record only the direct URLs actually opened in `SOURCE_DATA`.

Use these exact pages:

```text
https://docs.getdbt.com/docs/dbt-ai/about-mcp
https://docs.getdbt.com/docs/dbt-ai/mcp-available-tools
https://docs.getdbt.com/docs/use-dbt-semantic-layer/consume-metrics
https://docs.getdbt.com/docs/use-dbt-semantic-layer/sl-architecture
```

Classification rule:

- If a source directly supports the claim, keep it and attach the footnote.
- If it contradicts the draft, change the draft.
- If no current primary source supports the claim, delete it.
- If the wording synthesizes multiple sources, label it as an inference in visible copy.

- [ ] **Step 2: Add permanent source markup**

Place this after `.ctrls` and before the GitHub source-file footer:

```html
<section class="sources" id="sources" aria-labelledby="sources-title">
  <div class="sources-kicker">primary documentation</div>
  <h2 id="sources-title">Sources</h2>
  <p>Sources checked July 28, 2026.</p>
  <div id="source-list"></div>
</section>
```

Use CSS:

```css
.sources{margin-top:34px;padding-top:22px;border-top:1px solid var(--border)}
.sources-kicker{font-family:var(--mono);font-size:9px;letter-spacing:1.2px;text-transform:uppercase;color:var(--muted)}
.sources h2{margin:6px 0;font-size:18px}
.sources p{margin:0 0 14px;color:var(--muted);font-size:11px}
.source-group{margin-top:16px}
.source-group h3{margin:0 0 7px;font-size:12px}
.source-list{margin:0;padding-left:20px;color:var(--muted);font-size:11px;line-height:1.6}
.source-list a{color:var(--blue);text-underline-offset:2px}
.fn-ref{font-family:var(--mono);font-size:9px}
.source-backref{margin-left:5px;font-family:var(--mono);font-size:9px}
```

- [ ] **Step 3: Define the source and footnote interfaces**

Add:

```js
var SOURCE_DATA = [
  {
    number: 1,
    id: 'source-dbt-semantic-models',
    group: 'dbt',
    title: 'Semantic models',
    publisher: 'dbt Developer Hub',
    url: 'https://docs.getdbt.com/docs/build/semantic-models',
    claims: [{id: 'claim-dbt-model', step: 1}]
  },
  {
    number: 2,
    id: 'source-dbt-metrics',
    group: 'dbt',
    title: 'Metrics overview',
    publisher: 'dbt Developer Hub',
    url: 'https://docs.getdbt.com/docs/build/metrics-overview',
    claims: [{id: 'claim-dbt-metric', step: 1}]
  },
  {
    number: 3,
    id: 'source-databricks-metric-views',
    group: 'Databricks',
    title: 'Unity Catalog metric views',
    publisher: 'Databricks documentation',
    url: 'https://docs.databricks.com/aws/en/uc-semantics/metric-views',
    claims: [{id: 'claim-databricks-object', step: 1}]
  },
  {
    number: 4,
    id: 'source-databricks-manage',
    group: 'Databricks',
    title: 'Manage metric views',
    publisher: 'Databricks documentation',
    url: 'https://docs.databricks.com/aws/en/uc-semantics/metric-views/manage',
    claims: [{id: 'claim-databricks-permissions', step: 2}]
  },
  {
    number: 5,
    id: 'source-snowflake-semantic-views',
    group: 'Snowflake',
    title: 'Overview of semantic views',
    publisher: 'Snowflake documentation',
    url: 'https://docs.snowflake.com/en/user-guide/views-semantic/overview',
    claims: [{id: 'claim-snowflake-object', step: 1}]
  },
  {
    number: 6,
    id: 'source-dbt-mcp-overview',
    group: 'dbt',
    title: 'About the dbt MCP server',
    publisher: 'dbt Developer Hub',
    url: 'https://docs.getdbt.com/docs/dbt-ai/about-mcp',
    claims: [{id: 'claim-dbt-mcp-path', step: 4}]
  },
  {
    number: 7,
    id: 'source-dbt-mcp-tools',
    group: 'dbt',
    title: 'dbt MCP tools and capabilities',
    publisher: 'dbt Developer Hub',
    url: 'https://docs.getdbt.com/docs/dbt-ai/mcp-available-tools',
    claims: [{id: 'claim-dbt-mcp-tools', step: 5}]
  },
  {
    number: 8,
    id: 'source-dbt-consume-metrics',
    group: 'dbt',
    title: 'Consume dbt Semantic Layer metrics',
    publisher: 'dbt Developer Hub',
    url: 'https://docs.getdbt.com/docs/use-dbt-semantic-layer/consume-metrics',
    claims: [{id: 'claim-dbt-consumption', step: 2}]
  },
  {
    number: 9,
    id: 'source-dbt-sl-architecture',
    group: 'dbt',
    title: 'dbt Semantic Layer architecture',
    publisher: 'dbt Developer Hub',
    url: 'https://docs.getdbt.com/docs/use-dbt-semantic-layer/sl-architecture',
    claims: [{id: 'claim-dbt-sl-architecture', step: 4}]
  }
];

function footnote(number, claimId) {
  var source = SOURCE_DATA.find(function(item){ return item.number === number; });
  if (!source) throw new Error('Unknown source number: ' + number);
  return '<sup><a class="fn-ref" id="' + claimId + '" href="#' + source.id + '" aria-label="Source ' + number + '">[' + number + ']</a></sup>';
}

function goToClaim(step, claimId) {
  goTo(step);
  window.setTimeout(function(){
    var claim = document.getElementById(claimId);
    if (claim) claim.focus({preventScroll:false});
  }, 0);
  return false;
}

function renderSources() {
  var groups = ['dbt', 'Databricks', 'Snowflake'];
  document.getElementById('source-list').innerHTML = groups.map(function(group){
    var items = SOURCE_DATA.filter(function(source){ return source.group === group; });
    return '<div class="source-group"><h3>' + group + '</h3><ol class="source-list">' +
      items.map(function(source){
        var backrefs = source.claims.map(function(claim){
          return '<a class="source-backref" href="#' + claim.id + '" onclick="return goToClaim(' +
            claim.step + ', \'' + claim.id + '\')" aria-label="Back to claim">↩</a>';
        }).join('');
        return '<li id="' + source.id + '" value="' + source.number + '"><a href="' + source.url + '">' +
          source.title + '</a> — ' + source.publisher + backrefs + '</li>';
      }).join('') +
      '</ol></div>';
  }).join('');
}
```

Attach sources 6–9 only to the MCP, tool, consumption, and architecture claims they directly support.

- [ ] **Step 4: Initialize sources after the page renders**

Change the final initialization to:

```js
renderNav();
renderContent();
renderSources();
```

Verify every `href="#source-…"` has one matching ID and every source entry has at least one back-reference.

- [ ] **Step 5: Hide the language control without deleting localization work**

Change the existing wrapper to:

```html
<div class="lang-toggle" role="group" aria-label="Language / 言語" hidden>
```

Keep:

- the `日本語` button;
- `var AI_TR=...`;
- `window.setLangAI`;
- the dynamic translation wrappers; and
- all existing Japanese values.

Do not initialize Japanese from browser locale while the control is hidden. Force English at load:

```js
window.setLangAI('en');
```

Leave a source comment:

```js
/* Japanese dictionary preserved for the localization follow-up.
   Keep the toggle hidden until every redesigned string is translated. */
```

- [ ] **Step 6: Run automated verification**

Run:

```bash
sh -n tests/semantic-layer-to-ai.test.sh
./tests/semantic-layer-to-ai.test.sh
git diff --check
```

Expected:

```text
semantic-layer-to-ai checks passed
```

- [ ] **Step 7: Confirm the old Japanese work survived**

Run:

```bash
rg -n 'var AI_TR=|window.setLangAI|日本語|データから対話へ' dbt-ai-llm/index.html
git diff -- dbt-ai-llm/index.html
```

Expected: all four localization markers remain. Inspect the diff to ensure the redesign did not replace the dictionary with an empty or abbreviated object.

- [ ] **Step 8: Commit verified citations and language behavior**

```bash
git add dbt-ai-llm/index.html
git commit -m "docs: source semantic layer and AI claims"
```

---

### Task 5: Update navigation copy and complete end-to-end verification

**Files:**
- Modify: `index.html`
- Modify: `README.md`
- Modify if verification finds a defect: `dbt-ai-llm/index.html`
- Test: `tests/semantic-layer-to-ai.test.sh`
- Test: `tests/raw-directory-index.test.sh`

**Interfaces:**
- Consumes: completed seven-step explainer at the unchanged `dbt-ai-llm/` path
- Produces: accurate directory/README descriptions and a visually verified static page

- [ ] **Step 1: Update the directory description without adding an entry**

Keep the current entry name `dbt, AI, and LLMs` and its existing URL. Replace its description with:

```html
<span class="entry-description">how semantic layers define trusted metrics—and what those definitions let AI agents safely ask.</span>
```

Set its reading-time label to:

```html
<span class="entry-meta">~12 min</span>
```

Do not change the `6 explainers` count.

- [ ] **Step 2: Update the README description**

Replace the existing `dbt + AI / Conversational Analytics` bullet with:

```markdown
- [dbt Semantic Layer + AI](https://cedricturner.github.io/dbt-artifacts/dbt-ai-llm/): compare where semantic definitions live, then follow governed metrics into conversational AI
```

- [ ] **Step 3: Update the raw directory test for the revised copy**

In `tests/raw-directory-index.test.sh`, add:

```sh
rg -Fq 'how semantic layers define trusted metrics' "$preview"
rg -Fq 'what those definitions let AI agents safely ask' "$preview"
```

Because that test requires `raw-directory-index.html` and `index.html` to match, copy the approved directory-content changes into `raw-directory-index.html` only if that preview is still intentionally the source-of-truth twin. Do not change its design.

- [ ] **Step 4: Run all repository shell tests**

Run:

```bash
for test_file in tests/*.sh; do
  sh -n "$test_file"
  "$test_file"
done
```

Expected: every test prints its success message and exits 0.

- [ ] **Step 5: Serve the site locally**

Run:

```bash
python3 -m http.server 8000
```

Open:

```text
http://localhost:8000/dbt-ai-llm/
```

- [ ] **Step 6: Verify desktop interaction**

At a desktop viewport, confirm:

- the page visually matches the published `dbt-vs-stored-procs/` field-notes system: paper background, left-aligned header, ruled navigation, flat editorial sections, Inter, and Space Mono;
- no dark card remnants, gradients, shadows, or decorative pill chrome remain visible;
- the short answer is visible before the step navigation;
- all seven direct-step buttons work;
- previous/next controls update content and progress;
- the comparison does not imply an overall winner;
- the semantic-to-AI turn is visually obvious between steps 3 and 4;
- footnotes move to the permanent source entry;
- source back-links return to claims;
- external source links open the exact primary pages;
- illustrative values are visibly labeled;
- the Japanese toggle is not visible; and
- no console errors occur.

- [ ] **Step 7: Verify narrow mobile and keyboard behavior**

At approximately `390 × 844`, confirm:

- comparison content stacks or scrolls without widening the page;
- no text is clipped;
- step navigation remains usable;
- sources wrap cleanly;
- Tab reaches direct steps, previous/next controls, footnotes, sources, and back-links;
- focus is visible; and
- reduced-motion mode disables smooth movement and transitions.

- [ ] **Step 8: Re-run source verification on final visible claims**

Read each visible factual product claim and follow its footnote. Confirm:

- the linked page directly supports the claim;
- the wording does not exceed the source;
- no roadmap, pricing, or entitlement claim remains; and
- inferences are labeled as inferences.

Remove any unsupported claim before completion.

- [ ] **Step 9: Run the final verification commands**

Run:

```bash
for test_file in tests/*.sh; do "$test_file"; done
git diff --check
git status --short
git diff --stat
```

Expected: all tests pass, no whitespace errors appear, and `git status` shows only intended explainer/navigation/test changes plus the unrelated pre-existing work.

- [ ] **Step 10: Commit the navigation and verification adjustments**

```bash
git add index.html raw-directory-index.html README.md tests/raw-directory-index.test.sh dbt-ai-llm/index.html
git commit -m "feat: publish semantic layer to AI journey"
```
