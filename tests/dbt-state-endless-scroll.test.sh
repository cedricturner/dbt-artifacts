#!/usr/bin/env bash
set -euo pipefail

page="$(cd "$(dirname "$0")/.." && pwd)/dbt-state/index.html"

assert_has() {
  local pattern="$1" message="$2"
  if ! rg -q -- "$pattern" "$page"; then
    printf 'FAIL: %s\n' "$message" >&2
    exit 1
  fi
}

assert_count() {
  local expected="$1" pattern="$2" message="$3" actual
  actual="$(rg -o -- "$pattern" "$page" | wc -l | tr -d ' ')"
  if [[ "$actual" != "$expected" ]]; then
    printf 'FAIL: %s (expected %s, got %s)\n' "$message" "$expected" "$actual" >&2
    exit 1
  fi
}

assert_count 6 'class="nav-step' 'rail exposes all six sections'
assert_count 6 'class="[^"]*scroll-section' 'six scroll targets remain in document flow'
assert_has 'position:sticky;top:24px' 'desktop rail is sticky and viewport-height'
assert_has 'height:calc\(100vh - 48px\)' 'desktop rail fills the viewport'
assert_has 'grid-template-columns:142px minmax\(0,1fr\)' 'desktop rail uses the reviewed narrow width'
assert_has 'gap:clamp\(24px,3\.5vw,42px\)' 'desktop rail leaves a compact gutter beside the article'
assert_has '\.nav-step:not\(\.active\)' 'inactive markers share one outlined-circle treatment'
assert_has 'data-shape="circle"' 'curated active marker sequence starts with circle'
assert_has 'data-shape="burst"' 'curated active marker sequence ends with burst'
assert_has 'id="mobile-section-nav"' 'mobile sticky section selector exists'
assert_has 'id="language-current"' 'approved language menu trigger exists'
assert_has 'history\.replaceState' 'scroll state updates the URL hash'
assert_has "addEventListener\('hashchange'" 'hash changes navigate to sections'
assert_has 'IntersectionObserver' 'section tracking uses progressive enhancement observer'
assert_has 'Cost Insights makes the savings a number' 'substantive Cost Insights content remains'
assert_has 'data-lang="pt"' 'Portuguese translation remains available'
assert_has 'data-lang="es"' 'Spanish translation remains available'

if rg -q -- 'You turn it on and it just runs|No manifest scripts, no sub-selectors, no babysitting|That is the whole idea:|trust me, it.s cheaper' "$page"; then
  printf 'FAIL: reviewed P1/P2 AI-writing tells remain in visible English prose\n' >&2
  exit 1
fi
if rg -qi -- 'I hope this helps|Great question|Experts believe|As of my last update|the future looks bright|only time will tell' "$page"; then
  printf 'FAIL: P0/P1 AI-writing tell found\n' >&2
  exit 1
fi

printf 'PASS: dbt State endless-scroll structure and content invariants\n'
