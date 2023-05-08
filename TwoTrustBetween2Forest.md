Log on to a domain controller in the "a.internal" forest with administrative credentials.

Open the Active Directory Domains and Trusts snap-in by typing "domain.msc" in the Run dialog box or by searching for "Active Directory Domains and Trusts" in the Start menu.

Right-click the root of the "a.internal" domain in the console tree, and then click Properties.

Click the Trusts tab, and then click New Trust.

Click Next to begin the New Trust Wizard.

On the Trust Name page, enter the DNS name of the "b.local" forest, and then click Next.

On the Trust Type page, select Forest Trust, and then click Next.

On the Direction of Trust page, select Two-way, and then click Next.

On the Sides of Trust page, confirm that both This domain and This domain's forest are selected, and then click Next.

On the User Name and Password page, enter the username and password of a domain administrator in the "b.local" forest, and then click Next.

On the Outgoing Trust Authentication Level page, select the appropriate level of authentication for outgoing trusts, and then click Next.

On the Incoming Trust Authentication Level page, select the appropriate level of authentication for incoming trusts, and then click Next.

On the Confirmation page, review the settings, and then click Next.

On the Finish page, click Finish to create the trust.

Repeat steps 1-14 on a domain controller in the "b.local" forest, but instead specify the "a.internal" forest as the target forest when creating the trust.

Once the trusts have been created in both forests, you should be able to authenticate users and resources between the two domains.
