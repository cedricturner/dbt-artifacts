# Semantic Layer to AI explainer redesign

## Goal

Expand the existing `dbt-ai-llm/` explainer into one continuous journey that:

1. explains what a semantic layer does;
2. compares dbt Semantic Layer, Databricks Unity Catalog metric views, and Snowflake semantic views;
3. gives readers an early, conditional recommendation; and
4. shows why governed semantic definitions matter when AI becomes a consumption interface.

The work replaces the proposed standalone semantic-layer comparison. The existing `dbt-ai-llm/` URL remains canonical.

## Audience and promise

The primary reader is a technical practitioner or technical decision-maker who understands warehouses and analytics but may not understand why semantic layers differ or why AI changes the value of governed metrics.

The page must answer two questions in order:

- Where should our business definitions live?
- Once those definitions exist, what can an AI agent safely do with them?

The page is an explainer, not a sales comparison. It must give warehouse-native options full credit and must not force a universal dbt recommendation.

## Editorial thesis

Lead with this conditional recommendation:

> Use the semantic layer that matches the boundary of your problem.

The opening should explain, without exhausting the argument:

- Start with a warehouse-native semantic layer when one warehouse is the durable boundary for metric definition, governance, and consumption.
- Consider dbt when semantic definitions need to connect to a governed transformation project and serve multiple tools or data-platform boundaries.
- Neither option removes the need for well-modeled data underneath.

The guided comparison then tests and refines this opening recommendation. The conclusion must remain conditional.

## Information architecture

The explainer has seven numbered sections.

### 1. What a semantic layer actually does

Use one recurring example: **net revenue by region**.

Explain only the concepts the rest of the page needs:

- a metric defines the calculation;
- dimensions determine how the metric may be grouped or filtered;
- entities and relationships describe how business objects connect;
- a query interface resolves the requested metric and dimensions into executable warehouse SQL;
- the semantic layer does not repair poorly modeled or incorrect upstream data.

Reuse and simplify the strongest material from the current “How the Semantic Layer is built” section.

### 2. One metric in three systems

Show the same `net_revenue` example in:

- dbt Semantic Layer;
- Databricks Unity Catalog metric views; and
- Snowflake semantic views.

Keep syntax excerpts short. The page is primarily an architecture explainer, not a technical lab. For each product, show:

- where the definition is authored and stored;
- how `net_revenue by region` is queried;
- which governance boundary owns the object;
- which consumption paths the primary documentation supports; and
- what the example does not prove.

Do not flatten unlike concepts into false equivalence. Product-specific terminology must remain intact.

### 3. Choose the boundary, not a universal winner

Present a compact decision matrix after the guided comparison.

The matrix must cover:

- durable governance boundary;
- relationship to transformation models;
- supported query and consumption paths;
- single-warehouse versus multi-platform needs;
- development and deployment workflow; and
- operational ownership.

The matrix should produce conditional guidance:

- choose Databricks-native when Unity Catalog and Databricks consumption surfaces define the real operating boundary;
- choose Snowflake-native when Snowflake is the durable definition and consumption boundary;
- consider dbt when the semantic layer must inherit from and travel with a governed dbt transformation project across supported consumption surfaces.

Every product capability in the matrix requires an inline footnote.

### 4. A definition is useful when something consumes it

This section is the visual and narrative turn from semantics to AI.

Move the current “Dashboard vs. Conversation” comparison here. Preserve its useful idea: dashboards and conversational interfaces can consume the same governed metric while offering different interaction models.

Remove unsupported universal claims about dashboards, agents, accuracy, or efficiency. Describe the interaction difference without implying that conversational interfaces are always superior.

### 5. How an agent reaches dbt

Condense the current stack, API, MCP, and configuration material into one architecture section.

Show the path:

`AI client → dbt MCP/API interface → governed semantic query → warehouse`

Distinguish semantic metric queries from discovery metadata and direct SQL. Do not represent all three paths as equally governed.

### 6. What the agent can safely do

Retain and simplify the strongest current reasoning tiers:

1. governed semantic metric query;
2. project and lineage discovery;
3. direct SQL against known models; and
4. text-to-SQL fallback.

Use concrete examples, but do not present invented business results as real data. Mock values must be visibly labeled as illustrative.

Collapse the current broad use-case catalog into the few cases that clarify the trust boundary:

- answer a governed metric question;
- investigate lineage or freshness context;
- explain why a governed metric and an ad hoc query differ; and
- fall back to SQL when no governed metric exists.

Agentic code generation, job control, and unrelated developer-assistant capabilities are outside this page's primary story and should be removed unless a short mention is required to explain a boundary.

### 7. Access, security, and the takeaway

End with:

- who or what authenticates;
- what the dbt-facing interface authorizes;
- what the warehouse still enforces;
- why a semantic query is not equivalent to unrestricted SQL access; and
- why conversational access increases the importance of explicit definitions and permissions.

Avoid roadmap statements, future dates, pricing, seat entitlements, or security claims that cannot be verified against current primary documentation.

## Interaction and visual design

- Preserve the existing single-page, step-based interaction at `dbt-ai-llm/index.html`.
- Keep seven top-level steps so the page does not grow into an unbounded scroll.
- The opening recommendation must be visible before the first step interaction requires effort.
- Use a strong visual transition between section 3 and section 4 to mark the shift from semantic architecture to AI consumption.
- Reuse the existing page's visual language unless a component prevents the revised hierarchy from reading clearly.
- Make comparison tables horizontally scrollable or responsively stacked on narrow screens.
- Preserve previous/next navigation, direct step selection, visible keyboard focus, and reduced-motion behavior.
- Do not create a second semantic-layer explainer directory.

## Title, URL, and navigation

- Keep the canonical URL: `dbt-ai-llm/`.
- Keep the current page title, **From Data to Conversation**.
- Update the directory entry description so it mentions both semantic-layer choice and AI consumption.
- Do not add a seventh directory entry; the collection remains the same number of explainers.

## Language scope

Launch the redesigned content in English first.

The current working tree contains uncommitted Japanese localization work. Implementation must not delete or overwrite that work. The language control must remain hidden in the published English-first version until every new or substantially revised visible string has a reviewed Japanese translation.

Existing Japanese strings may remain in source code for later reuse. English fallback inside an exposed Japanese mode is not acceptable.

## Citations and source policy

Use numbered inline footnotes attached to factual product claims. Selecting a footnote should move focus to the matching source entry; each source entry should link back to the claim.

End the page with a **Sources** section that:

- lists primary product documentation only;
- includes the page title, publisher, direct URL, and date checked;
- groups sources by dbt, Databricks, and Snowflake;
- uses stable numbering shared with the inline footnotes; and
- states: `Sources checked July 27, 2026`.

The minimum primary-source set is:

- [dbt Developer Hub](https://docs.getdbt.com/)
- [Databricks: Unity Catalog metric views](https://docs.databricks.com/aws/en/uc-semantics/metric-views)
- [Databricks: Manage metric views](https://docs.databricks.com/aws/en/uc-semantics/metric-views/manage)
- [Snowflake: Overview of semantic views](https://docs.snowflake.com/en/user-guide/views-semantic/overview)

Before implementation copy is finalized, open the exact dbt pages needed for semantic models, metrics, query interfaces, supported integrations, MCP, authentication, and authorization. Do not use the dbt documentation homepage as evidence for a specific capability.

Claims that cannot be traced to current primary documentation must be removed or labeled as an inference.

## Existing work and file boundaries

Primary implementation files:

- Modify `dbt-ai-llm/index.html`.
- Modify `index.html` only for the existing directory entry's name, description, or reading-time label.
- Create a focused shell test under `tests/` for structure, citations, accessibility hooks, and prohibited stale claims.
- Update `README.md` only if its existing explainer description becomes materially inaccurate.
- Reuse `dbt-ai-llm/stack-diagram.svg` only if it still matches the verified architecture; otherwise replace or revise it in place.

Do not touch unrelated current changes in:

- `dbt-connection-modes/index.html`;
- `dbt-vs-stored-procs/redesign-preview.html`;
- `dbt-wizard-benefits.pptx`;
- existing stored-procedure tests or plans; or
- any unrelated branch work.

## Verification

Automated checks must confirm:

- exactly seven top-level steps in the approved order;
- the existing `dbt-ai-llm/` URL and directory link remain intact;
- all three semantic products appear in the comparison;
- `net_revenue` is used consistently across the comparison;
- every inline footnote target exists and every source entry has a return link;
- the dated Sources section is present;
- no visible Japanese toggle ships in the English-first version;
- the current Japanese source strings are not deleted accidentally;
- previous/next and direct-step navigation still exist;
- keyboard focus styles and responsive rules exist;
- roadmap markers such as `H1 2026`, `H2 2026`, and `Coming soon` are absent from visible copy; and
- no duplicate standalone semantic-layer directory is added.

Manual review must cover:

- desktop and narrow mobile layouts;
- keyboard-only navigation;
- footnote focus movement and return links;
- the semantic-to-AI transition;
- readability of the comparison without opening every technical detail;
- accuracy against the dated primary sources; and
- preservation of unrelated working-tree changes.

## Out of scope

- Implementing the separate **Why shouldn't you get dbt?** thought exercise.
- Japanese translation of the redesigned content.
- Building a deep syntax lab or exhaustive product feature matrix.
- Changing the site's overall visual system.
- Publishing, merging, or deploying the implementation.
