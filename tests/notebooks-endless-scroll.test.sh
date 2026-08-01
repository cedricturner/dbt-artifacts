#!/usr/bin/env bash
set -euo pipefail

page="dbt-vs-notebooks/index.html"

test -f "$page"
test "$(rg -o 'data-section-id="section-' "$page" | wc -l | tr -d ' ')" -eq 5
test "$(rg -o 'data-section-target="section-' "$page" | wc -l | tr -d ' ')" -eq 5
test "$(rg -o '<option value="section-' "$page" | wc -l | tr -d ' ')" -eq 5
rg -q 'class="nav section-rail"' "$page"
rg -q 'position:sticky;top:24px;height:calc\(100vh - 48px\);min-height:620px' "$page"
rg -Fq 'grid-template-columns:minmax(164px,190px) minmax(0,1fr);gap:clamp(36px,6vw,72px)' "$page"
rg -Fq 'section-rail .step-lbl{position:static' "$page"
rg -q 'nav-step:not\(.active\) \.step-num.*border-radius:52% 48% 45% 55%' "$page"
rg -q 'id="mobile-section-nav"' "$page"
rg -q 'id="endless-scroll-navigation"' "$page"
rg -q "location.hash.slice\(1\)" "$page"
rg -q "history.replaceState" "$page"
rg -Fq "rail.style.setProperty('--rail-progress'" "$page"
rg -q "scrollIntoView" "$page"
rg -q "data-shape=\"circle\"" "$page"
rg -q "data-shape=\"hexagon\"" "$page"
rg -q 'class="language-current"' "$page"
rg -q 'class="language-option language-de"' "$page"
rg -q 'code,\.field-notes \.hint.*color:#4f4c47' "$page"
! rg -q 'The next tab moves|the real difference|Less rebuilding\. Less searching\. Less waiting\.' "$page"
rg -q 'dbt moves the same work into separate warehouse models' "$page"
rg -q '<h1 data-i18n-html="h1">notebooks → dbt</h1>' "$page"
test "$(rg -o 'class="outcome-card"' "$page" | wc -l | tr -d ' ')" -eq 4
for label in 'solve breakages' 'debug' 'save time' 'save money'; do rg -Fq ">$label</h3>" "$page"; done
! rg -q 'class="debug-scenario"|class="debug-trigger"|data-i18n-html="ds[1-6]"' "$page"
for locale in ja es pt de; do rg -Fq "Object.assign(translations.$locale,{" "$page"; done
test "$(rg -o 'outcome_breakages_title:' "$page" | wc -l | tr -d ' ')" -eq 4

echo "notebooks endless-scroll checks passed"
