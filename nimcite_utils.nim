import strformat, os, json, sequtils, strutils

type
  Reference = object
    rtype*: string
    citation*: string
    inline*: string
const refFile* = "references.json"

proc mergeReferenceFiles*(files: seq[string]) =
  discard

proc exportRefs*(exportTo: string, format: string, exportFile: string) =
  if not fileExists(refFile):
    echo "No references to export."
    return
  let content = readFile(refFile)
  let references = parseJson(content).to(seq[Reference])
  for reference in references:
    echo reference.citation


proc saveReference(reference : Reference, refFile: string) =
  var references: seq[Reference] = @[]
  if fileExists(refFile):
    let content = readFile(refFile)
    references = parseJson(content).to(seq[Reference])
  references.add(reference)
  let jsonNode = %*references
  let jsonStr = jsonNode.pretty() # or jsonNode.compact() for a compact representation
  writeFile(refFile, jsonStr)


proc parseJournal*(refFile: string) =
  echo("Adding a journal reference...")
  echo("Author(s): ")
  let author = stdin.readLine()
  echo("Title of Article: ")
  let title = stdin.readLine()
  echo("Journal Name: ")
  let journal = stdin.readLine()
  echo("Year: ")
  let year = stdin.readLine()
  echo("Volume: ")
  let volume = stdin.readLine()
  echo("Issue: ")
  let issue = stdin.readLine()
  echo("Pages: ")
  let pages = stdin.readLine()

  let citation = fmt"{author} ({year}) '{title}', *{journal}*, vol. {volume}, no. {issue}, pp. {pages}."
  let inline = fmt"({author}, {year})"

  let reference = Reference(rtype: "journal", citation: citation, inline: inline)
  saveReference(reference, refFile)
  echo """Saved:
Type: {rtype}
Reference: {citation}
Inline: {inline}
  """

proc parseBook*(refFile: string) =
  echo "Adding a book reference..."
  stdout.write("Author(s): ")
  let author = stdin.readLine()
  stdout.write("Title of Book: ")
  let title = stdin.readLine()
  stdout.write("Year: ")
  let year = stdin.readLine()
  stdout.write("Edition (leave blank if 1st): ")
  let edition = stdin.readLine()
  stdout.write("Publisher: ")
  let publisher = stdin.readLine()

  let citation = if edition.len > 0:
    fmt"{author} ({year}) *{title}*. {edition} edn. {publisher}."
  else:
    fmt"{author} ({year}) *{title}*. {publisher}."

  let inline = fmt"({author}, {year})"
  let reference = Reference(rtype: "book", citation: citation, inline: inline)
  saveReference(reference, refFile)
  echo "Reference saved."

proc parseWebsite*(refFile: string) =
  echo "Adding a website reference..."
  stdout.write("Author(s) or Organisation: ")
  let author = stdin.readLine()
  stdout.write("Title/Description: ")
  let title = stdin.readLine()
  stdout.write("Year: ")
  let year = stdin.readLine()
  stdout.write("Access Date (DD/MM/YYYY): ")
  let date = stdin.readLine()
  stdout.write("URL: ")
  let url = stdin.readLine()

  let citation = fmt"{author} ({year}) *{title}*. Retrieved {date}, from {url}."
  let inline = fmt"({author}, {year})"

  let reference = Reference(rtype: "website", citation: citation, inline: inline)
  saveReference(reference, refFile)
  echo "Reference saved."

proc parseNews*(refFile: string) =
  echo "Adding a news article reference..."
  stdout.write("Author(s): ")
  let author = stdin.readLine()
  stdout.write("Title of Article: ")
  let title = stdin.readLine()
  stdout.write("Newspaper Name: ")
  let paper = stdin.readLine()
  stdout.write("Date of Publication (e.g., 12 April 2023): ")
  let date = stdin.readLine()
  let year = date.split(' ')[2]
  stdout.write("Access Date (DD/MM/YYYY): ")
  let accessDate = stdin.readLine()
  stdout.write("URL: ")
  let url = stdin.readLine()

  let citation = fmt"{author} ({date}) '{title}', *{paper}*. Retrieved {accessDate}, from {url}."
  let inline = fmt"({author}, {year})"

  let reference = Reference(rtype: "news", citation: citation, inline: inline)
  saveReference(reference, refFile)
  echo "Reference saved."

proc parseThesis*(refFile: string) =
  echo "Adding a thesis reference..."
  stdout.write("Author: ")
  let author = stdin.readLine()
  stdout.write("Title of Thesis: ")
  let title = stdin.readLine()
  stdout.write("Year: ")
  let year = stdin.readLine()
  stdout.write("Type (e.g., PhD thesis): ")
  let thesisType = stdin.readLine()
  stdout.write("Institution: ")
  let institution = stdin.readLine()

  let citation = fmt"{author} ({year}) *{title}*. {thesisType}, {institution}."
  let inline = fmt"({author}, {year})"

  let reference = Reference(rtype: "thesis", citation: citation, inline: inline)
  saveReference(reference, refFile)
  echo "Reference saved."

proc parseVideo*(refFile: string) =
  echo "Adding a video reference..."
  stdout.write("Uploader/Author: ")
  let author = stdin.readLine()
  stdout.write("Title: ")
  let title = stdin.readLine()
  stdout.write("Year: ")
  let year = stdin.readLine()
  stdout.write("Platform (e.g., YouTube): ")
  let platform = stdin.readLine()
  stdout.write("Access Date (DD/MM/YYYY): ")
  let date = stdin.readLine()
  stdout.write("URL: ")
  let url = stdin.readLine()

  let citation = fmt"{author} ({year}) *{title}*. [Video]. {platform}. Retrieved {date}, from {url}."
  let inline = fmt"({author}, {year})"

  let reference = Reference(rtype: "video", citation: citation, inline: inline)
  saveReference(reference, refFile)
  echo "Reference saved."
