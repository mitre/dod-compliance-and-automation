control "VCLD-67-000015" do
  title "VAMI server binaries and libraries must be verified for their
integrity."
  desc  "Being able to verify that a patch, upgrade, certificate, etc., being
added to the web server is unchanged from the producer of the file is essential
for file validation and non-repudiation of the information.

    VMware delivers product updates and patches regularly. When VAMI is
updated, the signed packages will also be updated. These packages can be used
to verify that VAMI has not been inappropriately modified since it was
installed.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # rpm -qa|grep lighttpd|xargs rpm -V|grep -v \"lighttpd.conf\"

    If the command returns any output, this is a finding.
  "
  desc  'fix', "
    If the VAMI binaries have been modified from the default state when
deployed as part of the VCSA, the system must be wiped and redeployed or
restored from backup.

    VMware does not recommend or support recovering from such a state by
reinstalling RPMs or similar efforts.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000131-WSR-000051'
  tag gid: 'V-239723'
  tag rid: 'SV-239723r679279_rule'
  tag stig_id: 'VCLD-67-000015'
  tag fix_id: 'F-42915r679278_fix'
  tag cci: ['CCI-001749']
  tag nist: ['CM-5 (3)']

  describe command('rpm -qa|grep lighttpd|xargs rpm -V') do
    its ('stdout.strip') { should match "S.5....T.  c /opt/vmware/etc/lighttpd/lighttpd.conf"}
  end

end

