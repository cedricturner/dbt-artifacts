#!/bin/sh
set -eu

page="dbt-core-vs-platform/index.html"
translations="dbt-core-vs-platform/translations.js"

test -f "$page"
test -f "$translations"
test "$(rg -o 'class="nav-step' "$page" | wc -l | tr -d ' ')" = "4"
test "$(rg -o 'class="scroll-section"' "$page" | wc -l | tr -d ' ')" = "4"
test "$(rg -o '<section class="scroll-section"[^>]*data-section-id=' "$page" | wc -l | tr -d ' ')" = "4"
test "$(rg -o '<option value=' "$page" | wc -l | tr -d ' ')" = "4"

rg -Fq 'id="endless-scroll-navigation"' "$page"
rg -Fq 'new IntersectionObserver' "$page"
rg -Fq "history.replaceState(null,'','#'+sectionId)" "$page"
rg -Fq "window.addEventListener('hashchange'" "$page"
rg -Fq '.scroll-layout{display:grid;grid-template-columns:170px minmax(0,1fr);gap:44px;' "$page"
rg -Fq '.section-rail{position:sticky;top:0;' "$page"
rg -Fq '.section-rail .nav-step:not(.active) .step-num{' "$page"
rg -Fq 'id="mobile-section-nav"' "$page"
rg -Fq 'class="language-option language-pt-br"' "$page"
rg -Fq '>Português (Brasil)<' "$page"
rg -Fq '.scroll-section code,.scroll-section pre{color:#20201e}' "$page"
rg -Fq 'onclick="CvPAnswer(' "$page"
rg -Fq 'onclick="CvPToggleMesh()"' "$page"

# Obvious P0/P1 AI-writing tells must stay out of visible English prose.
if rg -n 'The platform doesn.t add more dbt\. It adds|Semantic Layer serves one metric|[[:space:]]—[[:space:]]|\b(delv(e|es|ed|ing)|tapestry|beacon|game-chang(er|ing)|harness(es|ed|ing)?)\b|Let.s (dive|explore|examine|unpack)|I hope this helps|Great question' "$page"; then
  echo "obvious P0/P1 AI-writing tell found" >&2
  exit 1
fi

for language in ja es pt-BR de; do
  rg -Fq "\"$language\":{" "$translations"
done
for key in thesis_lbl jump1 jump2 jump3 rc_h tp_h gc_h; do
  rg -Fq "\"$key\":" "$translations"
done

echo "core vs platform endless-scroll checks passed"
