use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

set _pb to the clipboard as record
set _url to string of _pb
set _title to Unicode text of _pb

tell application "Hook"
	set _hook to make bookmark with data _url
	if _hook is missing value then
		display dialog "There is no URL in the clipboard. This command requires a URL in the clipboard" buttons {"OK"}
		return
	end if
	set name of _hook to _title
end tell

tell application "Finder"
	set _files to selection
	if (count of _files) > 0 then
		repeat with _file in _files
			tell application "Hook"
				set x to (percent encode POSIX path of (_file as string))
				set _target to make bookmark with data x
				
				hook _hook and _target
			end tell
		end repeat
	else
		display dialog "No files selected"
	end if
end tell