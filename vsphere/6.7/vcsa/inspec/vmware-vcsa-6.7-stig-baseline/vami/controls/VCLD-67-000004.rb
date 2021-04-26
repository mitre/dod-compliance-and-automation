control "VCLD-67-000004" do
  title 'VAMI must be configured to monitor remote access.'
  desc  "Remote access can be exploited by an attacker to compromise the
server. By recording all remote access activities, it will be possible to
determine the attacker's location, intent, and degree of success.

    VAMI uses the \"mod_accesslog\" module to log information relating to
remote requests. These logs can then be piped to external monitoring systems.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f
/opt/vmware/etc/lighttpd/lighttpd.conf|awk '/server\\.modules/,/\\)/'|grep
mod_accesslog

    Expected result:

            \"mod_accesslog\",

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    Navigate to and open /opt/vmware/etc/lighttpd/lighttpd.conf.

    Add the following value in the \"server.modules\" section:

    mod_accesslog

    The result should be similar to the following:

        server.modules                    = (
            \"mod_access\",
            \"mod_accesslog\",
            \"mod_proxy\",
            \"mod_cgi\",
            \"mod_rewrite\",
            \"mod_magnet\",
            \"mod_setenv\",
            # 7
        )
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000016-WSR-000005'
  tag satisfies: ['SRG-APP-000016-WSR-000005']
  tag gid: 'V-239718'
  tag rid: 'SV-239718r679338_rule'
  tag stig_id: 'VCLD-67-000004'
  tag fix_id: 'F-42910r679263_fix'
  tag cci: ['CCI-000067', 'CCI-001462']
  tag nist: ['AC-17 (1)', 'AU-14 (2)']

  describe command("/opt/vmware/sbin/vami-lighttpd -p -f /opt/vmware/etc/lighttpd/lighttpd.conf 2>/dev/null|awk '/server\.modules/,/\)/'|grep mod_accesslog|sed -e 's/^[ ]*//'").stdout.strip do
    it { should eq "\"mod_accesslog\"," }
  end

end

