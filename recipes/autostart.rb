#
# Cookbook Name:: db2
# Recipe:: autostart
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

case node['platform']
when 'redhat'
  if node['platform_version'].to_i == 7 then
    template "/etc/systemd/system/db2fmcd.service" do
      owner 'root'
      group 'root'
      mode "0644"
    end
    execute 'start-db2fmcd' do
      command <<-EOH
        systemctl enable db2fmcd
        systemctl start db2fmcd
      EOH
    end
  end
end
