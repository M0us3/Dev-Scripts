$SharedCalendars = Get-MailboxFolderPermission -Identity "TechSupportd@contoso.com:\Calendar" | Where-Object {$_.AccessRights -like "*Sharing*"}
