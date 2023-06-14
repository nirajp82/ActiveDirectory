## How is DC Locator process working
   
   DC Locator process is used by Windows systems to locate the closest available Domain Controller within an AD Domain. It relies on DNS resolution and AD sites and subnets configuration for the identification. When an AD-integrated Windows computer starts, the following will be done to locate the closest Domain Controller:
   *   The Windows computer sends an DNS query to ask for DNS resolution of _ldap._tcp.dc._msdcs.domain.com (Example: _ldap._tcp.dc._msdcs.contoso.com) SRV records.
   *   The DNS server responds with the list of registered DNS records (The records contain the list of Domain Controllers within the AD domain)
   *   The Windows computer reviews the list of SRV records and selects one according to the priority and weight assigned to the records. It will then query the DNS server to get the IP address of the selected Domain Controller
   *   The DNS server checks the A record of the Domain Controller and responds with the IP address
   *   The Windows computer contacts the selected Domain Controller and initiates the communication with it
   *   When the communication is initiated, the selected Domain Controller will check that the client computer belongs to its Active Directory site. This is done by comparing the IP address of the client computers with Active Directory configured sites and subnets. Here, there will be two possible scenarios:
         *   The Windows computer and the selected Domain Controller belong to the same Active Directory site: In this situation, the following will happen:
The selected Domain Controller provides the client computer with the site name.

            The Windows computer caches the name of its AD site and the name of the used Domain Controller. The selected Domain Controller will be used as long as it is available. The Windows computer no longer needs to re-do the localization process each time it needs to communicate with a Domain Controller.
       
   ![image](https://github.com/nirajp82/ActiveDirectory/assets/61636643/c6639028-86eb-4bd2-9524-6e17f08d31ae)
       
       *   The Windows computer and the selected Domain Controller do not belong to the same Active Directory site: In this situation, the following will happen:
             *   The selected Domain Controller provides the client computer with the site name and informs it that it is not the closest Domain Controller
            *   The Windows computer sends a DNS query to ask for DNS resolution of ldap._tcp.Computer_Site_Name._sites.dc._msdcs.domain.com (Example: _ldap._tcp.denver._sites.dc._msdcs.contoso.com) SRV records
            *   The DNS server responds with the list of registered DNS records (The records contain the list of Domain Controllers within the AD site)
            *   The Windows computer reviews the list of SRV records and selects one according to the priority and weight assigned to the records. It will then query the DNS server to get the IP address of the selected Domain Controller
            *    The DNS server checks the A record of the Domain Controller and responds with the IP address
            *    The Windows computer contacts the selected Domain Controller and initiates the communication with it
                  ![image](https://github.com/nirajp82/ActiveDirectory/assets/61636643/0d313657-f36e-4520-a9e7-8973ca21945c)




            
















* ## How domanin controller selection works:
   
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
   
   For ex:, A user attempts to access a resource on the network, such as a file share or a printer.
   * The client computer sends an authentication request to a domain controller.
   * The domain controller checks its own site to see if it is the closest domain controller to the client.
   * If the domain controller is located in the same site as the client, it processes the authentication request immediately.
   * If the domain controller is not located in the same site as the client, it refers the client to a domain controller in the nearest site.
   * Once the client is authenticated, it is granted access to the requested resource.


* ## How to get list of domain controllor for given domain?
   you can use the "nltest" command-line tool, which is included with Windows Server. 
   Here are the basic steps:
  * Open a command prompt with administrative privileges.
  * Type `nltest /dclist:<domain name>` and press Enter. Replace "<domain name>" with the name of your domain.
  * The command will display a list of domain controllers for the specified domain. The domain controller with the highest priority (lowest number) will be the primary domain controller (PDC) emulator.
  For example, if your domain is named "example.com", the command would be:
  `nltest /dclist:example.com`
   
   This command will display a list of domain controllers for the "example.com" domain, along with their priority numbers. You can use this information to select a domain controller based on your specific requirements, such as location or hardware capacity.

* ## Useful commands
* `echo %logonserver%` - This shows the DC that was used to authenticate and log in the current user
* `nltest /dsgetsite` - This shows the AD site that the current server has detected that it's in
* `nltest /dclist:` (include the colon at the end) - This shows the list of DCs in the current domain, including which site each is in.  In this example, MGLABDC4 is in the MG-AZ-EASTUS site, and MGLABDC5 is in the MG-AZ-EASTUS2 site.
* `nslookup -type=srv _ldap._tcp.mydomain.local`. - This will query the primary DNS server for all domain controller SRV records.  This should return all of the DCs in the domain.  In this example, MGLABDC4 and MGLABDC5 are returned.
* `nslookup -type=srv _ldap._tcp.mysitename._sites.dc._msdcs.mydomain.local` - This will query the primary DNS server for domain controllers that are registered in "mysitename".  In this example, only MGLABDC4 is in the site that was queried, which matches the information we found with nltest /dclist: previously.
   



   

 
   
References:
      https://concurrency.com/blog/may-2018/domain-controller-selection
