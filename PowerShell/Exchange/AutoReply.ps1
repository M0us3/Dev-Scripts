Set-MailboxAutoReplyConfiguration -Identity testgroup@contoso.com -AutoReplyState Scheduled -StartTime "11/22/2023 17:00:00" -EndTime "11/27/2023 04:00:00" -InternalMessage "Thank you for your email. Contoso Support is closed for the holiday."


Get-MailboxAutoReplyConfiguration -Identity testgroup@contoso.com
