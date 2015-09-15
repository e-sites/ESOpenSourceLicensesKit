require 'optparse'
require 'find'

# Get save path
htmlFilePath = "license.html"

outputDir = "./Pods/"
postinstall = false

# Custom output path
OptionParser.new do |opts|
  opts.banner = "Usage: " + File.basename($0) + " [options]"
  opts.on('-p', '--post_install', 'Run this script as a post_install hook for CocoaPods. Using this with -i or -o could cause problems.') { postinstall = true }
  opts.on('-i', '--input DIRECTORY', 'Project Pods directory to search LICENSE files in. Default is \'./Pods/\'') { |v| outputDir = v }
  opts.on('-o', '--output FILE', 'Output file to write HTML to. Default is \'./licenses.html\'') { |v| htmlFilePath = v }
end.parse!

if postinstall
  htmlFilePath = "Pods/ESOpenSourceLicensesKit/ESOpenSourceLicensesKit/Resources/opensource-licenses.html"
end

if !Dir.exists?(outputDir)
  print "\033[0;91m'" + outputDir + "' directory cannot be found\n"
  exit
end

# Remove original file
if File.exists?(htmlFilePath)
  File.delete(htmlFilePath)
end

# HTML header
htmlContents = "<!DOCTYPE html>
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

licenseFiles = []
Find.find(outputDir) do |path|
  licenseFiles << path if path =~ /LICENSE|COPYING(|.*)$/
end

licenseFiles = licenseFiles.sort{ |a,b| a.downcase <=> b.downcase }

licenseNamesDone = []
for licenseFile in licenseFiles
  dirName = File.basename(File.dirname(licenseFile)) # Retrieve the absolute directory of the LICENSE file
  if licenseNamesDone.include?(dirName) # Check if a license isn't already added
    next
  end
  licenseNamesDone << dirName
  file = File.open(licenseFile, "r")
  contents = file.read # Read the LICENSE file
  contents = contents.gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;') # Replace <> with &lt;&gt;
  contents = contents.gsub(/[\n]{2}/, '<br><br>') # Replace double newlines with <br><br> (for readability)
  contents = contents.gsub(/(fuck|shit|crap)/i, '*BEEP*') # Profanity check
  htmlContents += "\n<h2>" + dirName + "</h2><p>" + contents + "</p>\n"
end

# Close the HTML file
htmlContents += "</body>
</html>"

# Write the result to the HTML file
File.open(htmlFilePath, 'w') { |file| file.write(htmlContents) }

s = licenseNamesDone.length == 1 ? "" : "s"
print "\033[0;92mOpen Source Licenses saved to '" + htmlFilePath + "' containing #{licenseNamesDone.length} license" + s + "\n"
