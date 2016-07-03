#
# Cookbook Name:: db2
# Recipe:: install
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

unless node['db2']['installer_url']
  Chef::Application.fatal!("The installer_url attribute is required.")
end

include_recipe 'selinux::disabled'

installer = node['db2']['installer_file']
nlpack    = node['db2']['nlpack_file']
workdir   = node['db2']['working_dir']

case node['platform_family']
when 'rhel'
  package ["libstdc++", "libaio", "pam", "cpp", "gcc", "gcc-c++", "kernel-devel", "sg3_utils", "ksh"] do
    arch 'x86_64'
  end
  package ["libstdc++", "libaio", "pam"]  do
    action :upgrade
  end
  package ["libstdc++", "libaio", "pam"]  do
    arch 'i686'
  end
  case node['db2']['version']
  when '11.1'
    include_recipe 'ntp::default'
  end
when 'debian'
  case node[:platform]
  when 'ubuntu'
    if node['platform_version'].to_i >= 14 then
      execute 'dpkg --add-architecture i386' do
        action :run
      end
    end
    execute 'apt-get update' do
      action :run
    end
    package ["binutils", "libaio1", "libpam0g", "libpam0g:i386", "libstdc++6", "libstdc++6:i386", "ksh"] do
      action :install
    end
    if node['platform_version'].to_f == 12.04 then
      link '/lib/libpam.so.0' do
        to '/lib/i386-linux-gnu/libpam.so.0'
        only_if { File.exists?("/lib/i386-linux-gnu/libpam.so.0") }
      end
    end
  end
end

directory "#{workdir}" do
  action :create
end

template "#{workdir}/db2expc.rsp" do
  owner 'root'
  group 'root'
  mode  '0644'
end

execute 'extract' do
  action :nothing
  command "tar zxf #{workdir}/#{installer} -C #{workdir}"
end

execute 'extract-nlpack' do
  action :nothing
  command "tar zxf #{workdir}/#{nlpack} -C #{workdir}/expc"
  only_if { File.exists?("#{workdir}/#{nlpack}") }
end

execute 'install' do
  action :nothing
  command "#{workdir}/expc/db2setup -r #{workdir}/db2expc.rsp -l #{node['db2']['installer_log']}"
end

if node['db2']['nlpack_url']
  remote_file File.join(workdir, nlpack) do
    source node['db2']['nlpack_url']
    owner 'root'
    group 'root'
    mode  '0755'
  end
end

remote_file File.join(workdir, installer) do
  source node['db2']['installer_url']
  owner 'root'
  group 'root'
  mode  '0755'
  not_if "test -e #{workdir}/#{installer}"
  notifies :run, "execute[extract]", :immediately
  notifies :run, "execute[extract-nlpack]", :immediately
  notifies :run, "execute[install]", :immediately
end

directory "#{workdir}" do
  recursive true
  action :delete
end
