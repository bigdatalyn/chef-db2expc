#
# Cookbook Name:: db2
# Attributes:: default
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

# default attributes
default['db2']['working_dir']                 = ::File.join(Chef::Config[:file_cache_path], 'db2')
default['db2']['version']                     = '10.5'
default['db2']['installer_url']               = nil
default['db2']['installer_file']              = 'v' + node['db2']['version'] + '_linuxx64_expc.tar.gz'
default['db2']['installer_log']               = '/tmp/db2setup.log'
default['db2']['db2_home']                    = '/opt/ibm/db2/V' + node['db2']['version']
default['db2']['language']                    = nil
default['db2']['install_type']                = 'CUSTOM'
default['db2']['sample_database']             = 'false'

default['db2']['instance']['prefix']          = 'DB2_INST'
default['db2']['instance']['name']            = 'db2inst1'
default['db2']['instance']['uid']             = nil
default['db2']['instance']['group']           = 'db2iadm1'
default['db2']['instance']['gid']             = nil
default['db2']['instance']['home']            = '/home/' + node['db2']['instance']['name']
default['db2']['instance']['password']        = 'db2inst1'
default['db2']['instance']['port']            = 50000

default['db2']['instance']['fenced_name']     = 'db2fenc1'
default['db2']['instance']['fenced_uid']      = nil
default['db2']['instance']['fenced_group']    = 'db2fsdm1'
default['db2']['instance']['fenced_gid']      = nil
default['db2']['instance']['fenced_home']     = '/home/' + node['db2']['instance']['fenced_name']
default['db2']['instance']['fenced_password'] = 'db2fenc1'

default['db2']['das_name']                    = 'dasusr1'
default['db2']['das_uid']                     = nil
default['db2']['das_group']                   = 'dasadm1'
default['db2']['das_gid']                     = nil
default['db2']['das_home']                    = '/home/' + node['db2']['das_name']
default['db2']['das_password']                = 'dasusr1'

default['db2']['database']['name']            = nil
default['db2']['database']['codeset']         = 'UTF-8'
default['db2']['database']['territory']       = 'JP'
