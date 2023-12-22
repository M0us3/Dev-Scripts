Set-MailboxAutoReplyConfiguration -Identity preaward@scripps.edu -AutoReplyState Scheduled -StartTime "11/22/2023 17:00:00" -EndTime "11/27/2023 04:00:00" -InternalMessage "Thank you for your email. The Scripps Research Institute is closed 11/23 and 11/24 in observance of the Thanksgiving Holiday. We will respond to all emails Monday, 11/27."


Get-MailboxAutoReplyConfiguration -Identity preaward@scripps.edu
