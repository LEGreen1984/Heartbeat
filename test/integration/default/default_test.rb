
unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

#This tests whether heartbeat has successfully been installed.
describe package "heartbeat" do
  it { should be_installed }
end

#This tests that the service heartbeat is both installed and running.
describe service "heartbeat" do
  it { should be_enabled }
  it { should be_running }
end

#This tests that the default yaml file has been successfully been replaced by our own by checking that the heartbeat monitor's URL now includes our company name.
describe file('/etc/heartbeat/heartbeat.yml') do
  its(:content) { should match /eng22.spartaglobal.education:80/ }
end
