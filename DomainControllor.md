* How domanin controller selection works:
   https://concurrency.com/blog/may-2018/domain-controller-selection
   When a member server or workstation needs to find a domain controller, it goes through the following steps:
   * Query the primary DNS server for the all domain controller SRV records in the domain (These have the format of "_ldap._tcp.mydomain.local").
      This will return an entry for each DC in the domain.  For example, this screenshot shows the lookup result for a domain with 2 DCs, named MGLABDC4 and MGLABDC5:
      ![image](https://user-images.githubusercontent.com/61636643/232134474-21f860e1-1db9-4a92-a6c8-8515dff002f7.png)
   
   * Select the first DC in DNS result list and connect to it via LDAP
   * Determine if the chosen DC is in the same site as the member server, based on the information configured in AD Sites & Services
      * If so, the member server begins using that DC for communications
      * If not, the DC tells member server what site it is in
         * Member server sends new DNS query for the list of DCs specifically in its own site
         * Member server selects the first DC in DNS result list and connects to it via LDAP
         * If no DC in the local site is available, connect to any DC in the domain
   * Cache the name of the local site in the registry to speed up future operations
   
   If the client attempts to contact a DC that's offline, it will try to contact the next one in the list until all results are exhausted.

* How to get list of domain controllor for given domain?
   you can use the "nltest" command-line tool, which is included with Windows Server. 
   Here are the basic steps:
  * Open a command prompt with administrative privileges.
  * Type `nltest /dclist:<domain name>` and press Enter. Replace "<domain name>" with the name of your domain.
  * The command will display a list of domain controllers for the specified domain. The domain controller with the highest priority (lowest number) will be the primary domain controller (PDC) emulator.
  For example, if your domain is named "example.com", the command would be:
  `nltest /dclist:example.com`
  
  This command will display a list of domain controllers for the "example.com" domain, along with their priority numbers. You can use this information to select a domain controller based on your specific requirements, such as location or hardware capacity.

* `echo %logonserver%` - This shows the DC that was used to authenticate and log in the current user
* `nltest /dsgetsite` - This shows the AD site that the current server has detected that it's in
* `nltest /dclist:` (include the colon at the end) - This shows the list of DCs in the current domain, including which site each is in.  In this example, MGLABDC4 is in the MG-AZ-EASTUS site, and MGLABDC5 is in the MG-AZ-EASTUS2 site.
* `nslookup -type=srv _ldap._tcp.mydomain.local`. - This will query the primary DNS server for all domain controller SRV records.  This should return all of the DCs in the domain.  In this example, MGLABDC4 and MGLABDC5 are returned.
* `nslookup -type=srv _ldap._tcp.mysitename._sites.dc._msdcs.mydomain.local` - This will query the primary DNS server for domain controllers that are registered in "mysitename".  In this example, only MGLABDC4 is in the site that was queried, which matches the information we found with nltest /dclist: previously.
   



   

 
   
References:
      https://concurrency.com/blog/may-2018/domain-controller-selection
