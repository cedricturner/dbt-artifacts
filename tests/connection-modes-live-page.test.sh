#!/bin/sh
set -eu

page="dbt-connection-modes/index.html"

test -f "$page"
test "$(rg -o 'data-section-target="section-' "$page" | wc -l | tr -d ' ')" = "5"
test "$(rg -o 'data-section-id="section-' "$page" | wc -l | tr -d ' ')" = "5"
test "$(rg -o 'class="section-heading-title"' "$page" | wc -l | tr -d ' ')" = "5"
test "$(rg -o 'class="language-option ' "$page" | wc -l | tr -d ' ')" = "2"
rg -Fq 'position:sticky;top:0;height:100vh' "$page"
rg -Fq 'grid-template-columns:172px minmax(0,1fr);gap:24px' "$page"
rg -Fq '.section-rail .tab.active .rail-marker' "$page"
rg -Fq '.section-rail .tab[data-shape="hexagon"]' "$page"
rg -Fq '.section-rail .tab:not' "$page" && exit 1 || true
rg -Fq 'id="mobile-section-nav"' "$page"
rg -Fq 'id="endless-scroll-navigation"' "$page"
rg -Fq "new IntersectionObserver" "$page"
rg -Fq "history.replaceState(null,'','#'+id)" "$page"
rg -Fq "window.addEventListener('hashchange'" "$page"
rg -Fq "function selectPL(type, aud)" "$page"
rg -Fq "function setAud(aud,btn)" "$page"
! rg -Fq 'onclick="showTab' "$page"
! rg -Fq '<strong>Simple version:</strong>' "$page"
! rg -Fq '<strong>Key point:</strong>' "$page"
! rg -Fq '<strong>Is this secure?</strong>' "$page"
! rg -Fq '<strong>Do I need this?</strong>' "$page"
! rg -Fq '<strong>Which one should we use?</strong>' "$page"
! rg -Fq 'Here is a simple way to pick the right option.' "$page"
! rg -Fq 'Full flexibility, full responsibility.' "$page"

node - "$page" <<'NODE'
const fs = require('fs');
const vm = require('vm');
const html = fs.readFileSync(process.argv[2], 'utf8');
const scripts = [...html.matchAll(/<script(?:\s[^>]*)?>([\s\S]*?)<\/script>/g)].map(match => match[1]);
scripts.forEach((source, index) => new vm.Script(source, {filename: `${process.argv[2]}:script-${index + 1}`}));
NODE

echo "connection modes live page checks passed"
