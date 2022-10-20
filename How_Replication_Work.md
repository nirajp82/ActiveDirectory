Reference: https://samilamppu.com/2017/04/23/how-ad-ds-replication-work/

AD DS (ACTIVE DIRECTORY DOMAIN SERVICES)


For a long long time I needed to deep dive in current project I’m involved to one of my favorite topics, on-premises AD DS replication.

Below is simplified version of the sequence between source and destination domain controllers when the source initiates replication by sending a change notification (picture from TechNet)



Domain Controllers use Update Sequence Numbers aka USNs to determine what changes they needs to replicate. Source determines changes that have been received and destination uses USNs to determine what changes it needs to request.

USN is found from each Domain Controller highestCommittedUsn attribute on the rootDSE object. At the start of each update transaction (originating or replicated), the DC increments its current USN and associates this new value with the update request.

You can find highestCommitedUsn number with PS “Get-ADRootDSE” or with ADSIEdit.msc

23

 

The following series of diagrams (from Microsoft Technet pages) illustrates the replication for a single object and one of its attributes from creation to replication.

User object is created on domain controller DC1 – USN 4710.
When the object is created, the local USN of 4711 is assigned to each attribute of the user object, and the current USN for the domain controller increments from 4710 to 4711.
Because the object has not yet changed, the value of its uSNChanged attribute is the same as its uSNCreated attribute 4711.
Replication-related data on DC1 when user object is created

4.PNG

 

Replication-related Data on DC2 when a New User Object is replicated from DC1

5.PNG

The following information is transferred in the metadata of an updated attribute value from the source domain controller to the destination domain controller:

The originating USN value for the updated attribute, which is the USN assigned by the domain controller on which the update was made
The stamp for resolving conflicts
 

The next diagram illustrates the change in the replicated object on DC2 when someone changes the password of the object on that domain controller.

The current USN on DC2 has increased from 1746 to 2453.
The update request changes the password and increments the current USN to 2453 on DC2.
The request also sets the password attribute’s originating USN and local USN to 2453 and creates a new stamp for the password value.
The version number of this password’s stamp is 2, which is one version number higher than the version of the previous password.
Replication-related Data on DC2 after the User Password Value Has Been Changed on DC2

Note:
How does Active Directory replication work?  
Now that we know how replication occurs at three levels of directory partition, it is essential to understand that Active Directory replication is attribute-based. To understand this let’s go back to our first example- the change in employees’ telephone numbers. Here “telephone number” is one of the attributes that define the object “employee”. When this attribute is modified, only the change in the attribute, that is the new telephone number, is replicated to all the domain controllers and not the entire object. Here comes the concept of Update Sequence Numbers (USN). When an object is created, by default a USN is assigned to them. Whenever a change is elicited these USNs are incremented making every other USN in other domain controllers go out of date for that object. To ensure that only the most recent changes are replicated, only the highest USN is stored and displayed. Thus changes are monitored and recorded with the help of USN in Active Directory.


6.PNG

 

In the next diagram, the changed password is now replicated back to the original domain controller

Current USN has increased to 5039.
The replicated update increments the current USN of DC1 to 5040.
The per-attribute originating USN and stamp (version, originating time, originating DC) are replicated from DC2 to DC1, and the per-attribute local USN and per-object uSNChanged values are set to 5040.
Replication-related Data on DC1 after the Password Change Has Replicated to DC1

7

Replication Request Filtering
Destination domain controllers use the originating USN to track changes they have received from other domain controllers with which they replicate. When requesting changes from a source domain controller, the destination informs the source of the updates it has already received so that the source never replicates changes that the destination does not need. Two values are used by source and destination domain controllers to filter updates when the destination requests changes from the source replication partner.
Up-to-dateness vector. The current status of the latest originating updates to occur on all domain controllers that store a replica of a specific directory partition
Tracking attributes to send for replication
High-watermark (direct up-to-dateness vector). The latest update (originating or replicated) to a specific directory partition that has been received by a destination from a specific source replication partner during the current replication cycle
Tracking objects to send for replication
Values can be seen with following commands:

up-to-dateness vector in the output of the repadmin /showvector
8

You can see the high-watermark in the output of the repadmin /showreps /verbose command. Look for lines that begin with “USNs:”. The high-watermark USN is the number that is followed by “/OU”.
9.png

Guideline for these vectors and tables are

For a specific directory partition, a domain controller maintains a high-watermark value for only those domain controllers from which it requests changes (direct replication partners)
But it maintains an up-to-dateness vector entry for every domain controller that has ever performed an originating update, which is typically every domain controller that holds a full replica of the directory partition.
Resolving Conflicts

Domain controllers uses different values to determine conflicts, including version number, originating time and originating DSA.

When these stamps are compared:

Version is the most significant
Followed by originating time and originating DSA
If two stamps have same version number, originating time almost always breaks the tie.
If originating time is identical then originating DSA breaks the tie in arbitrary fashion.
Conclusion

Lot’s of things happening underneath the hood. When troubleshooting replication in large environment knowledge about replication model helps a lot.

Deep dive documentation and material above found from link below:

https://adsecurity.org/?p=515

https://samilamppu.com/2017/04/23/how-ad-ds-replication-work/

https://www.techtarget.com/searchwindowsserver/definition/update-sequence-number-USN#:~:text=An%20update%20sequence%20number%20(USN,the%20greatest%20USN%20is%20retained.

https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-2000-server/cc961798(v=technet.10)?redirectedfrom=MSDN
