version = ''
case node['ceph_micro']['version']
when 'giant'
  version = '0.87'
when 'firefly'
  version = '0.80'
else
  version = 'unsupported'
end

node.set['setup_tests']['version']['as_number'] = version

template '/tmp/ceph_version' do
  source 'version.erb'
end
