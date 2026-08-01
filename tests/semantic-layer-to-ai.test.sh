#!/bin/sh
set -eu

page="dbt-ai-llm/index.html"
directory="index.html"

test -f "$page"
test -f "$directory"

# Canonical page and seven-step structure.
test "$(rg -c "render: renderStep[0-6]" "$page")" -eq 7

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

rg -Fq '<title>dbt + language</title>' "$page"
rg -Fq '<link rel="icon" href="data:,">' "$page"
rg -Fq '<h1 class="si">dbt + language</h1>' "$page"
rg -Fq "AI_TR['dbt + language']='dbt + 言語';" "$page"
rg -Fq "document.title=lang==='ja'?'dbt + 言語':'dbt + language'" "$page"

# Field-notes visual system matches the stored-procedures explainer.
rg -Fq 'class="field-notes"' "$page"
rg -Fq -- '--paper: #fafaf9' "$page"
rg -Fq -- '--ink: #1c1c1c' "$page"
rg -Fq -- '--rule-light: #e8e5e0' "$page"
rg -Fq 'family=Inter' "$page"
rg -Fq 'family=Space+Mono' "$page"
rg -Fq '.hdr{text-align:left' "$page"
rg -Fq '.nav{border-radius:0' "$page"
rg -Fq 'box-shadow: none' "$page"
rg -Fq 'grid-template-columns:repeat(4,minmax(120px,1fr) 7px) minmax(120px,1fr)' "$page"
if rg -q 'linear-gradient' "$page"; then
  echo "Field-notes page contains a prohibited gradient" >&2
  exit 1
fi

# Recurring example and three compared products.
rg -Fq 'net_revenue' "$page"
rg -Fq 'region' "$page"
rg -Fq 'dbt Semantic Layer' "$page"
rg -Fq 'Databricks Unity Catalog metric views' "$page"
rg -Fq 'Snowflake semantic views' "$page"

# Product citations sit beside the exact supported field, not a generic heading.
rg -Fq "object: 'Semantic models are the foundation for data definition in MetricFlow. ' + footnote(1, 'claim-dbt-model')" "$page"
rg -Fq "define: 'Metrics are added to the dbt project after semantic models. ' + footnote(2, 'claim-dbt-metric')" "$page"
rg -Fq "define: 'Metric views are the core implementation of Unity Catalog semantics; define them with SQL DDL or Catalog Explorer and query them at runtime. ' + footnote(3, 'claim-databricks-implementation')" "$page"
rg -Fq "object: 'A metric view is a securable Unity Catalog object that follows its hierarchical permissions model. ' + footnote(4, 'claim-databricks-permissions')" "$page"
rg -Fq "object: 'A semantic view is a Snowflake schema-level object. ' + footnote(5, 'claim-snowflake-object')" "$page"
rg -Fq '<dt>Inference: strong fit</dt>' "$page"
if rg -qi "operational owner.*footnote\\(4" "$page"; then
  echo "Databricks permissions source is attached to an operational-owner inference" >&2
  exit 1
fi

# Every factual capability cell in the decision matrix has the correct source link.
while IFS='|' read -r number claim
do
  rg -Fq "footnote($number, '$claim')" "$page"
done <<'EOF'
1|claim-matrix-dbt-boundary
4|claim-matrix-databricks-boundary
5|claim-matrix-snowflake-boundary
2|claim-matrix-dbt-relationship
3|claim-matrix-databricks-relationship
5|claim-matrix-snowflake-relationship
8|claim-dbt-consumption
3|claim-matrix-databricks-query
5|claim-matrix-snowflake-query
EOF

# Permanent source list and bidirectional footnotes.
rg -Fq 'id="sources"' "$page"
rg -Fq 'Sources checked July 28, 2026' "$page"
rg -Fq 'class="fn-ref"' "$page"
rg -Fq 'class="source-backref"' "$page"
rg -Fq 'id="source-dbt-semantic-models"' "$page"
rg -Fq 'id="source-databricks-metric-views"' "$page"
rg -Fq 'id="source-snowflake-semantic-views"' "$page"

# All nine primary sources map to an exact claim and a generated return link.
while IFS='|' read -r number source claim step
do
  source_block="$(sed -n "/number: $number,/,/^  },\\{0,1\\}$/p" "$page")"
  printf '%s\n' "$source_block" | rg -Fq "id: '$source',"
  printf '%s\n' "$source_block" | rg -Fq "{id: '$claim', step: $step}"
  rg -Fq "footnote($number, '$claim')" "$page"
done <<'EOF'
1|source-dbt-semantic-models|claim-dbt-model|1
2|source-dbt-metrics|claim-dbt-metric|1
3|source-databricks-metric-views|claim-databricks-implementation|1
4|source-databricks-manage|claim-databricks-permissions|1
5|source-snowflake-semantic-views|claim-snowflake-object|1
6|source-dbt-mcp-overview|claim-dbt-mcp-path|4
7|source-dbt-mcp-tools|claim-dbt-mcp-tools|5
8|source-dbt-consume-metrics|claim-dbt-consumption|2
9|source-dbt-sl-architecture|claim-dbt-sl-architecture|4
EOF

# Language selector preserves the Japanese translation work.
rg -Fq 'var AI_TR=' "$page"
rg -Fq 'window.setLangAI' "$page"
rg -Fq '日本語' "$page"
rg -Fq 'class="language-current"' "$page"
rg -Fq 'class="language-option language-en"' "$page"
rg -Fq 'class="language-option language-ja"' "$page"

# Endless-scroll navigation and accessibility hooks.
rg -Fq ':focus-visible' "$page"
rg -Fq 'prefers-reduced-motion:reduce' "$page"
rg -Fq 'class="scroll-layout"' "$page"
rg -Fq 'grid-template-columns:minmax(132px,148px) minmax(0,1fr)' "$page"
rg -Fq 'gap:clamp(24px,4vw,44px)' "$page"
rg -Fq 'class="nav section-rail"' "$page"
rg -Fq 'id="mobile-section-nav"' "$page"
rg -Fq 'data-section-target="' "$page"
rg -Fq 'data-section-id="' "$page"
rg -Fq 'function setActiveSection(sectionId,updateHash)' "$page"
rg -Fq "history.replaceState(null,'','#'+sectionId)" "$page"
rg -Fq "window.addEventListener('hashchange'" "$page"
rg -Fq "window.addEventListener('scroll'" "$page"
test "$(rg -o "id: '[a-z-]*', shape:" "$page" | wc -l | tr -d ' ')" = "7"
test "$(rg -o "shape: '[a-z]*'" "$page" | sort -u | wc -l | tr -d ' ')" = "7"
rg -Fq '.section-rail .ns-n{display:flex;width:28px;height:28px' "$page"
rg -Fq '.section-rail .ns[data-shape="burst"].on .ns-n' "$page"
rg -Fq '.section-heading-title' "$page"
rg -Fq '.scroll-section+.scroll-section' "$page"
rg -Fq 'onclick="return goToSource(' "$page"
rg -Fq 'tabindex="-1" value="' "$page"
test "$(rg -c '<h2 class="card-title">' "$page")" -eq 7

# Low-contrast metadata and inline code are overridden with readable colors.
rg -Fq '.card-sub,.definition p,.product-field dd' "$page"
rg -Fq 'code{color:#183f66;background:#f1f0ed;font-weight:500}' "$page"

# Visible technical-blog prose avoids obvious P0/P1 AI-writing tells.
prose_page="$(mktemp)"
visible_page=""
trap 'rm -f "$prose_page" ${visible_page:+"$visible_page"}' EXIT
sed '/\/\* --- i18n (EN \/ JA) added --- \*\//,$d' "$page" |
  perl -0pe 's/<pre>[\s\S]*?<\/pre>//g; s/\/\*[\s\S]*?\*\///g' > "$prose_page"
if rg -qi '\b(delve|tapestry|beacon|embark|game-changer|harness)\b|great question|i hope this helps|let.s dive|in today.s|at its core|it.s worth noting|could potentially|may eventually' "$prose_page"; then
  echo "Visible prose contains an obvious P0/P1 AI-writing tell" >&2
  exit 1
fi
if rg -q '—' "$prose_page"; then
  echo "Visible prose still contains an em dash" >&2
  exit 1
fi

# The conclusion distinguishes the connector from the enforcement layers.
rg -Fq 'MCP is a connection mechanism, not the governance layer.' "$page"
rg -Fq 'authentication' "$page"
rg -Fq 'object, row, and column' "$page"
rg -Fq 'unrestricted SQL' "$page"

# Metadata text uses AA-contrast tokens rather than the former #aaa.
if rg -Fq -- '--faint-light: #aaa' "$page"; then
  echo "Metadata still uses low-contrast #aaa" >&2
  exit 1
fi

# Directory still points to the same URL and describes the expanded scope.
rg -Fq 'href="./dbt-ai-llm/"' "$directory"
rg -Fiq 'semantic' "$directory"
rg -Fq 'AI' "$directory"

# Stale visible claims are prohibited outside the preserved translation dictionary.
visible_page="$(mktemp)"
trap 'rm -f "$prose_page" "$visible_page"' EXIT
sed '/\/\* --- i18n (EN \/ JA) added --- \*\//,$d' "$page" > "$visible_page"
if rg -q 'H1 2026|H2 2026|Coming soon|MOST EFFICIENT|Full dbt stack, most powerful|automatically and accurately' "$visible_page"; then
  echo "Visible copy contains stale roadmap or unsupported absolute claims" >&2
  exit 1
fi

# No duplicate explainer is introduced.
test ! -d "dbt-semantic-layer"
test ! -d "dbt-vs-semantic-views"

echo "semantic-layer-to-ai checks passed"
