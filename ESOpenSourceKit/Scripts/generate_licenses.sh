#!/bin/bash
if [ ! -d "Pods" ]; then
  echo "\033[0;91m'Pods' directory cannot be found in '${PWD}/'"
  exit
fi

# Get save path
FILE="Pods/ESOpenSourceLicenses/ESOpenSourceLicenses/Resources/opensource-licenses.html"
if [ ! -f $FILE ]; then
  FILE="license.html"
fi
if [ "$1" != "" ]; then
  FILE="$1"
fi

# Remove original file
if [ -f $FILE ]; then
  rm -rf $FILE
fi

# HTML header
RES="<!DOCTYPE html>
<html>
<head>
  <title>Open Source Licenses</title>
  <meta charset=\"UTF-8\">
</head>
<style>
  body { background-color:#fff; margin:5px; }
  p { font-family:'Menlo'; margin-bottom:10px; display:block; background-color:#eee; border:1px solid #ddd; font-size:12px; padding:5px; }
  h2 { font-family: 'Helvetica Neue'; font-size:16px; }
</style>
<body>"

# Find LICENSE files
files=($(find Pods -type f -name LICENSE -or -name LICENSE.* -or -name COPYING -maxdepth 2))
TOTAL=0
# Iterate through the license files
for f in ${files[*]}; do
  DIRNAME=`dirname "$f"` # Retrieve the absolute directory of the LICENSE file
  BASENAME=`basename "$DIRNAME"` # Get the directory name
  CONTENTS=`cat "${f}"` # Retreive contents
  HTML=`echo "${CONTENTS}" | sed 's/</\&lt;/g' | sed 's/>/\&gt;/g'` # Replace <> with &lt;&gt;
  HTML=`echo "${HTML}" | sed 's/^$/<br><br>/g'` # Replace double newlines with <br><br> (for readability)
  HTML=`echo "${HTML}" | sed -e 's/[Ff][Uu][Cc][Kk]/*BLEEP*/g'` # Remove "F*CK" profanity

  RES="${RES}\n<h2>${BASENAME}</h2>\n<p>${HTML}</p>\n"
  ((TOTAL++))
done
RES=`echo "${RES}" | sed 's/<p><br><br>/<p>/g'` # Remove double linebreaks at the beginning of a paragraph

# Write the result to the HTML file
echo "${RES}
</body>
</html>" >> "$FILE"
L="licenses"
if [ $TOTAL == 1 ]; then
  L="license"
fi
echo "\033[0;92mOpen Source Licenses saved to '$FILE' containging ${TOTAL} ${L}"
