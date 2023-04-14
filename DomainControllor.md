* How to get list of domain controllor for given domain?
   you can use the "nltest" command-line tool, which is included with Windows Server. 
   Here are the basic steps:
  * Open a command prompt with administrative privileges.
  * Type `nltest /dclist:<domain name>` and press Enter. Replace "<domain name>" with the name of your domain.
  * The command will display a list of domain controllers for the specified domain. The domain controller with the highest priority (lowest number) will be the primary domain controller (PDC) emulator.
  For example, if your domain is named "example.com", the command would be:
  `nltest /dclist:example.com`
  
  This command will display a list of domain controllers for the "example.com" domain, along with their priority numbers. You can use this information to select a domain controller based on your specific requirements, such as location or hardware capacity.
