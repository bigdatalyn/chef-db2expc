#
# Cookbook Name:: db2
# Recipe:: createdb
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

instance = node['db2']['instance']
db = node['db2']['database']

execute 'db2sampl' do
  only_if { node['db2']['sample_database'] == 'true' }
  command <<-EOH
    su - #{instance['name']} -l -c 'db2sampl'
  EOH
end

execute 'createdb' do
  only_if { not db['name'].nil? }
  command <<-EOH
    su - #{instance['name']} -l -c 'db2 create db #{db['name']} using codeset #{db['codeset']} territory #{db['territory']}'
  EOH
end
