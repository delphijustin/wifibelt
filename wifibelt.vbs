apikey="textbelt" 'textbelt api key if it is the word textbelt than only one message per day will be sent
phone ="changeme" ' Your phone number
database = "C:\macaddrs.fin" 'MAC Address database
'DO NOT EDIT BELOW THIS LINE
dim args,objTextBelt,objShell
Set args = WScript.Arguments.Named
Set objShell = CreateObject("WScript.Shell")
rec=args.Item("mac")&chr(59)&args.Item("company")
finStat = objShell.Run("find.exe "&chr(34)&rec&chr(34)&" "&database,0,true)
if finStat=0 then
WScript.Quit 2
end if
objShell.Run "cmd.exe /C echo "&rec&" >> "&database,0,true
function URLEncode(s)
for I = 1 to len(s)
c1=""
if Asc(Mid(s,I))<16 then
c1="0"
end if
hexstr=hexstr & chr(37) & Hex(Asc(Mid(s,I)))
Next
URLEncode = hexstr
end function
ipv4 = Split(args.Item("ip"),".")
ipsms = Join(ipv4,"_")
set objTextBelt = CreateObject("MSXML2.XMLHTTP")
objTextBelt.open "GET", "https://textbelt.com/text?phone="&phone&chr(38)&"key="&apikey&chr(38)&"message="&URLEncode("WIFI_NEWCON MAC:"&args.Item("mac")&" Company:"&args.Item("company")&" IP:"&ipsms), False
objTextBelt.send
if len(args.Item("debug"))>0 then
WScript.echo objTextBelt.responseText
end if
WScript.Quit 0
