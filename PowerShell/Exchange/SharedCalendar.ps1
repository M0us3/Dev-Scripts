$SharedCalendars = Get-MailboxFolderPermission -Identity "krobbins_shared@scripps.edu:\Calendar" | Where-Object {$_.AccessRights -like "*Sharing*"}
