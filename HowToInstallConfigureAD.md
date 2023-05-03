### How to install and configure Active Directory & DNS Services Windows Server 2019
* https://www.youtube.com/watch?v=TTvhkAOmujU&ab_channel=MSFTWebCast (How to Add Tree Domain in an Existing Forest | Windows Server 2019)
* https://www.youtube.com/watch?v=h3sxduUt5a8&list=PLUZTRmXEpBy32NP6z_qvVBOTWUzdTZVHt&index=3 (Setting up Active Directory in Windows Server 2019)
* https://www.youtube.com/watch?v=BEyNwwjo0u4&list=PLUZTRmXEpBy32NP6z_qvVBOTWUzdTZVHt&index=6 (How to Join Windows Server 2019 to an existing Active Directory Domain)
* https://www.youtube.com/watch?v=8teMFArShR8&ab_channel=InfoSecPat 
* https://www.youtube.com/watch?v=0tONNzREopw&ab_channel=sysadmintutorials

* Log on to the Windows Server 2019 machine as an administrator.
* Open the Server Manager by clicking the "Server Manager" icon on the taskbar or by clicking the Start button and typing "Server Manager".
* Click on the "Add Roles and Features" option from the dashboard or the "Manage" menu.
* In the "Add Roles and Features" wizard, click "Next" on the Before You Begin screen.
* Select the "Role-based or feature-based installation" option and click "Next".
* Choose the server on which you want to install the role, and click "Next".
* Select the "Active Directory Domain Services" and "DNS Server" roles from the "Select server roles" screen, and click "Add Features" when prompted.
* Click "Next" on the "Features" screen.
* Review the information on the "AD DS" screen and click "Next".
* Review the information on the "DNS Server" screen and click "Next".
* On the "Confirmation" screen, click "Install".
* Wait for the installation process to complete, and then click "Close" when prompted.
* Once the installation is complete, open the "Active Directory Users and Computers" console by typing "dsa.msc" in the Run dialog box and pressing Enter.
* In the console tree, right-click on the "Domain" node, and select "Configure a DNS Server" from the context menu.
* In the "Configure a DNS Server" wizard, select the option to "Create a forward lookup zone", and click "Next".
* Choose the "Primary zone" option, and click "Next".
* Select the appropriate replication scope for the zone, and click "Next".
* Enter a name for the zone, and click "Next".
* Choose the appropriate dynamic updates option for the zone, and click "Next".
* On the "Completing the New Zone Wizard" screen, click "Finish".
* Verify that the zone was created successfully in the "DNS Manager" console by typing "dnsmgmt.msc" in the Run dialog box and pressing Enter.
* To configure Active Directory, open the "Active Directory Users and Computers" console, right-click on the "Domain" node, and select "Raise Domain Functional Level".
* Choose the appropriate functional level for your environment, and click "Raise".
* Wait for the functional level to be raised, and then click "OK".
* Configure additional Active Directory settings as needed, such as creating user accounts, groups, and organizational units.
