# Documents

## Stakeholder brief

- [One-page overview](stakeholder-brief.md) — rationale, operating model, proposed first pilot,
  representatives, and success criteria. This Markdown file is the source of truth for current
  scope and planning; the documents below elaborate it.
- [Shareable PDF](stakeholder-brief.pdf) — one-page version of the overview.

## Pilot

- [Model Catalog–Dashboard API Contract Pilot](pilot/model-registry-dashboard.md) — first slice,
  verified upstream facts (including an open wire-version mismatch), immutable baseline design,
  implementation steps, representatives, proposed dates, and exit criteria. The existing filename
  is retained so the source brief's link continues to work.

## Architecture

- [Pilot Architecture and Delivery Proposal](architecture/proposal.md) — target operating model,
  ownership, enforcement flow, pilot cohort, onboarding, and success measures.
- [Architecture flow](architecture/architecture-flow.svg) — provider pull-request and release flow.
- [Rendered proposal](architecture/rendered/index.html) — generated HTML presentation.

## Research

- [Dashboard Integration Gap Analysis](research/dashboard-integration-gap-analysis.html) — Anthony
  Coughlin's analysis of upstream failures discovered by Dashboard Cypress.

## Regenerating rendered documents

Run from the repository root after reconciling the Markdown sources:

```sh
pandoc docs/stakeholder-brief.md --from=gfm --to=typst --lua-filter=docs/stakeholder-brief-render.lua --template=docs/stakeholder-brief-template.typ -o docs/stakeholder-brief.typ
typst compile docs/stakeholder-brief.typ docs/stakeholder-brief.pdf
typst query docs/stakeholder-brief.typ metadata --field value --one
pandoc docs/architecture/proposal.md --from=gfm --standalone --embed-resources --resource-path=docs/architecture/rendered:docs/architecture --template=docs/architecture/rendered/template.html --css=docs/architecture/rendered/style.css --lua-filter=docs/architecture/rendered/render.lua --toc --toc-depth=2 --metadata title="RHOAI API Contract Working Group" --metadata subtitle="Target architecture and Model Catalog–Dashboard pilot proposal" -o docs/architecture/rendered/index.html
perl -pi -e 's/[ \t]+$//' docs/architecture/rendered/index.html
```

The Typst query reports the PDF page count; keep the stakeholder brief to one page. The HTML
filter removes duplicate title headings and adjusts relative links for the rendered directory.
The brief's PDF filter reads the date and status from its Markdown metadata line and sets the
ownership table's column widths and left alignment.
