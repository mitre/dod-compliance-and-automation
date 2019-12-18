control "VCLD-67-000033" do
  title "VAMI must be protected from being stopped by a non-privileged user."
  desc  "An attacker has at least two reasons to stop a web server. The first
is to cause a DoS, and the second is to put in place changes the attacker made
to the web server configuration. "
  tag component: "vami"
  tag severity: nil
  tag gtitle: "SRG-APP-000435-WSR-000147"
  tag gid: nil
  tag rid: "VCLD-67-000033"
  tag stig_id: "VCLD-67-000033"
  tag fix_id: nil
  tag cci: "CCI-002385"
  tag nist: ["SC-5", "Rev_4"]
  tag false_negatives: nil
  tag false_positives: nil
  tag documentable: nil
  tag mitigations: nil
  tag severity_override_guidance: nil
  tag potential_impacts: nil
  tag third_party_tools: nil
  tag mitigation_controls: nil
  tag responsibility: nil
  tag ia_controls: "SC-5"
  tag check: "At the command prompt, execute the following command:

# ps -f -U root | awk '$0 ~ /vami-lighttpd/ && $0 !~ /awk/ {print}'

If the \"vami-lighttpd\" process is not owned by \"root\", this is a finding."
  tag fix: "Navigate to and open /usr/lib/systemd/system/vami-lighttp.service
in a text editor.

Under the \"[Service]\" section, remove the line that beings with \"User=\".

At the command prompt, execute the following command:

# service vami-lighttp restart"

  describe processes('vami-lighttpd') do
    its('users') { should eq ['root'] }
  end

end