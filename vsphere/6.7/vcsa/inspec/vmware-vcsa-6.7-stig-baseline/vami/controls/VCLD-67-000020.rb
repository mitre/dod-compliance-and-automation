control "VCLD-67-000020" do
   title "VAMI must have resource mappings set to disable the serving of certain
file types."
  desc  "Resource mapping is the process of tying a particular file type to a
process in the web server that can serve that type of file to a requesting
client and identify which file types are not to be delivered to a client.

    By not specifying which files can and cannot be served to a user, VAMI
could potentially deliver sensitive files.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f
/opt/vmware/etc/lighttpd/lighttpd.conf|grep \"url.access-deny\"

    Expected result:

        url.access-deny                   = (\"~\", \".inc\")

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    Navigate to and open /opt/vmware/etc/lighttpd/lighttpd.conf.

    Add or reconfigure the following value:

    url.access-deny             = ( \"~\", \".inc\" )
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000141-WSR-000083'
  tag gid: 'V-239728'
  tag rid: 'SV-239728r679294_rule'
  tag stig_id: 'VCLD-67-000020'
  tag fix_id: 'F-42920r679293_fix'
  tag cci: ['CCI-000381']
  tag nist: ['CM-7 a']

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['url.access-deny'] do
    it { should cmp '( "~", ".inc" )' }
  end

end

