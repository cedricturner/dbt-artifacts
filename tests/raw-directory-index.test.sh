#!/bin/sh
set -eu

preview="raw-directory-index.html"
test -f "$preview"
test -f "index.html"
cmp -s "$preview" "index.html"

for path in \
  dbt-vs-stored-procs \
  dbt-vs-notebooks \
  dbt-connection-modes \
  dbt-ai-llm \
  dbt-wizard \
  dbt-state
do
  rg -q "href=\"\./$path/\"" "$preview"
  test -d "$path"
done

rg -q '<!DOCTYPE html>' "$preview"
rg -q '<main' "$preview"
rg -q '<nav[^>]*aria-label="dbt artifact directories"' "$preview"
rg -q ':focus-visible' "$preview"
rg -q '@media[^{]*\(max-width: 680px\)' "$preview"
rg -q 'README\.txt' "$preview"
rg -q 'family=Inter' "$preview"
rg -q 'dbt notes and explainers' "$preview"
rg -q 'open an explainer' "$preview"
rg -q 'Cedric Turner · shared notes' "$preview"
rg -q 'things that helped me during my time at dbt' "$preview"
rg -q '>topic<' "$preview"
rg -q '>what it explains<' "$preview"
rg -q '>time<' "$preview"
rg -Fq 'background: var(--ink)' "$preview"
rg -Fq 'color: var(--paper)' "$preview"
rg -q 'AI' "$preview"
rg -q 'LLMs' "$preview"
rg -q 'SQL' "$preview"

if rg -q '>Topic<|>What it explains<|>Time<' "$preview"; then
  echo "Preview contains title-cased interface labels" >&2
  exit 1
fi

if rg -q -- '--orange:|--blue:|--pink:|--purple:|class="marker|\.marker-' "$preview"; then
  echo "Preview contains reverted color highlights" >&2
  exit 1
fi

if rg -q 'READ-ONLY|0 loose files|>EOF<' "$preview"; then
  echo "Preview contains ambiguous file-server jargon" >&2
  exit 1
fi

if rg -q 'these were sitting in a folder, so I put them here\.' "$preview"; then
  echo "Preview contains the superseded footer copy" >&2
  exit 1
fi

if rg -q 'linear-gradient|box-shadow|border-radius' "$preview"; then
  echo "Preview contains prohibited decorative CSS" >&2
  exit 1
fi

echo "raw directory preview checks passed"
