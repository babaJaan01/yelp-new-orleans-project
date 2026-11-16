// Native Quarto/Typst styling: no external fonts, images or design packages.
#set document(title: "Where to Find the Best Breakfast and Coffee in New Orleans", author: "Shayaan Tanveer")
#set text(fill: rgb("#1F2937"))
#set par(justify: false, leading: 0.6em)
#set text(hyphenate: false)
#set page(
  header: text(size: 8pt, fill: rgb("#6B7280"))[MATH 167R / YELP NEW ORLEANS],
  footer: context grid(columns: (1fr, auto),
    text(size: 8pt, fill: rgb("#6B7280"))[Shayaan Tanveer],
    text(size: 8pt, fill: rgb("#6B7280"))[#counter(page).display() / #counter(page).final().first()]),
)
#show heading: set text(fill: rgb("#7C2D12"), weight: "bold")
#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 14pt)
#show heading.where(level: 2): set block(above: 1.4em, below: 0.8em)
#set table(inset: (x: 6pt, y: 5pt), stroke: none,
  fill: (x, y) => if y == 0 { rgb("#FFEDD5") }
    else if calc.odd(y) { rgb("#FFF7ED") } else { white })
#show table.cell.where(y: 0): set text(weight: "bold", fill: rgb("#9A3412"))
#show table: set text(size: 9pt)
#show figure.caption: set text(size: 9pt, fill: rgb("#6B7280"))
#show link: set text(fill: rgb("#C2410C"))
#show quote: set text(size: 11pt)
#let result-card(title, choice) = block(width: 100%, fill: rgb("#FFEDD5"),
  inset: (x: 10pt, y: 7pt), radius: 4pt, above: 0.6em,
  grid(columns: (1fr, auto), align: horizon,
    text(size: 12pt, weight: "bold")[#title],
    text(size: 15pt, weight: "bold", fill: rgb("#C2410C"))[#choice]))
