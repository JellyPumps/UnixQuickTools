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
SUPPORTED_TYPES=(png svg)
ICON=""
# -> Check for supported image files
for file in $TARGETDIR*; do
  if [ -f "$file" ]; then
    filename="$file"
    extension="${filename##*.}"
    if [[ " ${SUPPORTED_TYPES[@]} " =~ " $extension " ]]; then
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

# Check of TMP dir
if [ ! -d "$HOME/TMP" ]; then
  mkdir "$HOME/TMP"
fi

# Create json file
touch $HOME/TMP/tmp.json
