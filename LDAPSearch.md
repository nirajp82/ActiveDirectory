*  `member:1.2.840.113556.1.4.1941:`: The `member:1.2.840.113556.1.4.1941:` syntax you've encountered is an LDAP matching rule filter that specifies how to search for members of a group in a more efficient manner. This specific matching rule filter is often used in Active Directory environments for more optimized membership searches.
    - `member`: This is the attribute being filtered. In this case, it's the "member" attribute, which is used to store the distinguished names (DNs) of members in a group.
    - `1.2.840.113556.1.4.1941`: This is the Object Identifier (OID) that represents a specific matching rule. The OID `1.2.840.113556.1.4.1941` corresponds to the LDAP_MATCHING_RULE_IN_CHAIN rule, which is used to search for all members of a group recursively, including nested members.

    When you use `member:1.2.840.113556.1.4.1941:=<userDN>`, it effectively searches for all groups where the specified `<userDN>` is a member, including cases where the user is a member of nested groups within groups.
 
    This matching rule is especially useful when you want to find all the groups a user belongs to, even if they are members of those groups indirectly through nested group memberships. It simplifies the process of finding all group memberships for a user in a single LDAP query.

* `1.2.840.113556.1.4.803`: The Object Identifier (OID) `1.2.840.113556.1.4.803` in the context of LDAP (Lightweight Directory Access Protocol) refers to a specific matching rule known as LDAP_MATCHING_RULE_BIT_OR.

The LDAP_MATCHING_RULE_BIT_OR matching rule is used for comparing bit strings. It's primarily used in LDAP to filter or search for entries that have specific bits set in a bit string attribute.

let's consider an example where you have a binary attribute named "userFlags" in an LDAP directory, and this attribute stores a set of permission flags for users. Each bit in the "userFlags" attribute represents a specific permission or option. Here's an example of how you might use `LDAP_MATCHING_RULE_BIT_OR` to search for users with specific permissions set:

Suppose you have the following permission flags defined:

- Bit 0 (1st bit): Read permission
- Bit 1 (2nd bit): Write permission
- Bit 2 (3rd bit): Execute permission
- Bit 3 (4th bit): Admin permission

Now, you want to find all users who have the "Write" permission (2nd bit) set in their "userFlags" attribute.

Your LDAP query might look like this:

```plaintext
(&(objectClass=user)(userFlags:1.2.840.113556.1.4.803:=2))
```

- `(&(objectClass=user)` specifies that you're searching for user objects.
- `(userFlags:1.2.840.113556.1.4.803:=2)` is the filter part. It uses `LDAP_MATCHING_RULE_BIT_OR` (`1.2.840.113556.1.4.803`) to compare the "userFlags" attribute against the value `2` (which corresponds to the 2nd bit).

This query will return all user objects that have the "Write" permission set in their "userFlags" attribute.

Please note that the exact implementation and usage can vary depending on your LDAP directory and the schema you're working with. The example provided here is a simplified illustration to demonstrate the concept of using `LDAP_MATCHING_RULE_BIT_OR` for bitwise comparisons in LDAP queries.


References: https://learn.microsoft.com/en-us/windows/win32/adsi/search-filter-syntax?redirectedfrom=MSDN
