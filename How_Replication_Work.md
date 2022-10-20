Reference: https://samilamppu.com/2017/04/23/how-ad-ds-replication-work/

AD DS (ACTIVE DIRECTORY DOMAIN SERVICES)


For a long long time I needed to deep dive in current project I’m involved to one of my favorite topics, on-premises AD DS replication.

Below is simplified version of the sequence between source and destination domain controllers when the source initiates replication by sending a change notification (picture from TechNet)

![image](https://user-images.githubusercontent.com/61636643/197015131-7319c433-ab69-44e2-bd4f-cbb26c052455.png)


Domain Controllers use Update Sequence Numbers aka USNs to determine what changes they needs to replicate. Source determines changes that have been received and destination uses USNs to determine what changes it needs to request.

USN is found from each Domain Controller highestCommittedUsn attribute on the rootDSE object. At the start of each update transaction (originating or replicated), the DC increments its current USN and associates this new value with the update request.

You can find highestCommitedUsn number with PS “Get-ADRootDSE” or with ADSIEdit.msc

![image](https://user-images.githubusercontent.com/61636643/197015207-45475903-865a-4e02-aa76-892e0dfa6cde.png)

 
![image](https://user-images.githubusercontent.com/61636643/197015248-54e7f734-b2c3-43e7-b334-a996ba872ab2.png)

The following series of diagrams (from Microsoft Technet pages) illustrates the replication for a single object and one of its attributes from creation to replication.

User object is created on domain controller DC1 – USN 4710.
When the object is created, the local USN of 4711 is assigned to each attribute of the user object, and the current USN for the domain controller increments from 4710 to 4711.
Because the object has not yet changed, the value of its uSNChanged attribute is the same as its uSNCreated attribute 4711.
Replication-related data on DC1 when user object is created

![image](https://user-images.githubusercontent.com/61636643/197015356-4efbceea-9ba2-4c16-b8e8-6999a094ec84.png)

 Replication-related Data on DC2 when a New User Object is replicated from DC1

![image](https://user-images.githubusercontent.com/61636643/197015410-4de21fdf-1d8e-464e-a284-a88909f51998.png)

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
Now that we know how replication occurs at three levels of directory partition, it is essential to understand that Active Directory replication is attribute-based. To understand this let’s go back to our first example- the change in employees’ telephone numbers. Here “telephone number” is one of the attributes that define the object “employee”. **When this attribute is modified, only the change in the attribute**, that is the new telephone number, is replicated to all the domain controllers and not the entire object. Here comes the concept of Update Sequence Numbers (USN). When an object is created, by default a USN is assigned to them. Whenever a change is elicited these USNs are incremented making every other USN in other domain controllers go out of date for that object. To ensure that only the most recent changes are replicated, only the highest USN is stored and displayed. Thus changes are monitored and recorded with the help of USN in Active Directory.


![image](https://user-images.githubusercontent.com/61636643/197015604-6521eb0f-2171-449d-88c3-800161b5dcee.png)

 
In the next diagram, the changed password is now replicated back to the original domain controller

Current USN has increased to 5039.
The replicated update increments the current USN of DC1 to 5040.
The per-attribute originating USN and stamp (version, originating time, originating DC) are replicated from DC2 to DC1, and the per-attribute local USN and per-object uSNChanged values are set to 5040.
Replication-related Data on DC1 after the Password Change Has Replicated to DC1

![image](https://user-images.githubusercontent.com/61636643/197015647-7eb06fad-8130-451a-9fba-0a281ec4049d.png)

Replication Request Filtering
Destination domain controllers use the originating USN to track changes they have received from other domain controllers with which they replicate. When requesting changes from a source domain controller, the destination informs the source of the updates it has already received so that the source never replicates changes that the destination does not need. Two values are used by source and destination domain controllers to filter updates when the destination requests changes from the source replication partner.

**Up-to-dateness vector.** The up-to-dateness vector is a value that the destination domain controller maintains for tracking the originating updates that are received from all source domain controllers. The source domain controller uses this value to reduce the set of attributes that it sends to the destination domain controller.

When a destination domain controller requests changes for a directory partition, it provides its up-to-dateness vector to the source domain controller. On the basis of this value, the source domain controller can determine that the destination does or does not have an up-to-date value (or multivalue) for an attribute, and it sends updates accordingly. If the destination already has an up-to-date value, the source domain controller does not send that attribute. If the source has no attributes to send for an object, it sends no information at all about that object.

The up-to-dateness vector can contain an entry for each domain controller that holds a full replica of the directory partition. If the up-to-dateness entry that corresponds to source domain controller X contains the USN  n , the destination domain controller guarantees that it holds all updates to a specific directory partition that originated at domain controller X and that have an originating USN value of less than or equal to  n .

The up-to-dateness vector and the high-watermark are complementary filter mechanisms that work together to decrease replication latency. Whereas the high-watermark prevents irrelevant objects from being considered by the source domain controller with respect to a single destination, the up-to-dateness vector helps the source domain controller to filter irrelevant attributes (and entire objects if all attributes are filtered) on the basis of the relationships between all sources of originating updates and a single destination.

For a specific directory partition, a domain controller maintains a high-watermark value for only those domain controllers from which it requests changes, but it maintains an up-to-dateness vector entry for every domain controller that has ever performed an originating update, which is typically every domain controller that holds a full replica of the directory partition.


**High-watermark (direct up-to-dateness vector).** When a destination domain controller requests changes to a directory partition from a source domain controller, the source domain controller provides the changes in increasing order of the usnChanged attribute value. The usnChanged values from the source domain controller are not stored on objects at the destination domain controller, but the **destination domain controller keeps track of the usnChanged value of the most recent object it successfully received from the source domain controller for a specific directory partition. This USN is called the destination's high-watermark** with respect to the directory partition and the source domain controller.
When requesting changes, the destination domain controller sends its high-watermark value to the source domain controller. The source domain controller uses the information in the high-watermark to reduce the set of objects that it must consider for replication to the destination. No object whose usnChanged value is less than or equal to the high-watermark value can hold updates that the destination domain controller has not already received.
The high-watermark serves to decrease the CPU time and number of disk I/O operations that would otherwise be required to send only the changes that the destination domain controller has not yet received.
The latest update (originating or replicated) to a specific directory partition that has been received by a destination from a specific source replication partner during the current replication cycle Tracking objects to send for replication

Values can be seen with following commands:

up-to-dateness vector in the output of the repadmin /showvector
![image](https://user-images.githubusercontent.com/61636643/197015679-0dd9addf-15a6-47d5-bf1d-0431b352cf31.png)

You can see the high-watermark in the output of the repadmin /showreps /verbose command. Look for lines that begin with “USNs:”. The high-watermark USN is the number that is followed by “/OU”.
![image](https://user-images.githubusercontent.com/61636643/197015701-68048f4c-bf92-4c7f-beb0-7493b095b8f5.png)

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
https://www.windows-active-directory.com/active-directory-replication.html
