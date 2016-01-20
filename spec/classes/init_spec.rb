require 'spec_helper'
describe 'zabbix' do

  context 'with defaults for all parameters' do
    it { should contain_class('zabbix') }
  end
end
