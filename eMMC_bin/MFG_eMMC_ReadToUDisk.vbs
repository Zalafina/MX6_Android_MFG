Function FillZero(str)
    tempstr=str
    if len(str)=1 then
        tempstr="0" & str
    end if
    FillZero=tempstr
End Function

Function ConvertDateTime(tDateTime)
    tempstr=tDateTime
    if isdate(tDateTime) then
        tempstr=year(tDateTime) & "-" & FillZero(month(tDateTime)) & "-" & FillZero(day(tDateTime)) & "_" & FillZero(cstr(hour(tDateTime))) & "_" & FillZero(cstr(minute(tDateTime)))
    end if
    ConvertDateTime=tempstr
End Function

Function ReplaceRegEx(inputStr, patrn, replStr)
Dim regEx,retStr
Set regEx = New RegExp
regEx.Pattern = patrn
regEx.IgnoreCase = True
regEx.MultiLine = False
regEx.Global = True

blfind = regEx.Test(inputStr)
if blfind then
    retStr = regEx.Replace(inputStr, replStr)
    'retStr = Replace(retStr, replStr & vbCrLf, replStr & vbLf)
    ReplaceRegEx = retStr
else
    retStr = inputStr & vbNewLine & replStr & vbNewLine
    'retStr = Replace(retStr, replStr & vbCrLf, replStr & vbLf)
    ReplaceRegEx = retStr
end if

End Function

Set wshShell = CreateObject("WScript.shell")
Currentdate=ConvertDateTime(Now)
Dim Fso,TxtFl,Str
Set Fso = CreateObject("Scripting.FileSystemObject")
Set TxtFl = Fso.OpenTextFile ("..\cfg.ini",1)
Str = ReplaceRegEx ( TxtFl.ReadAll,"emmc_date.*","emmc_date = " & Currentdate)
Set TxtFl = Fso.OpenTextFile ("..\cfg.ini",2)
TxtFl.Write Str 
TxtFl.Close

wshShell.run "..\mfgtool2.exe -l ""TCU-eMMC-Read""  "
Set wshShell = Nothing
