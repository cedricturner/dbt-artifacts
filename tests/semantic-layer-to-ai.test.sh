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

rg -Fq '<title>From Data to Conversation</title>' "$page"
rg -Fq '<link rel="icon" href="data:,">' "$page"
rg -q '<h1[^>]*>From Data to Conversation</h1>' "$page"

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
rg -Fq '<dt>Inference — strong fit</dt>' "$page"
if rg -qi "operational owner.*footnote\\(4" "$page"; then
  echo "Databricks permissions source is attached to an operational-owner inference" >&2
  exit 1
fi

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
rg -Fq "window.setLangAI('en');" "$page"
rg -Fq '日本語' "$page"
rg -q 'class="lang-toggle"[^>]*hidden|hidden[^>]*class="lang-toggle"' "$page"
rg -Fq '.lang-toggle[hidden]{display:none}' "$page"

# Navigation and accessibility hooks.
rg -Fq 'aria-live="polite"' "$page"
rg -Fq ':focus-visible' "$page"
rg -Fq 'prefers-reduced-motion:reduce' "$page"
rg -Fq 'onclick="nav(-1)"' "$page"
rg -Fq 'onclick="nav(1)"' "$page"

# Directory still points to the same URL and describes the expanded scope.
rg -Fq 'href="./dbt-ai-llm/"' "$directory"
rg -Fiq 'semantic' "$directory"
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
