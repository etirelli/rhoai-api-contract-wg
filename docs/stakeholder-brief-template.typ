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

$body$

#context { metadata(counter(page).final().first()) }
