# This will pull the information of who created the computer object in Active Directory
Get-ADComputer -identity $ComputerName | Select name,@{n="owner";e={(Get-acl "ad:\$($_.distinguishedname)").owner}}
