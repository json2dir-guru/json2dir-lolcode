# json2dir-lolcode

json2dir in LOLCODE 1.3 (lci): `json2dir.lol` checks, parses and validates the document and prints a shell script that the POSIX sh launcher `json2dir` runs. Inputs with raw NUL bytes or bytes that never occur in UTF-8 are rejected.

    JSON2DIR_LCI=/path/to/lci ./json2dir < tree.json
