### Directory Service
A directory service is used to store, organize and present data in a key-value type format. Typically, directories are optimized for lookups, searches, and read operations over write operations, so they function extremely well for data that is referenced often but changes infrequently.

For ex: Active Directory is a directory services implementation that provides all sorts of functionality like authentication, group and user management, policy administration and more. Active Directory (AD) supports both Kerberos and LDAP – Microsoft AD is by far the most common directory services system in use today.

a directory service is a general term for a software system that stores and manages information about network resources, while an Active Directory is a specific type of directory service that is used in Windows environments and provides a range of advanced features and capabilities.

### ActiveDirectory

Active Directory is a directory service that is used to manage and store information about network resources, including users, computers, and other devices, and the relationships between them.

***Active Directory: Identities and Access***

Active Directory is an identity management database that allows IT teams to define what users can do on a network. As a database, Active Directory captures data in the form of objects. An object can be a single resource element, like a user, group, application, or device. 

Each object has associated attributes that allow it to be distinguished from other entities. For example, a user object would have a username, password, and email attributes that distinguish it from other objects. 

Active Directory consists of four essential services that allow it to provide identity and access management:

* Active Directory Domain Services (AD DS). This is the main service within the Active Directory protocol. Besides storing the directory information, it also controls which users can access each enterprise resource and group policies. AD DS uses a tiered structure comprising the domains, trees, and forests to coordinate networked resources.
* Active Directory Lightweight Directory Services (AD LDS). It shares the same codebase and functionality as AD DS. However, unlike AD DS, AD LDS uses the Lightweight Directory Access Protocol (LDAP), allowing it to run on multiple instances on the same server. 
* Active Directory Federation Services (AD FS). As the name suggests, AD FS is a federated identity service that provides single sign-on (SSO) capabilities. It uses many popular protocols such as OAuth, OpenID, and Secure Assertion Markup Language (SAML) to pass credentials between different identity providers. 
* Active Directory Certificate Services (AD CS). This is a service that creates on-premises public key infrastructure (PKI), allowing organizations to create, validate, and revoke certificates for internal use.

Active Directory contains multiple logical units, organized hierarchically. From smallest to largest, they are:

* Objects
* Organizational units (OUs)
* Domains
* Trees
* Forests

***Objects:***

An Active Directory object is the smallest logical unit. Examples include:

* User account
* Computer account
* Group
* Printer
* Share

Objects have one or more attributes that define their properties, limits and format. Attribute values can be multi-valued, strings, integers, Boolean (true or false), or other types. The attributes that each object has are specified in the schema.

***Organizational units (OUs):***

AD objects within a domain can be grouped into logical containers called organizational units (OUs). OUs are objects too, which allows administrators to create nested OUs. All objects in any given OU must have unique names, and each object can be in only one OU at any given time.

Be careful not to confuse OUs with AD groups. A group is a collection of AD objects, such as users, whose membership in the group grants them certain permissions. A given user can be (and usually is) a member of multiple groups. The confusion typically arises because Group Policy objects (GPOs) can be linked to OUs (but not to groups), which also affects what users, computers and other objects can and cannot do.

***Domains:***

An Active Directory domain is a logical group of objects (users, computers, OUs and so on) that is managed by the same administrative team and is usually located on the same physical network.

***Trees:***

Domains are organized into trees. An AD DS tree consists of multiple domains connected by two-way transitive trusts. Each domain in an AD DS tree shares a common schema and global catalog.

Every domain in the tree lives on the foundation of trust, which is a two-way process, meaning that as soon as a domain is created, the resources of that nascent (New) domain is by default shared with its parent domain. This allows the user to access both the resources of parent and child domains. So, simply put, if an A domain trusts B domain and B Domain shows trust on C domain, then automatically A domain trusts C domain and likewise, all domains trust each other in the Active Directory.

EXAMPLE:-
There is a parent domain called abc.com, so all other child domains branching out will bear their specific names, followed by the parent domain’s name. Like accounts.abc.com, sales.abc.com, payment.abc.com, etc. And, furthermore, these child domains can also have other multiple domains established under them, like north.sales.abc.com or north.payment.abc.com.

![image](https://user-images.githubusercontent.com/61636643/208169282-8e20e1df-0470-441a-973f-271248e1a2f9.png)

***Forests:***

A Active Directory Forest is the collection of more than one domain trees having different name spaces or roots. This means that the forest contains a number of domain trees that do not share a common name space, and also do not have the same parent domain.

But, for all the trees in the forest, there is one common configuration and global catalogue.

The Active Directory forest is the highest level of the hierarchy. While domains represent administrative boundaries, forests are the main security boundary for AD DS; it is assumed that all domain administrators within a forest are trusted to some degree. Objects in separate forests are not able to interact with each other unless the administrators of each of those forests create a trust between them.

Every Active Directory has at least one forest. Organizations can choose to have two or more Active Directory forests, or they might end up with multiple forests due to merger and acquisition (M&A) deals.

![image](https://user-images.githubusercontent.com/61636643/208174095-a45dc306-6de0-43e2-bb8c-78fd034d88ce.png)


***Physical Structure:***

Let’s briefly touch on the physical structure of Active Directory. It can be divided into:
* Hosts — Devices connected to the domain network
* Subnets — Network groups with a specified range of IP addresses and a network mask
* Sites — Groups of one or more subnets used to optimize bandwidth use by the DC replication service

The physical structure(sites) and logical structure (domains) of Active Directory are independent of each other with the following consequences.

* No required relationship between the physical structure of the network and the domain structure of the network
* Active Directory allows multiple domains in a single site in addition to multiple sites in a single domain
* There is no necessary connection between site and domain namespaces

### Domain Controller
A domain controller is a server that is responsible for allowing network users to authenticate and access network resources, such as file servers and printers, on a Windows domain. It is a central point of control for all users and computers in a Windows domain, and it manages all security-related aspects of the domain.

A domain controller (DC) is a server that runs Active Directory Domain Services and uses data stored in AD for user authentication and authorization, group management, policy administration, and additional functions.  In practice, organizations typically have multiple domain controllers in on-premises datacenters and/or in the cloud. Each DC in a domain maintains a copy of the AD database, and they synchronize data between themselves using Active Directory replication. DCs can also store the global catalog — a read-only registry of all objects in the domain’s directory and a partial copy of all objects in all other domains in the forest to facilitate searches for information about objects. A DC with this feature enabled is called a global catalog server. The primary access protocol for Active Directory is Lightweight Directory Access Protocol (LDAP).

The domain controller authenticates user login requests and maintains a database of all user accounts and security information for the domain. It is responsible for enforcing security policies and ensuring that only authorized users have access to network resources. When a user logs into a domain, the domain controller verifies the user's credentials and, if they are valid, grants the user access to the network.

Domain controllers are typically installed in an Active Directory infrastructure, which is a centralized directory service that provides a single point of control for managing and organizing network resources. Domain controllers are typically deployed in a hierarchical fashion, with a primary domain controller at the top of the hierarchy and one or more secondary domain controllers beneath it.

In addition to providing authentication and access control services, domain controllers also play a key role in synchronizing data and updating network resources. They communicate with each other to ensure that all domain controllers have the same information and are up to date, and they replicate data between domain controllers to ensure that all domain controllers have access to the same information.

Domain controllers are typically deployed in a hierarchical fashion, with a primary domain controller at the top of the hierarchy and one or more secondary domain controllers beneath it. The primary domain controller is responsible for managing the database and replicating data to the secondary domain controllers, which are responsible for providing authentication and access control services to users.

How is AD managed?

Active Directory management can be performed on domain controllers via native tools, such as:

* Active Directory Administrative Center
* Active Directory Domains and Trusts
* Active Directory Sites and Services
* Active Directory Users and Computers
* ADSI Edit
* Active Directory module for Windows PowerShell

These tools can also be installed on workstations as part of Remote Server Administration Tools (RSAT) to enable admins to manage AD remotely.

## Difference Between Domain Controller and Active Directory

Domain Controller and Active Directory are closely related and often used interchangeably, but they are not the same thing. Here is the main difference between them:

Domain Controller: A domain controller is a server that is responsible for allowing network users to authenticate and access network resources on a Windows domain. It is a central point of control for all users and computers in a Windows domain, and it manages all security-related aspects of the domain.

Active Directory: Active Directory is a centralized directory service that provides a single point of control for managing and organizing network resources. It is a database that stores information about network resources, such as users, computers, and printers, and provides a way to manage and access these resources.

In Summary,  We can think of Active Directory as a database that stores users and device configurations in AD DS. A domain controller, in contrast, is simply a server running Active Directory that authenticates users and devices. In this regard, you can think of a domain controller as a custodian, facilitator, or host of Active Directory.

1. **How Active Directory, Domain Controller, Site and domain are related?**

In Active Directory, a domain is a collection of objects that share the same Active Directory database. A domain controller is a server that manages the objects within a domain. It provides a central location for authentication and authorization of users on a network.

A site is a physical location within a network, often corresponding to a local area network (LAN) or a wide area network (WAN) that contains one or more domain controllers. Each site has a unique IP address range, which allows domain controllers to communicate with one another efficiently.

In summary, a domain is a logical collection of objects within a network, a domain controller is a server that manages those objects, and a site is a physical location within the network where domain controllers are located. Together, these components form the core of the Active Directory infrastructure, which is used to manage users, groups, and other objects within a network.

2. **What is object in a domain?**

In the context of Active Directory, an object is a data structure that represents a real-world entity, such as a user, group, computer, or network device. Objects have attributes, which are characteristics or properties of the object. For example, a user object might have attributes such as a username, password, and email address.

In a domain, objects are organized into a hierarchical structure, with the domain at the top and individual objects, such as users and groups, arranged in a tree-like structure beneath it. This allows for efficient management and organization of objects within the domain.

3. **Why active directory site may have more than one domain controller?**

Objects in a domain can be managed using tools such as the Active Directory Users and Computers snap-in, which allows administrators to create, modify, and delete objects within the domain.


An Active Directory site may have more than one domain controller for a few reasons. First, having multiple domain controllers can improve the reliability and availability of the directory service. If one domain controller goes offline for any reason, the other domain controllers can continue to provide directory services to users. Additionally, having multiple domain controllers can improve the performance of the directory service, as it can distribute the workload across multiple servers. This can be particularly important in large organizations with many users and a large amount of directory data. Finally, having multiple domain controllers can provide redundant backups of the directory data, which can help to protect against data loss in case of a disaster. Overall, having multiple domain controllers in an Active Directory site can provide a number of benefits in terms of reliability, performance, and data protection.

4. **Can multiple active directory site can share one common domain controller?**

Yes, multiple Active Directory sites can share a common domain controller. In fact, this is a common practice in many organizations, particularly in larger networks with multiple sites. By sharing a common domain controller, multiple sites can take advantage of the benefits of a centralized directory service, such as improved security and ease of management. Additionally, sharing a common domain controller can help to improve the performance and reliability of the directory service, as it can distribute the workload and provide redundant backups of the directory data. Overall, sharing a common domain controller can be a useful way to provide directory services to multiple sites within an organization.

5. **Relationship between Domain Controller and AD DS server role.**

The Active Directory Domain Services (AD DS) server role is a role that is installed on a domain controller and enables the domain controller to store and manage the Active Directory database. It also allows the domain controller to provide other services, such as LDAP and Kerberos authentication, DNS, and group policy management.

In short, a domain controller is a server that runs the AD DS server role and is responsible for managing access to a network and enforcing security policies for a domain by storing and replicating the Active Directory database.

6. **What is LDAP?**

LDAP:  LDAP, or Lightweight Directory Access Protocol, is an open protocol.  LDAP allows clients to connect to the directory service and request information about specific resources or groups of resources. LDAP can also be used to modify the information stored in the directory service, such as adding or deleting user accounts or changing the permissions associated with a particular resource.  It is based on the X.500 standard however it was not as network intensive as its DAP predecessor and also is designed to be simpler and easier to implement thus it is called lightweight. 

LDAP’s three main functions are:

* Update: This includes adding, deleting, or modifying directory information.
* Query: This includes searching and comparing directory information.
* Authenticate: The main authentication functions include binding and unbinding; a third function, abandon, can be used to stop a server from completing an operation. 

LDAP is commonly used to provide a single sign-on solution for large organizations, allowing users to use a single set of credentials to access multiple systems and resources. It is also often used as a central directory service for storing and managing user information, such as passwords, email addresses, and other personal details.

**LDAP Basic Concepts:**

* LDAP directory structure: LDAP directories are organized in a hierarchical tree-like structure, similar to a file system. Each node in the tree is called an "entry", and entries can have one or more "attributes", which are name-value pairs that contain information about the entry.
* LDAP operations: LDAP defines a set of operations that can be performed on the directory, such as adding, modifying, and deleting entries, as well as searching for entries based on certain criteria.
* LDAP protocols and syntax: LDAP uses a number of different protocols and syntaxes to communicate with clients and servers. These include the LDAP Data Interchange Format (LDIF) for importing and exporting data, and the LDAP URL format for specifying search criteria and other options.
* LDAP authentication: LDAP can be used to authenticate users by storing their credentials (e.g., username and password) in the directory. LDAP can also be used to store information about user permissions and access controls.

LDAP is hierarchical in nature, with a tree-like structure that allows for the organization of information into logical units, such as domains, organizations, and users. It uses a client-server model, with clients accessing directory services on a server using LDAP commands. The server, in turn, accesses directory information from a database, such as a directory server or a relational database management system.

LDAP uses simple authentication and security mechanisms, making it easy to implement and use, but it also has some limitations, such as the lack of support for encryption and the inability to handle very large directory structures. Overall, LDAP is a useful and widely-used protocol for managing directory information and providing single sign-on capabilities in large organizations.

**Difference between Kerberos and LDAP in Active Directory?**

Kerberos is the default authentication (and authorization) protocol used by Active Directory, though it is classically thought of as an authentication protocol only.  Kerberos is platform-independent and was invented at MIT, and Microsoft later adopted it beginning Windows 2000 Active Directory to provide you single sign-on access (which means you only enter your password one time when you first logon) to subsequent network resources on your network and not challenge you again for a username and password.  Kerberos is involved in nearly everything, from the moment you first logon to access your computer, to accessing the SYSVOL share on Domain Controllers, by handing out what are known as tickets, which are encrypted.  Kerberos largely replaced NTLM, an older and Microsoft’s original (with Windows NT) authentication protocol. Kerberos uses secret key cryptography to provide strong authentication for client/server applications.


LDAP is also an authentication and authorization protocol, and also methodology of organizing objects such as users, computers, and organizational units within a directory, such as Active Directory.  It is basically the list view of what you see when you open up the Active Directory Users and Computers console. 


Kerberos is more secure than LDAP, and they are often used together.  For example, when you open up the Active Directory Users and Computers console, your computer first obtains a ticket to access your Domain Controller and then uses LDAP to actually use the console itself when working with objects such as users or OUs.  Kerberos and LDAP allow you to run a heterogeneous network of Windows, Linux, UNIX and even Apple Mac clients on a Microsoft Active Directory network.


Security: Both Kerberos and LDAP are designed to provide secure access to network resources. Kerberos uses secret key cryptography to provide strong authentication, while LDAP supports secure communication using Transport Layer Security (TLS) or Secure Sockets Layer (SSL).


Overall, Kerberos and LDAP are two different technologies that are used in conjunction with Active Directory to provide secure and efficient access to network resources. Kerberos is used for authentication, while LDAP is used for accessing and managing information stored in the directory service.

References:
* https://www.digitalocean.com/community/tutorials/understanding-the-ldap-protocol-data-hierarchy-and-entry-components
* https://ipwithease.com/active-directory-vs-domain-controller/
* https://jumpcloud.com/blog/domain-controller-vs-active-directory#:~:text=Active%20Directory%20is%20a%20database,that%20authenticates%20users%20and%20devices.
* https://ipwithease.com/what-is-a-tree-in-active-directory/
* https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc755809(v=ws.10)?redirectedfrom=MSDN
* 






