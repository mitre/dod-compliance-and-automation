# encoding: UTF-8

control 'V-239739' do
  title 'VAMI configuration files must be protected from unauthorized access.'
  desc  "Accounts on the VAMI server are to be kept to a minimum. Only
administrators, web managers, developers, auditors, and web authors require
accounts on the machine hosting the Lighttpd server. The resources to which
these accounts have access must also be closely monitored and controlled. Only
the system administrator needs access to all of the system's capabilities,
while the web administrator and associated staff require access and control of
the web content and the Lighttpd server configuration files."
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # stat -c \"%n permissions are %a and ownership is %U:%G\"
/opt/vmware/etc/lighttpd/lighttpd.conf /etc/applmgmt/appliance/lighttpd.conf

    Expected result:

    /opt/vmware/etc/lighttpd/lighttpd.conf permissions are 644 and ownership is
root:root
    /etc/applmgmt/appliance/lighttpd.conf permissions are 644 and ownership is
root:root

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    At the command prompt, enter the following command:

    # chmod 644 <file>
    # chown root:root <file>

    Note: Replace <file> with every file returned from the command in the check.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000380-WSR-000072'
  tag gid: 'V-239739'
  tag rid: 'SV-239739r679327_rule'
  tag stig_id: 'VCLD-67-000032'
  tag fix_id: 'F-42931r679326_fix'
  tag cci: ['CCI-001813']
  tag nist: ['CM-5 (1)']

  describe file("#{input('lighttpdConf')}") do
    it { should_not be_more_permissive_than('0644') }
    its('owner') {should eq 'root'}
    its('group') {should eq 'root'}
  end

end

