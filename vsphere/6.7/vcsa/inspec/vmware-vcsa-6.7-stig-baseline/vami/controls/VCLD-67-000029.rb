control "VCLD-67-000029" do
  title 'VAMI must disable directory browsing.'
  desc  "The goal is to completely control the web user's experience in
navigating any portion of the web document root directories. Ensuring all web
content directories have at least the equivalent of an \"index.html\" file is a
significant factor to accomplish this end.

    Enumeration techniques, such as URL parameter manipulation, rely on being
able to obtain information about the web server's directory structure by
locating directories without default pages. In this scenario, the web server
will display to the user a listing of the files in the directory being
accessed. By having a default hosted application web page, the anonymous web
user will not obtain directory browsing information or an error message that
reveals the server type and version.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f
/opt/vmware/etc/lighttpd/lighttpd.conf|grep \"dir-listing.activate\"

    Expected result:

        dir-listing.activate              = \"disable\"

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    Navigate to and open /opt/vmware/etc/lighttpd/lighttpd.conf.

    Add or reconfigure the following value:

     dir-listing.activate  = \"disable\"
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000266-WSR-000142'
  tag gid: 'V-239736'
  tag rid: 'SV-239736r679318_rule'
  tag stig_id: 'VCLD-67-000029'
  tag fix_id: 'F-42928r679317_fix'
  tag cci: ['CCI-001312']
  tag nist: ['SI-11 a']

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['dir-listing.activate'] do
    it { should cmp "#{input('dirListingActivate')}" }
  end

end

