control "VCLD-67-000006" do
  title "VAMI must produce log records containing sufficient information to
establish what type of events occurred."
  desc  "After a security incident has occurred, investigators will often
review log files to determine what happened. Understanding what type of event
occurred is critical for investigation of a suspicious event.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # grep \"^accesslog.format\" /opt/vmware/etc/lighttpd/lighttpd.conf

    The default commented, accesslog format is acceptable for this requirement.
No output should be returned.

    If the command returns any output, this is a finding.
  "
  desc  'fix', "
    Navigate to and open /opt/vmware/etc/lighttpd/lighttpd.conf.

    Comment any existing accesslog.format lines by adding a \"#\" at the
beginning of the line.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000095-WSR-000056'
  tag satisfies: ['SRG-APP-000095-WSR-000056', 'SRG-APP-000096-WSR-000057',
'SRG-APP-000097-WSR-000058', 'SRG-APP-000098-WSR-000059',
'SRG-APP-000099-WSR-000061', 'SRG-APP-000100-WSR-000064',
'SRG-APP-000374-WSR-000172', 'SRG-APP-000375-WSR-000171']
  tag gid: 'V-239720'
  tag rid: 'SV-239720r679270_rule'
  tag stig_id: 'VCLD-67-000006'
  tag fix_id: 'F-42912r679269_fix'
  tag cci: ['CCI-000130', 'CCI-000131', 'CCI-000132', 'CCI-000133',
'CCI-000134', 'CCI-001487', 'CCI-001889', 'CCI-001890']
  tag nist: ['AU-3', 'AU-3', 'AU-3', 'AU-3', 'AU-3', 'AU-3', 'AU-8 b', 'AU-8 b']

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['accesslog.format'] do
    it { should eq nil }
  end

end
