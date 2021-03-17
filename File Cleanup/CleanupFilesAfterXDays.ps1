# to clear down folder files with files older than 30 days
#Set Veriables here
$limit = (Get-Date).AddDays(-30)
$Path = ""
$filestobedeleted = "FilesToBeDeleted" + " " + (Get-Date -Format "dd-MM-yyyy") + ".txt"
$filedeleted = "DeletedFiles" + " " + (get-date -Format "dd-mm-yyyy") + ".txt"
$logpath""
$SMTPServer""
$FromAddress""
$ToAddress""
$CCAddress""
#Do not set anything past this point!

#get items to log
Get-ChildItem -Path $Path -Recurse -Force *.* | Where-Object { !$_.PSIsContainer -and ($_.CreationTime -lt $limit) } | out-file $logpath\filestobedeleted.txt  
rename-Item -path $logpath\filestobedeleted.txt -NewName $filestobedeleted

#delete files older than $limit.
get-childitem -path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and ($_.CreationTime -lt $limit) } | Remove-Item -Recurse -Force | out-file $logpath\DeletedFiles.txt
rename-Item -path $logpath\DeletedFiles.txt -NewName $filedeleted

#send email with deleted items
Send-MailMessage -From "$FromAddress" -To "$ToAddress" -Cc "$CCAddress" -Subject "Files Deleted this week" -Body "Here is a log file of SFTP files Deleted this week" -Attachments "$logpath\*.txt" -SmtpServer "$SMTPServer"

#Clear log files
remove-item -Path $logpath\*.txt 