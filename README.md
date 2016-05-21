# DB2 Express-C cookbook

Requirements
------------
Chef 12+

#### platforms
- Red Hat Enterprise Linux 6 / 7

Attributes
----------

#### required attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['db2']['installer_url']</tt></td>
    <td>String</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

#### installer
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['db2']['version']</tt></td>
    <td>String</td>
    <td><tt>10.5</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['installer_log']</tt></td>
    <td>String</td>
    <td><tt>/tmp/db2setup.log</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['language']</tt></td>
    <td>String</td>
    <td><tt>EN</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['install_type']</tt></td>
    <td>String</td>
    <td><tt>CUSTOM</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['sample_database']</tt></td>
    <td>Boolean</td>
    <td><tt>true</tt></td>
  </tr>
</table>

#### instance
<table>
  <tr>
    <td><tt>['db2']['instance']['prefix']</tt></td>
    <td>String</td>
    <td><tt>DB2_INST</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['name']</tt></td>
    <td>String</td>
    <td><tt>db2inst1</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['uid']</tt></td>
    <td>String</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['group']</tt></td>
    <td>String</td>
    <td><tt>db2iadm1</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['gid']</tt></td>
    <td>String</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['home']</tt></td>
    <td>String</td>
    <td><tt>'/home/' + ['db2']['instance']['name']</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['password']</tt></td>
    <td>String</td>
    <td><tt>db2inst1</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['port']</tt></td>
    <td>Integer</td>
    <td><tt>50000</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['fenced_name']</tt></td>
    <td>String</td>
    <td><tt>db2fenc1</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['fenced_uid']</tt></td>
    <td>String</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['fenced_group']</tt></td>
    <td>String</td>
    <td><tt>db2fsdm1</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['fenced_gid']</tt></td>
    <td>String</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['fenced_home']</tt></td>
    <td>String</td>
    <td><tt>'/home/' + ['db2']['instance']['fenced_name']</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['instance']['fenced_password']</tt></td>
    <td>String</td>
    <td><tt>db2fenc1</tt></td>
  </tr>
</table>

#### DB2 Administration Server(DAS) user
<table>
  <tr>
    <td><tt>['db2']['das_name']</tt></td>
    <td>String</td>
    <td><tt>dasusr1</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['das_uid']</tt></td>
    <td>String</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['das_group']</tt></td>
    <td>String</td>
    <td><tt>dasadm1</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['das_gid']</tt></td>
    <td>String</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['das_home']</tt></td>
    <td>String</td>
    <td><tt>'/home/' + ['db2']['das_name']</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['das_password']</tt></td>
    <td>String</td>
    <td><tt>dasusr1</tt></td>
  </tr>
</table>

#### first database
if you want to create a database, you'll need to set the 'name' attribute.
<table>
  <tr>
    <td><tt>['db2']['database']['name']</tt></td>
    <td>String</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['database']['codeset']</tt></td>
    <td>String</td>
    <td><tt>UTF-8</tt></td>
  </tr>
  <tr>
    <td><tt>['db2']['database']['territory']</tt></td>
    <td>String</td>
    <td><tt>JP</tt></td>
  </tr>
</table>

Usage
------------

#### Berksfile
    source "https://api.berkshelf.com/"
    
    cookbook "db2"  , github: "kayu28/chef-db2"
