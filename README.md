# cedric turner · how I think about data systems

The most expensive thing a data organization does isn't building pipelines.

It's building the same pipeline twice, because nobody trusted the first one.

This is a collection of posts about why that happens, and what actually changes it. Not "here's how to use dbt." Closer to: here's the underlying problem that explains why these tools exist, and why teams keep struggling after they adopt them.

What I care about is the gap between *this works* and *this gets used*. That gap is almost never technical.

---

## Posts

**[The stored procedure is not your enemy](posts/stored-procedures/)**
The problem was never the technology. It's that your pipeline was built to execute, not to be inspected.

**[Data teams don't have a quality problem. They have a trust problem.](posts/trust-problem/)**
Tests tell you when something broke. They don't tell you what happened. Those are different problems.

**[Python or SQL is the wrong question](posts/python-vs-sql/)**
The language doesn't matter. Where the computation runs does.

---

## Interactive explainers

If you'd rather learn by doing, I keep a set of interactive walkthroughs on the same ideas:

- [dbt vs Stored Procedures](https://cedricturner.github.io/dbt-artifacts/dbt-vs-stored-procs/): step through a real migration
- [dbt vs Python Scripts](https://cedricturner.github.io/dbt-artifacts/dbt-vs-scripts/): see what changes when computation moves into the warehouse
- [dbt Connection Modes](https://cedricturner.github.io/dbt-artifacts/dbt-connection-modes/): how dbt connects to your warehouse, and what each option actually means
- [dbt + AI / Conversational Analytics](https://cedricturner.github.io/dbt-artifacts/dbt-ai-llm/): how the Semantic Layer becomes the contract between governed metrics and AI agents
- [dbt Wizard, explained](https://cedricturner.github.io/dbt-artifacts/dbt-wizard/): why a dbt-native agent beats a generic AI tool, told as a library (the index, the reference desk, and the librarian)

---

## About

I'm a solutions architect with a background in data engineering, moving toward product and technical marketing.

What I pay attention to is how technical systems get adopted, or don't, and why the distance between "this works" and "this gets used" is usually a visibility problem, not a capability one.

I'm drawn to the human side of technical decisions: why teams rebuild things that already exist, why they distrust platforms they helped build, and what makes a system feel legible enough to actually build on.
