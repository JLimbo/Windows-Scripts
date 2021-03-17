color a 
title Creating weekly reboot task
rem to make machine reboot weekly
schtasks /create /tn weeklyReboot /tr "shutdown /r /t 0" /sc weekly /st 00:00 /sd 20/03/2021 /d SUN /ru "System"