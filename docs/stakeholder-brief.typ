// Render with:
// pandoc docs/stakeholder-brief.md --from=gfm --to=typst \
//   --lua-filter=docs/stakeholder-brief-render.lua \
//   --template=docs/stakeholder-brief-template.typ \
//   -o docs/stakeholder-brief.typ
// typst compile docs/stakeholder-brief.typ docs/stakeholder-brief.pdf

#set document(title: "RHOAI API Contract Initiative — Stakeholder Brief", author: "RHOAI API Contract Working Group")
#set page(paper: "us-letter", margin: (x: 0.65in, y: 0.55in))
#set text(font: "Red Hat Text", size: 10.5pt, fill: rgb("252a30"))
#set par(justify: false, leading: 0.45em)
#set block(spacing: 7pt)
#set heading(numbering: none)
#show heading.where(level: 1): set text(font: "Red Hat Display", size: 23pt, weight: "bold", fill: rgb("151515"))
#show heading.where(level: 1): set block(above: 0pt, below: 9pt)
#show heading.where(level: 2): set text(font: "Red Hat Display", size: 11.5pt, weight: "bold", fill: rgb("a30000"))
#show heading.where(level: 2): set block(above: 13pt, below: 5pt)
#set table(
  inset: (x: 8pt, y: 6pt),
  stroke: (
    top: none,
    left: none,
    right: none,
    bottom: (paint: rgb("d9dde2"), thickness: 0.5pt),
  ),
  fill: (x, y) => if y == 0 { rgb("eef0f2") } else { none },
)
#set table.hline(stroke: (paint: rgb("c6ccd3"), thickness: 0.6pt))
#show table: set text(size: 10pt)
#show table.cell.where(y: 0): set text(size: 9.5pt, weight: "bold", fill: rgb("454d57"))
#show figure.where(kind: table): it => block(above: 2pt, below: 2pt, breakable: false, it.body)
#show link: it => {
  if it.dest.starts-with("http") {
    text(fill: rgb("0066cc"), it)
  } else {
    it.body
  }
}

#let brief-meta(date, status) = block(above: 0pt, below: 11pt)[
  #grid(
    columns: (1fr, auto),
    align: (left, right),
    text(size: 9.5pt, fill: rgb("59636f"))[Stakeholder brief · Date: #date],
    box(fill: rgb("f5ede0"), radius: 3pt, inset: (x: 8pt, y: 4pt))[
      #text(size: 9pt, weight: "medium", fill: rgb("76531b"))[Status: #status]
    ],
  )
  #v(9pt)
  #line(length: 100%, stroke: (paint: rgb("c9190b"), thickness: 1.5pt))
]

#let brief-summary(body) = block(
  width: 100%,
  above: 0pt,
  below: 2pt,
  inset: (x: 11pt, y: 9pt),
  fill: rgb("f5f6f7"),
  radius: 3pt,
)[
  #text(size: 11pt, fill: rgb("303842"))[#body]
]

#let brief-footer(body) = block(above: 11pt, below: 0pt)[
  #line(length: 100%, stroke: (paint: rgb("d9dde2"), thickness: 0.5pt))
  #v(5pt)
  #set par(leading: 0.4em)
  #text(size: 8.5pt, fill: rgb("59636f"))[#body]
]

= RHOAI API Contract Initiative
<rhoai-api-contract-initiative>
#brief-meta([October 9, 2026], [in review --- re-acceptance required])
#brief-summary[Move API compatibility feedback into component pull requests so teams
can catch integration failures earlier, with clear ownership and a
repeatable path for intentional changes.]
== Why this matters
<why-this-matters>
The August 2026 Dashboard gap analysis classified #strong[132 of 194
reviewed issues as upstream component bugs] and found no consumer-facing
contract tests in the ten assessed repositories. Dashboard integration
tests frequently reveal provider failures after components are
assembled, creating rework and release risk. These findings motivate
earlier checks; they do not mean every historical bug would be prevented
by contract testing.

== Proposed approach
<proposed-approach>
Provider teams keep canonical API definitions and behavior tests beside
their implementation. Consumers, including Dashboard, record the
operations and behavior they depend on. The API Contract testing infra
supplies shared compatibility policy, reusable CI checks, and a catalog
pointing to these artifacts.

Each provider pull request generates a fresh contract, checks that
committed artifacts are current, and compares against protected branch
and supported-release baselines. Consumer expectations and provider
behavior tests cover semantics that schema comparisons cannot prove.
Checks begin in report-only mode; enforcement follows evidence and owner
agreement. Intentional breaks require a reviewed migration or
deprecation plan and affected-consumer approval. Cross-component release
conformance is part of the longer-term model.

== First pilot: Model Catalog → Dashboard
<first-pilot-model-catalog--dashboard>
The proposed #strong[October 5--16, 2026] pilot covers the Model Catalog
REST v1 API used by the Dashboard Model Catalog BFF. An October 9
upstream review found the Dashboard BFF currently targets `v1alpha1`
while the provider ships `v1` Catalog paths; this mismatch must be
resolved before implementation, so the execution window requires
re-acceptance. Once re-accepted, the pilot adds a report-only OpenAPI
compatibility check and provider-facing consumer coverage for
model/version list and lookup, pagination, not-found, and authorization
behavior.

#strong[Week 1:] confirm owners and baselines; integrate the provider
check and consumer profile.

#strong[Week 2:] exercise compatible, breaking, and stale-artifact
changes; publish a scorecard and recommend whether to enforce or
continue reporting.

Operator/CRD checks and a multi-component release matrix are follow-on
work. The broader cohort includes `opendatahub-operator` and
`workbenches-operator`.

== Ownership and stakeholder support
<ownership-and-stakeholder-support>
#figure(
  align(center)[#table(
    columns: (38%, 62%),
    align: (left,left,),
    table.header([Responsibility], [Proposed representative /
      commitment],),
    table.hline(),
    [Facilitation], [Edson Tirelli],
    [Consumer profile and tests], [Anthony Coughlin / Dashboard],
    [Provider implementation and checks], [Edson Tirelli / Model
    Catalog],
    [Supported-release baseline], [Rishab Prasad / Radim Kubis; confirm
    provider revision],
  )]
  , kind: table
  )

== Success and decision requested
<success-and-decision-requested>
Success means seeded incompatibilities and stale artifacts are detected,
an additive change passes, feedback arrives in #strong[under five
minutes without a cluster];, results are reproducible locally, and at
least one real pull request runs without an unexplained false block.
Deliverables are a scorecard, reusable onboarding template, and an
enforce/continue-reporting recommendation.

#brief-footer[#strong[Tracking:]
#link("https://redhat.atlassian.net/browse/RHOAIENG-96904")[RHOAIENG-96904]
· #strong[Basis:]
#link("architecture/proposal.md")[Architecture proposal];,
#link("pilot/model-registry-dashboard.md")[pilot definition];, and
#link("research/dashboard-integration-gap-analysis.html")[gap analysis];.]

#context { metadata(counter(page).final().first()) }
