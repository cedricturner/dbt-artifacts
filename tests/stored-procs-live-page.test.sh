#!/bin/sh
set -eu

page="dbt-vs-stored-procs/index.html"
translations="dbt-vs-stored-procs/translations.js"

test -f "$page"
test -f "$translations"
test "$(rg -o 'class="nav-step' "$page" | wc -l | tr -d ' ')" = "7"
test "$(rg -o 'class="panel' "$page" | wc -l | tr -d ' ')" = "7"
rg -Fq '<html lang="en" class="field-notes">' "$page"
rg -Fq 'class="field-notes-route"' "$page"
rg -Fq '.field-notes [data-i18n-html="box_par"] {' "$page"
rg -Fq 'background: #fff !important;' "$page"
rg -Fq 'function renderDbtEditors()' "$page"
rg -Fq '.editor-code .tok-keyword' "$page"
rg -Fq 'this stored procedure has five steps in one file.' "$page"
rg -Fq 'the graph shows the structure that was buried in the stored procedure.' "$page"
rg -Fq 'class="language-option language-pt-br"' "$page"
rg -Fq '>Português (Brasil)<' "$page"
rg -Fq 'dbt leaves you with more to inspect and less to rerun.' "$page"
rg -Fq 'saved intermediate tables give the on-call engineer somewhere useful to start.' "$page"
rg -Fq 'The practical difference:' "$page"

node - "$page" "$translations" <<'NODE'
const fs = require('fs');
const vm = require('vm');
const html = fs.readFileSync(process.argv[2], 'utf8');
const context = {window: {}};
vm.createContext(context);
vm.runInContext(fs.readFileSync(process.argv[3], 'utf8'), context);
const keys = new Set([...html.matchAll(/data-i18n(?:-html)?="([^"]+)"/g)].map(match => match[1]));
for (const language of ['ja', 'es', 'pt-BR', 'de']) {
  const dictionary = context.window.additionalTranslations[language];
  const missing = [...keys].filter(key => !(key in dictionary));
  if (missing.length) throw new Error(`${language} is missing: ${missing.join(', ')}`);
}
NODE

echo "stored procedures live page checks passed"
