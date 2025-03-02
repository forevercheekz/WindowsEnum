write-host "Gathering Network information.."

$targetip = Get-NetIPAddress | Select-Object -Property interfacealias , IPv4Address | findstr Ethernet 

write-host $targetip

write-host "Gathering computer information. Please wait."

$targetinfo = Get-ComputerInfo | select-object -property windowsproductname, windowsregisteredowner, windowsystemroot, CsCaption, csdomain, csnetworkadapters, timezone
echo $targetinfo



write-host "Gathering possible unquoted services.."
$unquotedpaths = cmd /c wmic service get name,displayname,pathname,startmode | findstr /i "auto" | findstr /i  "*Program Files*"

if($unquotedpaths.length -ge 1) {
    echo $unquotedpaths }
  elseif($unquotedpaths.lenth -le 0) {
    write-host "No obvious tasks were found, consider further manual enumeration"
            }


write-host "Gathering user and domain information!"

$domaininfo = cmd /c net user /domain 
$domaininfo = cmd /c net group

if($domainusers.length -ge 1) {
    echo $domaininfo
    }
    elseif($domainusers.length -le 0) {
     write-host "No domain found, enumerating locally."
     }
$localinfo 
            cmd /c net user
            cmd /c net LOCALGROUP
           

write-host "Enumerating user permissions!"

 $getuser = whoami
 $userid = ($getuser -split "\\")[-1]
 write-host "Current user: $getuser"
 write-host "User Id: $userid"
 
 cmd /c net user $userid


