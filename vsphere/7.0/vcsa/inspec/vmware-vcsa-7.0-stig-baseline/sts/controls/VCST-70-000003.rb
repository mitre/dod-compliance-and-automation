control 'VCST-70-000003' do
  title 'The Security Token Service must limit the maximum size of a POST request.'
  desc  "
    The \"maxPostSize\" value is the maximum size in bytes of the POST that will be handled by the container FORM URL parameter parsing. Limit its size to reduce exposure to a denial-of-service (DoS) attack.

    If \"maxPostSize\" is not set, the default value of 2097152 (2MB) is used. Security Token Service is configured in its shipping state to not set a value for \"maxPostSize\".
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # xmllint --xpath '/Server/Service/Connector[@port=\"${bio-custom.http.port}\"]/@maxPostSize' /usr/lib/vmware-sso/vmware-sts/conf/server.xml

    Expected result:

    XPath set is empty

    If the output does not match the expected result, this is a finding.
  "
  desc 'fix', "
    Navigate to and open:

    /usr/lib/vmware-sso/vmware-sts/conf/server.xml

    Navigate to each of the <Connector> nodes.

    Remove any configuration for \"maxPostSize\".

    Restart the service with the following command:

    # vmon-cli --restart sts
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000001-WSR-000001'
  tag gid: 'V-256747'
  tag rid: 'SV-256747r889211_rule'
  tag stig_id: 'VCST-70-000003'
  tag cci: ['CCI-000054']
  tag nist: ['AC-10']

  describe xml("#{input('serverXmlPath')}") do
    its('Server/Service/Connector/attribute::maxPostSize') { should eq [] }
  end
end
