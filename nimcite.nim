import os, strutils
import nimcite_utils


proc showHelp() =
  echo """
nimcite - Harvard Referencing CLI tool

Usage:
  nimcite --journal (-j)              Add a journal article reference
  nimcite --book (-b)                 Add a book reference
  nimcite --website (-w)              Add a website reference
  nimcite --news (-n)                 Add a news article reference
  nimcite --thesis (-t)               Add a thesis/dissertation reference
  nimcite --video (-v)                Add an online video reference
  nimcite --export (-e)                       Export all saved references
    nimcite --export <format> <filename>      # format = markdown (md) / html / txt
  nimcite --file (-f) <filename>              Specify reference file (default: references.json)
  nimcite --merge (-m) <file1> <file2> ...    Merge a number of reference files into file1
  nimcite --help (-h)                         Show this help message
"""

proc main() =
  var refFile = "references.json"
  var opts = commandLineParams()
  var i = 0

  while i < opts.len:
    case opts[i]
    of "--file", "-f":
      if i + 1 < opts.len:
        refFile = opts[i + 1]
        i += 2
      else:
        echo "Missing filename for --file"
        quit(1)

    of "--merge", "-m":
      if i + 2 < opts.len:
        var filesToMerge: seq[string] = @[]
        for j in i..opts.len:
          filesToMerge.add(opts[j])
        mergeReferenceFiles(filesToMerge)
        quit(0)
      else:
        echo "Usage: --merge <file1> <file2>"
        quit(1)

    of "--journal", "-j":
      parseJournal(refFile)
      quit(0)
    of "--book", "-b":
      parseBook(refFile)
      quit(0)
    of "--website", "-w":
      parseWebsite(refFile)
      quit(0)
    of "--news", "-n":
      parseNews(refFile)
      quit(0)
    of "--thesis", "-t":
      parseThesis(refFile)
      quit(0)
    of "--video", "-v":
      parseVideo(refFile)
      quit(0)

    of "--export", "-e":
      var format = "txt"
      var outFile = "exported-refs"
      if i + 1 < opts.len: format = opts[i + 1]
      if i + 2 < opts.len: outFile = opts[i + 2]
      exportRefs(refFile, format, outFile)
      quit(0)

    of "--help", "-h":
      showHelp()
      quit(0)

    else:
      echo "Unknown command: ", opts[i]
      showHelp()
      quit(1)
  

main()
