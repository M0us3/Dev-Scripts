Get-ADComputer -identity $ComputerName | Select name,@{n="owner";e={(Get-acl "ad:\$($_.distinguishedname)").owner}}
