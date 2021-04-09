$Inputgroupname = Read-Host -Prompt "enter group name - Wildcards can be used"
 Get-ADGroup -Filter "Name -like '$Inputgroupname'" | ForEach {

    $groupName = $_.Name

    Get-ADGroupMember -Identity $_.SamAccountName | 
        Select @{N='GroupName';E={$groupName}},SamAccountName,Name,manager

}
 
