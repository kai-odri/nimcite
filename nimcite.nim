import os, strutils
import nimcite_utils


proc showHelp() =
  echo """
nimcite - Harvard Referencing CLI tool

Usage:
  nimcite --journal (-j)            Add a journal article reference
  nimcite --book (-b)               Add a book reference
  nimcite --website (-w)            Add a website reference
  nimcite --news (-n)               Add a news article reference
  nimcite --thesis (-t)             Add a thesis/dissertation reference
  nimcite --video (-v)              Add an online video reference
  nimcite --export (-e)             Export all saved references
    nimcite --export <format> <filename> #filename defaults to "exported-refs"
    format = markdown (md) / html / txt #defaults to txt
  nimcite --help (-h)               Show this help message
"""

proc main() =
  let opts = commandLineParams()
  if opts.len == 0 or opts[0] in ["--help", "-h"]:
    showHelp()
    quit(0)

  case opts[0]
  of "--journal", "-j":
    parseJournal()
  of "--book", "-b":
    parseBook()
  of "--website", "-w":
    parseWebsite()
  of "--news", "-n":
    parseNews()
  of "--thesis", "-t":
    parseThesis()
  of "--video", "-v":
    parseVideo()
  of "--export", "-e":
    var exportFile = "exported-refs"
    if opts.len == 3:
      exportFile = opts[2]
      case opts[1]
      of "txt", "":
        exportRefs("txt", exportFile)
      of "markdown", "md":
        exportRefs("md", exportFile)
      of "html":
        exportRefs("html", exportFile)
      else:
        echo "Unknown args"
        showHelp()
        quit(1)
  of "--help", "-h":
    showHelp()
  else:
    echo "Unknown command: ", opts[0]
    showHelp()
    quit(1)

main()

