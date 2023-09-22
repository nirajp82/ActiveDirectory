*  `member:1.2.840.113556.1.4.1941:`: The `member:1.2.840.113556.1.4.1941:` syntax you've encountered is an LDAP matching rule filter that specifies how to search for members of a group in a more efficient manner. This specific matching rule filter is often used in Active Directory environments for more optimized membership searches.
    - `member`: This is the attribute being filtered. In this case, it's the "member" attribute, which is used to store the distinguished names (DNs) of members in a group.
    - `1.2.840.113556.1.4.1941`: This is the Object Identifier (OID) that represents a specific matching rule. The OID `1.2.840.113556.1.4.1941` corresponds to the LDAP_MATCHING_RULE_IN_CHAIN rule, which is used to search for all members of a group recursively, including nested members.

    When you use `member:1.2.840.113556.1.4.1941:=<userDN>`, it effectively searches for all groups where the specified `<userDN>` is a member, including cases where the user is a member of nested groups within groups.
 
    This matching rule is especially useful when you want to find all the groups a user belongs to, even if they are members of those groups indirectly through nested group memberships. It simplifies the process of finding all group memberships for a user in a single LDAP query.


References: https://learn.microsoft.com/en-us/windows/win32/adsi/search-filter-syntax?redirectedfrom=MSDN
