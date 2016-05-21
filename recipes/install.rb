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
  Chef::Application.fatal!("The installer url attribute is required.")
end

include_recipe 'selinux::permissive'

installer_file = node['db2']['installer_file']
work_dir       = node['db2']['working_dir']
response_file  = "#{work_dir}/db2expc.rsp"

package [ "libstdc++", "libaio", "pam", "cpp", "gcc", "gcc-c++", "kernel-devel", "sg3_utils", "ksh" ] do
  action :install
end

directory "#{work_dir}" do
  action :create
end

template "#{response_file}" do
  owner 'root'
  group 'root'
  mode "0644"
end

execute 'install' do
  action :nothing
  command <<-EOH
    tar zxvf #{work_dir}/#{installer_file} -C #{work_dir}
    #{work_dir}/expc/db2setup -r #{response_file} -l #{node['db2']['installer_log']}
  EOH
end

remote_file File.join(work_dir, installer_file) do
  source node['db2']['installer_url']
  owner 'root'
  group 'root'
  mode '0755'
  not_if "test -e #{work_dir}/#{installer_file}"
  notifies :run, "execute[install]", :immediately
end

directory "#{work_dir}" do
  recursive true
  action :delete
end
