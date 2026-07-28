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
