#!/bin/bash

# Grab arguments
# -> Target file location
TARGETDIR=$1
# -> Version && Type && Terminal
VERS=$2
TYPE=$3
TERM=$4
COMM=$5

# FAILED
function ERROR() {
    if [ -n "$FAIL" ]; then
        echo "$FAIL"
        exit 1
    fi
}

# Find target files
# -> Check for executable files
EXEC=$(find $TARGETDIR -executable -type f)
if [ $? -ne 0 ]; then
  FAIL="Error finding executable files in directory."
else
  if [ -z "$EXEC" ]; then
    FAIL="No executable files found in directory."
  else
    FAIL=""
  fi
fi

ERROR

# -> Supported image formats
PNG='png'
SVG='svg'
ICON=""
# -> Check for supported image files
for file in $TARGETDIR*; do
  if [ -f "$file" ]; then
    filename="$file"
    extension="${filename##*.}"
    if [ "$extension" == $PNG ] || [ "$extension" == $SVG ]; then
      ICON="$file"
      break
    fi
  fi
done

if [ -z "$ICON" ]; then
  FAIL="No png or svg file found in directory."
else
  FAIL=""
fi

ERROR
