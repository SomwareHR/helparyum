# v.22.0430.12 Beta Helparyum

param (
  [Parameter ( Mandatory=$False , HelpMessage="CSV file with instructions")]
  [ValidateNotNullOrEmpty()]
  [string]$CSVfile="helparyum.csv",

  [Parameter ( Mandatory=$False , HelpMessage="Title")]
  [ValidateNotNullOrEmpty()]
  [string]$Title="Helparyum"
)

Set-StrictMode -Version Latest
$Script:DefaultErrorActionPreference = "Stop"
# Set-Location (Split-Path $MyInvocation.MyCommand.Path)
$ErrorActionPreference = $Script:DefaultErrorActionPreference
# -----------------------------------------------------------------------------------------------------------------------------





# ------------------------------------------------------------------------------------------------------------------------------------------------------ CONST/VAR
#  .d8888b.                             888       888     888
# d88P  Y88b                            888       888     888
# 888    888                            888       888     888
# 888         .d88b.  88888b.  .d8888b  888888    Y88b   d88P 8888b.  888d888
# 888        d88""88b 888 "88b 88K      888        Y88b d88P     "88b 888P"
# 888    888 888  888 888  888 "Y8888b. 888  888888 Y88o88P  .d888888 888
# Y88b  d88P Y88..88P 888  888      X88 Y88b.        Y888P   888  888 888
#  "Y8888P"   "Y88P"  888  888  88888P'  "Y888        Y8P    "Y888888 888
# ------------------------------------------------------------------------------------------------------------------------------------------------------
$CrLf                     = "`r`n"
$TimeStampHuman           = (Get-Date -UFormat "%Y-%m-%d %H:%M")
$CSVdelimiter             = "|"
$NoMediaIndicator         = "NO-MEDIA"  # text in CSV file that indicates there is no media file to click on
$HelpFileName             = $Title.Replace(" ","_").ToLower()
$ZipFileName              = $HelpFileName+".zip"
$HTMLFileName             = $HelpFileName+".html"
$Advertisement            = "Created on $timeStampHuman with 'helparyum' https://github.com/SomwareHR/helparyum/"
$HTMLfontFamily           = "Verdana"
$HTMLfontSize             = "medium"
$HTMLanchorColor          = "#5f9ea0"
$HTMLanchorHoverColor     = "red"
$HTMLcaptionColor         = "lightsteelblue"
$HTMLcaptionHoverColor    = "darkslategrey"
$HTMLtextColor            = "white"
$HTMLheadingsColor        = "yellow"
$HTMLhrStyle              = "gray 1px dashed"
$HTMLbodyBackgroundFlavor = "bg-dark"
$HTMLbootstrapCSSFlavor1  = "https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css"
$HTMLbootstrapJSFlavor    = "https://maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"
$HTMLjqueryFlavor         = "https://ajax.googleapis.com/ajax/libs/jquery/latest/jquery.min.js"
$HTMLitemDIV              = "      <DIV class='row'>"
$HTML                     = $null

$HTMLheader1 = @"

<!doctype html>
<html lang="hr">
<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
  <meta name="description" content="$Title">
  <title>$Title</title>

  <link rel="stylesheet" href="$HTMLbootstrapCSSFlavor1">

  <STYLE type="text/css">
    a, a:visited           { color: $HTMLanchorColor }
    a:hover                { color: $HTMLanchorHoverColor }
    body                   { color: $HTMLtextColor ; font-family: "$HTMLfontFamily" ; font-size: "$HTMLfontSize" ; background-color: "$HTMLbodyBackgroundFlavor" }
    .figure-caption        { color: $HTMLcaptionColor }
    .figure-caption:hover  { background-color: $HTMLcaptionHoverColor }
    h1, h2, h3, h4, h5, h6 { color: $HTMLheadingsColor }
    hr                     { border-top: $HTMLhrStyle; }
  </STYLE>

</head>
<body>
  <BODY class="container-fluid $HTMLbodyBackgroundFlavor">
    <DIV class="text-left $HTMLbodyBackgroundFlavor" style="margin-bottom:0">
      <H1>$Title</H1><br>
    </DIV>

    <DIV class="container-fluid text-wrap text-break text-lg-left">

    <!-- ----------------------------------------------------------------------------------------------------------------------------- -->

"@

$HTMLfooter1 = @"

  <!-- ----------------------------------------------------------------------------------------------------------------------------- END -->
    </DIV>

"@

$HTMLfooter2 = @"
  <!-- ----------------------------------------------------------------------------------------------------------------------------- -->
    <script src="$HTMLjqueryFlavor"></script>
    <script src="$HTMLbootstrapJSFlavor"></script>
  </p><p class="small text-secondary">$Advertisement</p>
  </BODY>
</HTML>

"@
# ------------------------------------------------------------------------------------------------------------------------------------------------------





# ------------------------------------------------------------------------------------------------------------------------------------------------------ MAIN
#  888b     d888        d8888 8888888 888b    888
#  8888b   d8888       d88888   888   8888b   888
#  88888b.d88888      d88P888   888   88888b  888
#  888Y88888P888     d88P 888   888   888Y88b 888
#  888 Y888P 888    d88P  888   888   888 Y88b888
#  888  Y8P  888   d88P   888   888   888  Y88888
#  888   "   888  d8888888888   888   888   Y8888
#  888       888 d88P     888 8888888 888    Y888
# ------------------------------------------------------------------------------------------------------------------------------------------------------
$CSVData      = Import-Csv -Path $CSVfile -Delimiter $CSVdelimiter -Encoding "UTF8"
$HTML=$HTML+$HTMLheader1
FOR ($Counter = 0; $Counter -lt $CSVdata.Count; $Counter++) {
  $text  = $CSVData[$Counter]."HELPTEXT".trim()
  $media = $CSVData[$Counter]."HELPMEDIA".trim()
  $Counter2 = $Counter+1
  Write-Host "Adding $Counter2`: $text / $media"
  IF ($media -eq $NoMediaIndicator)      # Is this a "NO-MEDIA" indicator in .CSV file?
  {
    $link = $null
  }
  ELSE
  {
    $link ="(<a href='$media' target='_blank' title='$text ($media)'>🔗</a>)"
    IF ( ($media -match "https://") -OR ($media -match "http://") -OR ($media -match "ftp://") ) {
      # For future release maybe. Download external files?
    }
    ELSE
    {
      Compress-Archive -DestinationPath $ZipFileName -CompressionLevel Optimal -Update $media
    }
  }
  $HTML = $HTML + `
    $HTMLitemDIV + "$Counter2`. $text $link" + "</div>" + $CrLf
}
$HTML=$HTML+$HTMLfooter1
$HTML=$HTML+$HTMLfooter2

$HTML | Out-File $HelpFileName".html"

Compress-Archive -DestinationPath $ZipFileName -CompressionLevel Optimal -Update $HTMLFileName

Write-Output "$CrLf`*** The end ***$CrLf`Open $HTMLFileName in browser or send $ZipFileName via e-mail"

exit
