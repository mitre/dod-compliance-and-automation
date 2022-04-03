control 'VCPG-67-000023' do
  title "VMware Postgres must use Coordinated Universal Time (UTC) for log
timestamps."
  desc  "If time stamps are not consistently applied and there is no common
time reference, it is difficult to perform forensic analysis. Time stamps
generated by VMware Postgres must include date and time expressed in UTC, a
modern continuation of Greenwich Mean Time (GMT)."
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # /opt/vmware/vpostgres/current/bin/psql -U postgres -c \"SHOW
log_timezone;\"|sed -n 3p|sed -e 's/^[ ]*//'

    Expected result:

    Etc/UTC

    If the output does not match the expected result, this is a finding.
  "
  desc 'fix', "
    At the command prompt, execute the following commands:

    # /opt/vmware/vpostgres/current/bin/psql -U postgres -c \"ALTER SYSTEM SET
log_timezone TO 'Etc/UTC';\"

    # /opt/vmware/vpostgres/current/bin/psql -U postgres -c \"SELECT
pg_reload_conf();\"
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000374-DB-000322'
  tag gid: 'V-239215'
  tag rid: 'SV-239215r717066_rule'
  tag stig_id: 'VCPG-67-000023'
  tag fix_id: 'F-42407r679017_fix'
  tag cci: ['CCI-001890']
  tag nist: ['AU-8 b']

  sql = postgres_session("#{input('postgres_user')}", "#{input('postgres_pass')}", "#{input('postgres_host')}")
  sqlquery = 'SHOW log_timezone;'

  describe sql.query(sqlquery) do
    its('output') { should be_in "#{input('pg_log_timezone')}" }
  end
end
