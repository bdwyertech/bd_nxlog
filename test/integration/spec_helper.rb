# Encoding: UTF-8

#
# => NXLog
#
def check_nxlog(cfg = false)
  # => Config Test
  describe command('nxlog -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/configuration OK/) }
    its(:stderr) { should match(/WARNING no routes defined!/) } unless cfg
    its(:stderr) { should match(/^$/) } if cfg
  end

  # => Verify Service
  if os[:family] == 'debian' && os[:release] == '12.04'
    # => 12.04 Hackjob
    describe command('service nxlog status') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(/[0-9]/) }
      its(:stderr) { should match(/^$/) }
    end
  else
    describe service('nxlog') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
  end
end
