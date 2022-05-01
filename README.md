# helparyum

Powershell script which generates a simple HTML help file from instructions written in a simple CSV file.



# Usage

1. Edit helparyum.csv
2. Run helparyum.ps1
3. Script will generate "helparyum.html" and "helparyum.zip"
4. Upload "helparyum.html" and media files to web server -or-
5. Send "helparyum.zip" via e-mail

File "helparyum.html" contains comments and links to media files.

"Media file" is any kind of file that can be opened by browser.

See example.



## Input

CSV file ![helparyum.csv](helparyum-input.jpg "helparyum.csv")

Format: two fields HELPTEXT and HELPMEDIA. HELPTEXT contains instructions for end user. HELPMEDIA is an (optional) media file (image, video, PDF, ...) that could be opened to better explain instruction. If there is no media, state so with "NO-MEDIA" keyword. Media links that lead to external links stay as they are.



## Output

+ HTML file ![helparyum.html](helparyum-output.jpg "helparyum.html")
+ ZIP file  ![helparyum.zip](helparyum-zip.jpg "helparyum.zip")

HTML file is named either "helparyum.html" (default) or $Title.html (replaces " " with "_") if you specify it as CLI parameter. This is intended for upload to web server.

ZIP filename convention is the same as HTML. ZIP contains main HTML file and all local media files. This is intended for sending instructions via e-mail.



## Command line parameters

-Title ..... Title of a resulting help file; also a filename for resulting HTML and ZIP files; defaut = "Helparyum"

-CSVfile ... File with instructions to read; default = "helparyum.csv"


## Syntax

+ `helparyum.ps1` ... will open helparyum.csv and create helparyum.html and helparyum.zip
+ `helparyum.ps1 -Title "One two three four"` ... will open helparyum.csv and create "one_two_three_four.html" and "one_two_three_four.zip"
+ `helparyum.ps1 -Title "One two three four" -CSVfile "1234.csv"` ... will open "1234.csv" and create "one_two_three_four.html" and "one_two_three_four.zip"

If you use space in `-Title` parameter (e.g. `-Title "One two three four"`), script will replace ` ` (space) with `_` (underscore) in HTML and ZIP filenames.



# Misc

## Filenames

Powershell should accept UTF-8 filenames. HOWEVER.. life is sooo much simpler if one uses only [a-z], [A-Z] and [0-9] in filenames. It has only been ~50 years since computers were introduced to masses, give programmers a break, will you?

One particular problem which Powershell will not be able to workaround is - `[` (left (square) bracket). Don't use `[` in filenames. I am not a programmer and I have a hard time dealing with that. It's comforting to see that 2 trillion dollar companies also have problems with it.


## ToDo


### High priority

+ generate .MD file
+ generate .list file with list of files to be uploaded to web server
+ ideally: generete a "ncftput" script


### Low priority (if ever)

+ bulleted list in addition to numbered (optional parameter "-Bulleted")
+ download media from external links so they can be included in .ZIP



###### Public domain images and videos taken from https://www.pexels.com

+ https://www.pexels.com/@oleg-magni/
+ https://www.pexels.com/@olenkasergienko/
+ https://www.pexels.com/@rethaferguson/
+ https://www.pexels.com/@swisshumanity-1686058/

###### PDF taken from https://archive.org

+ https://ia802902.us.archive.org/25/items/VICMachineCodeMonitor/VIC_Machine_Code_Monitor_text.pdf



###### Helparyum Version 22.0430.12 ... (C)2022 SomwareHR ... License: MIT
