#
# dotproject.sql Database Schema
#
# Use this schema for creating your database for
# a new installation of dotProject.
#
# Changed: Add in a dbprefix string to be replaced with the actual db table prefix
# Changed: Remove explicit mySQL table type which then allows for being able to use other
#            database engines

CREATE TABLE `%dbprefix%contacts` (
  `contact_id` int(11) NOT NULL auto_increment,
  `contact_first_name` varchar(30) default NULL,
  `contact_last_name` varchar(30) default NULL,
  `contact_order_by` varchar(30) NOT NULL default '',
  `contact_title` varchar(50) default NULL,
  `contact_birthday` date default NULL,
  `contact_job` varchar(255) default NULL,
  `contact_company` varchar(100) NOT NULL default '',
  `contact_department` varchar(100) NOT NULL default '',
  `contact_type` varchar(20) default NULL,
  `contact_email` varchar(255) default NULL,
  `contact_email2` varchar(255) default NULL,
  `contact_url` varchar(255) default NULL,
  `contact_phone` varchar(30) default NULL,
  `contact_phone2` varchar(30) default NULL,
  `contact_fax` varchar(30) default NULL,
  `contact_mobile` varchar(30) default NULL,
  `contact_address1` varchar(60) default NULL,
  `contact_address2` varchar(60) default NULL,
  `contact_city` varchar(30) default NULL,
  `contact_state` varchar(30) default NULL,
  `contact_zip` varchar(11) default NULL,
  `contact_country` varchar(30) default NULL,
  `contact_notes` text,
  `contact_icon` varchar(20) default 'obj/contact',
  `contact_owner` int unsigned default '0',
  `contact_private` tinyint unsigned default '0',
  PRIMARY KEY  (`contact_id`),
  KEY `idx_oby` (`contact_order_by`),
  KEY `idx_co` (`contact_company`)
) ;

CREATE TABLE `%dbprefix%permissions` (
  `permission_id` int(11) NOT NULL auto_increment,
  `permission_user` int(11) NOT NULL default '0',
  `permission_grant_on` varchar(12) NOT NULL default '',
  `permission_item` int(11) NOT NULL default '0',
  `permission_value` int(11) NOT NULL default '0',
  PRIMARY KEY  (`permission_id`),
  UNIQUE KEY `idx_pgrant_on` (`permission_grant_on`,`permission_item`,`permission_user`),
  KEY `idx_puser` (`permission_user`),
  KEY `idx_pvalue` (`permission_value`)
) ;

CREATE TABLE `%dbprefix%users` (
  `user_id` int(11) NOT NULL auto_increment,
  `user_contact` int(11) NOT NULL default '0',
  `user_username` varchar(255) NOT NULL default '',
  `user_password` varchar(32) NOT NULL default '',
  `user_parent` int(11) NOT NULL default '0',
  `user_type` tinyint(3) not null default '0',
  `user_company` varchar(100) default '',
  `user_department` varchar(100) default '',
  `user_owner` int(11) NOT NULL default '0',
  `user_signature` TEXT,
  PRIMARY KEY  (`user_id`),
  KEY `idx_uid` (`user_username`),
  KEY `idx_pwd` (`user_password`),
  KEY `idx_user_parent` (`user_parent`)
) ;

CREATE TABLE `%dbprefix%user_preferences` (
  `pref_user` varchar(12) NOT NULL default '',
  `pref_name` varchar(72) NOT NULL default '',
  `pref_value` varchar(32) NOT NULL default '',
  KEY `pref_user` (`pref_user`,`pref_name`)
) ;

#
# ATTENTION:
# Customize this section for your installation.
# Recommended changes include:
#   New admin username -> replace {admin}
#   New admin password -> replace {passwd]
#   New admin email -> replace {admin@example.com}
#

INSERT INTO `%dbprefix%users` VALUES (1,1,'admin',MD5('passwd'),0,1,0,0,0,'');
INSERT INTO `%dbprefix%contacts` (contact_id, contact_first_name, contact_last_name, contact_email) 
  VALUES (1,'Admin','Person','admin@example.com');

INSERT INTO `%dbprefix%permissions` VALUES (1,1,'all',-1, -1);

INSERT INTO `%dbprefix%user_preferences` VALUES('0', 'LOCALE', 'en');
INSERT INTO `%dbprefix%user_preferences` VALUES('0', 'TABVIEW', '0');
INSERT INTO `%dbprefix%user_preferences` VALUES('0', 'SHDATEFORMAT', '%Y/%m/%d');
INSERT INTO `%dbprefix%user_preferences` VALUES('0', 'TIMEFORMAT', '%I:%M %p');
INSERT INTO `%dbprefix%user_preferences` VALUES('0', 'UISTYLE', 'default');
INSERT INTO `%dbprefix%user_preferences` VALUES('0', 'TASKASSIGNMAX', '100');
INSERT INTO `%dbprefix%user_preferences` VALUES('0', 'USERFORMAT', 'user');
INSERT INTO `%dbprefix%user_preferences` VALUES('0', 'USEDIGESTS', '0');

#
# Table structure for table 'modules'
#
CREATE TABLE `%dbprefix%modules` (
  `mod_id` int(11) NOT NULL auto_increment,
  `mod_name` varchar(64) NOT NULL default '',
  `mod_directory` varchar(64) NOT NULL default '',
  `mod_version` varchar(10) NOT NULL default '',
  `mod_setup_class` varchar(64) NOT NULL default '',
  `mod_type` varchar(64) NOT NULL default '',
  `mod_active` int(1) unsigned NOT NULL default '0',
  `mod_ui_name` varchar(20) NOT NULL default '',
  `mod_ui_icon` varchar(64) NOT NULL default '',
  `mod_ui_order` tinyint(3) NOT NULL default '0',
  `mod_ui_active` int(1) unsigned NOT NULL default '0',
  `mod_description` varchar(255) NOT NULL default '',
  `permissions_item_table` CHAR( 100 ),
  `permissions_item_field` CHAR( 100 ),
  `permissions_item_label` CHAR( 100 ),
  PRIMARY KEY  (`mod_id`,`mod_directory`)
);

#
# Dumping data for table 'modules'
#
INSERT INTO `%dbprefix%modules` VALUES("6", "Contacts", "contacts", "1.0.0", "", "core", "1", "Contacts", "monkeychat-48.png", "6", "1", "", "contacts", "contact_id", "contact_title");
INSERT INTO `%dbprefix%modules` VALUES("9", "User Administration", "admin", "1.0.0", "", "core", "1", "User Admin", "helix-setup-users.png", "9", "1", "", "users", "user_id", "user_username");
INSERT INTO `%dbprefix%modules` VALUES("10", "System Administration", "system", "1.0.0", "", "core", "1", "System Admin", "48_my_computer.png", "10", "1", "", "", "", "");
INSERT INTO `%dbprefix%modules` VALUES("12", "Help", "help", "1.0.0", "", "core", "1", "Help", "dp.gif", "12", "0", "", "", "", "");
INSERT INTO `%dbprefix%modules` VALUES("13", "Public", "public", "1.0.0", "", "core", "1", "Public", "users.gif", "13", "0", "", "", "", "");

#
# Table structure for table 'syskeys'
#

CREATE TABLE `%dbprefix%syskeys` (
  `syskey_id` int(10) unsigned NOT NULL auto_increment,
  `syskey_name` varchar(48) NOT NULL default '' unique,
  `syskey_label` varchar(255) NOT NULL default '',
  `syskey_type` int(1) unsigned NOT NULL default '0',
  `syskey_sep1` char(2) default '\n',
  `syskey_sep2` char(2) NOT NULL default '|',
  PRIMARY KEY  (`syskey_id`),
  UNIQUE KEY `idx_syskey_name` (`syskey_name`)
);

#
# Table structure for table 'sysvals'
#

CREATE TABLE `%dbprefix%sysvals` (
  `sysval_id` int(10) unsigned NOT NULL auto_increment,
  `sysval_key_id` int(10) unsigned NOT NULL default '0',
  `sysval_title` varchar(48) NOT NULL default '',
  `sysval_value` text NOT NULL,
  PRIMARY KEY  (`sysval_id`),
  UNIQUE KEY `idx_sysval_title` (`sysval_title`)
);

#
# Table structure for table 'sysvals'
#

INSERT INTO `%dbprefix%syskeys` VALUES (1, "SelectList", "Enter values for list", "0", "\n", "|");
INSERT INTO `%dbprefix%syskeys` VALUES (2, 'CustomField', 'Serialized array in the following format:\r\n<KEY>|<SERIALIZED ARRAY>\r\n\r\nSerialized Array:\r\n[type] => text | checkbox | select | textarea | label\r\n[name] => <Field\'s name>\r\n[options] => <html capture options>\r\n[selects] => <options for select and checkbox>', 0, '\n', '|');
INSERT INTO `%dbprefix%syskeys` VALUES (3, "ColorSelection", "Hex color values for type=>color association.", "0", "\n", "|");

INSERT INTO `%dbprefix%sysvals` (`sysval_key_id`,`sysval_title`,`sysval_value`) VALUES (1, "CompanyType", "0|Not Applicable\n1|Client\n2|Vendor\n3|Supplier\n4|Consultant\n5|Government\n6|Internal");
INSERT INTO `%dbprefix%sysvals` ( `sysval_id` , `sysval_key_id` , `sysval_title` , `sysval_value` ) VALUES (null, 1, 'UserType', '0|Default User\r\n1|Administrator\r\n2|CEO\r\n3|Director\r\n4|Branch Manager\r\n5|Manager\r\n6|Supervisor\r\n7|Employee');

#
# Table structure for table 'roles'
#

CREATE TABLE `%dbprefix%roles` (
  `role_id` int(10) unsigned NOT NULL auto_increment,
  `role_name` varchar(24) NOT NULL default '',
  `role_description` varchar(255) NOT NULL default '',
  `role_type` int(3) unsigned NOT NULL default '0',
  `role_module` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`role_id`)
);

#
# Table structure for table 'user_roles'
#

CREATE TABLE `%dbprefix%user_roles` (
  `user_id` int(10) unsigned NOT NULL default '0',
  `role_id` int(10) unsigned NOT NULL default '0'
);


#20040823
#Added user access log
CREATE TABLE `%dbprefix%user_access_log` (
  `user_access_log_id` INT( 10 ) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `user_id` INT( 10 ) UNSIGNED NOT NULL ,
  `user_ip` VARCHAR( 15 ) NOT NULL ,
  `date_time_in` DATETIME DEFAULT '0000-00-00 00:00:00',
  `date_time_out` DATETIME DEFAULT '0000-00-00 00:00:00',
  `date_time_last_action` DATETIME DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY ( `user_access_log_id` )
);

#
# Table structure for TABLE `config`
#
# Creation: Feb 23, 2005 at 01:26 PM
# Last update: Feb 24, 2005 at 02:15 AM
#

CREATE TABLE `%dbprefix%config` (
  `config_id` int(11) NOT NULL auto_increment,
  `config_name` varchar(255) NOT NULL default '',
  `config_value` varchar(255) NOT NULL default '',
  `config_group` varchar(255) NOT NULL default '',
  `config_type` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`config_id`),
  UNIQUE KEY `config_name` (`config_name`)
);

#
# Dumping data for table `config`
#

INSERT INTO `%dbprefix%config` VALUES (0, 'host_locale', 'en', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'check_overallocation', 'false', 'tasks', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'currency_symbol', '$', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'host_style', 'default', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'company_name', 'My Company', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'page_title', 'dotprojectFrame', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'site_domain', 'example.com', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'email_prefix', '[dotprojectFrame]', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'admin_username', 'admin', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'username_min_len', '4', 'auth', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'password_min_len', '4', 'auth', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'log_changes', 'false', '', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'locale_warn', 'false', 'ui', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'locale_alert', '^', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'display_debug', 'false', 'ui', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'direct_edit_assignment', 'false', 'tasks', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'restrict_color_selection', 'false', 'ui', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'default_view_m', 'contacts', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'default_view_tab', '1', 'ui', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'index_max_file_size', '-1', 'file', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'session_handling', 'app', 'session', 'select');
INSERT INTO `%dbprefix%config` VALUES (0, 'session_idle_time', '2d', 'session', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'session_max_lifetime', '1m', 'session', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'debug', '1', '', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'parser_default', '/usr/bin/strings', 'file', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'parser_application/msword', '/usr/bin/strings', 'file', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'parser_text/html', '/usr/bin/strings', 'file', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'parser_application/pdf', '/usr/bin/pdftotext', 'file', 'text');

# 20050302
# ldap system config variables
INSERT INTO `%dbprefix%config` VALUES (0, 'auth_method', 'sql', 'auth', 'select'); 
INSERT INTO `%dbprefix%config` VALUES (0, 'ldap_host', 'localhost', 'ldap', 'text'); 
INSERT INTO `%dbprefix%config` VALUES (0, 'ldap_port', '389', 'ldap', 'text'); 
INSERT INTO `%dbprefix%config` VALUES (0, 'ldap_version', '3', 'ldap', 'text'); 
INSERT INTO `%dbprefix%config` VALUES (0, 'ldap_base_dn', 'dc=saki,dc=com,dc=au', 'ldap', 'text'); 
INSERT INTO `%dbprefix%config` VALUES (0, 'ldap_user_filter', '(uid=%USERNAME%)', 'ldap', 'text'); 

# 20050302
# PostNuke authentication variables
INSERT INTO `%dbprefix%config` VALUES (0, 'postnuke_allow_login', 'true', 'auth', 'checkbox');

# 20050302
# New list support for config variables
CREATE TABLE `%dbprefix%config_list` (
  `config_list_id` integer not null auto_increment,
  `config_id` integer not null default 0,
  `config_list_name` varchar(30) not null default '',
  PRIMARY KEY(`config_list_id`),
  KEY(`config_id`)
);

INSERT INTO %dbprefix%config_list (`config_id`, `config_list_name`)
  SELECT config_id, 'sql'
    FROM %dbprefix%config
    WHERE config_name = 'auth_method';

INSERT INTO %dbprefix%config_list (`config_id`, `config_list_name`)
  SELECT config_id, 'ldap'
    FROM %dbprefix%config
    WHERE config_name = 'auth_method';

INSERT INTO %dbprefix%config_list (`config_id`, `config_list_name`)
  SELECT config_id, 'pn'
    FROM %dbprefix%config
    WHERE config_name = 'auth_method';

INSERT INTO %dbprefix%config_list (`config_id`, `config_list_name`)
  SELECT config_id, 'app'
    FROM %dbprefix%config
    WHERE config_name = 'session_handling';

INSERT INTO %dbprefix%config_list (`config_id`, `config_list_name`)
  SELECT config_id, 'php'
    FROM %dbprefix%config
    WHERE config_name = 'session_handling';

# 20050405 - temporarily reset the memory limit for gantt charts
INSERT INTO `%dbprefix%config` VALUES (0, 'reset_memory_limit', '32M', 'tasks', 'text');

# 20050303
# New mail handling options
INSERT INTO `%dbprefix%config` VALUES (0, 'mail_transport', 'php', 'mail', 'select');
INSERT INTO `%dbprefix%config` VALUES (0, 'mail_host', 'localhost', 'mail', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'mail_port', '25', 'mail', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'mail_auth', 'false', 'mail', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'mail_user', '', 'mail', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'mail_pass', '', 'mail', 'password');
INSERT INTO `%dbprefix%config` VALUES (0, 'mail_defer', 'false', 'mail', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'mail_timeout', '30', 'mail', 'text');

INSERT INTO %dbprefix%config_list (`config_id`, `config_list_name`)
  SELECT config_id, 'php'
    FROM %dbprefix%config
    WHERE config_name = 'mail_transport';

INSERT INTO %dbprefix%config_list (`config_id`, `config_list_name`)
  SELECT config_id, 'smtp'
    FROM %dbprefix%config
    WHERE config_name = 'mail_transport';

# 20050303
# Queue scanning on garbage collection
INSERT INTO %dbprefix%config VALUES (NULL, 'session_gc_scan_queue', 'false', 'session', 'checkbox');

# 20060321
# Backport of task reminders.
INSERT INTO `%dbprefix%config` VALUES (0, 'task_reminder_control', 'false', 'task_reminder', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'task_reminder_days_before', '1', 'task_reminder', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'task_reminder_repeat', '100', 'task_reminder', 'text');

# 20080702
# GACL Caching options
INSERT INTO %dbprefix%config VALUES 
(NULL, 'gacl_cache', 'false', 'gacl', 'checkbox'),
(NULL, 'gacl_expire', 'true', 'gacl', 'checkbox'),
(NULL, 'gacl_cache_dir', '/tmp', 'gacl', 'text'),
(NULL, 'gacl_timeout', '600', 'gacl', 'text');

# 20090427
# adding config value to toggle use of TLS in SMTP connections
INSERT INTO `%dbprefix%config` (`config_id`, `config_name`, `config_value`, `config_group`, `config_type`)
VALUES (0, 'mail_smtp_tls', 'false', 'mail', 'checkbox');

# 20050302
# new custom fields
CREATE TABLE `%dbprefix%custom_fields_struct` (
  field_id integer primary key,
  field_module varchar(30),
  field_page varchar(30),
  field_htmltype varchar(20),
  field_datatype varchar(20),
  field_order integer,
  field_name varchar(100),
  field_extratags varchar(250),
  field_description varchar(250)
);

CREATE TABLE `%dbprefix%custom_fields_values` (
  value_id integer,
  value_module varchar(30),
  value_object_id integer,
  value_field_id integer,
  value_charvalue varchar(250),
  value_intvalue integer,
  KEY `idx_cfv_id` (`value_id`)
);

CREATE TABLE `%dbprefix%custom_fields_lists` (
  field_id integer,
  list_option_id integer,
  list_value varchar(250)
);


#20040920
# ACL support.
#
# Table structure for table `gacl_acl`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 28, 2004 at 02:15 PM
# Last check: Jul 22, 2004 at 01:00 PM
#

CREATE TABLE `%dbprefix%gacl_acl` (
  `id` int(11) NOT NULL default '0',
  `section_value` varchar(80) NOT NULL default 'system',
  `allow` int(11) NOT NULL default '0',
  `enabled` int(11) NOT NULL default '0',
  `return_value` longtext,
  `note` longtext,
  `updated_date` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `gacl_enabled_acl` (`enabled`),
  KEY `gacl_section_value_acl` (`section_value`),
  KEY `gacl_updated_date_acl` (`updated_date`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_acl_sections`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 22, 2004 at 01:04 PM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_acl_sections`;
CREATE TABLE `%dbprefix%gacl_acl_sections` (
  `id` int(11) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(230) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `gacl_value_acl_sections` (`value`),
  KEY `gacl_hidden_acl_sections` (`hidden`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_aco`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 28, 2004 at 11:23 AM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_aco`;
CREATE TABLE `%dbprefix%gacl_aco` (
  `id` int(11) NOT NULL default '0',
  `section_value` varchar(80) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `gacl_section_value_value_aco` (`section_value`,`value`),
  KEY `gacl_hidden_aco` (`hidden`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_aco_map`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 28, 2004 at 02:15 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_aco_map`;
CREATE TABLE `%dbprefix%gacl_aco_map` (
  `acl_id` int(11) NOT NULL default '0',
  `section_value` varchar(80) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`acl_id`,`section_value`,`value`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_aco_sections`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 23, 2004 at 08:14 AM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_aco_sections`;
CREATE TABLE `%dbprefix%gacl_aco_sections` (
  `id` int(11) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(230) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `gacl_value_aco_sections` (`value`),
  KEY `gacl_hidden_aco_sections` (`hidden`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_aro`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 29, 2004 at 11:38 AM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_aro`;
CREATE TABLE `%dbprefix%gacl_aro` (
  `id` int(11) NOT NULL default '0',
  `section_value` varchar(80) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `gacl_section_value_value_aro` (`section_value`,`value`),
  KEY `gacl_hidden_aro` (`hidden`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_aro_groups`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 28, 2004 at 12:12 PM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_aro_groups`;
CREATE TABLE `%dbprefix%gacl_aro_groups` (
  `id` int(11) NOT NULL default '0',
  `parent_id` int(11) NOT NULL default '0',
  `lft` int(11) NOT NULL default '0',
  `rgt` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `value` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`id`,`value`),
  KEY `gacl_parent_id_aro_groups` (`parent_id`),
  KEY `gacl_value_aro_groups` (`value`),
  KEY `gacl_lft_rgt_aro_groups` (`lft`,`rgt`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_aro_groups_map`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 28, 2004 at 12:26 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_aro_groups_map`;
CREATE TABLE `%dbprefix%gacl_aro_groups_map` (
  `acl_id` int(11) NOT NULL default '0',
  `group_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`acl_id`,`group_id`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_aro_map`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 29, 2004 at 11:33 AM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_aro_map`;
CREATE TABLE `%dbprefix%gacl_aro_map` (
  `acl_id` int(11) NOT NULL default '0',
  `section_value` varchar(80) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`acl_id`,`section_value`,`value`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_aro_sections`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 22, 2004 at 03:04 PM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_aro_sections`;
CREATE TABLE `%dbprefix%gacl_aro_sections` (
  `id` int(11) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(230) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `gacl_value_aro_sections` (`value`),
  KEY `gacl_hidden_aro_sections` (`hidden`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_axo`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 26, 2004 at 06:23 PM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_axo`;
CREATE TABLE `%dbprefix%gacl_axo` (
  `id` int(11) NOT NULL default '0',
  `section_value` varchar(80) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `gacl_section_value_value_axo` (`section_value`,`value`),
  KEY `gacl_hidden_axo` (`hidden`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_axo_groups`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 26, 2004 at 11:00 AM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_axo_groups`;
CREATE TABLE `%dbprefix%gacl_axo_groups` (
  `id` int(11) NOT NULL default '0',
  `parent_id` int(11) NOT NULL default '0',
  `lft` int(11) NOT NULL default '0',
  `rgt` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `value` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`id`,`value`),
  KEY `gacl_parent_id_axo_groups` (`parent_id`),
  KEY `gacl_value_axo_groups` (`value`),
  KEY `gacl_lft_rgt_axo_groups` (`lft`,`rgt`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_axo_groups_map`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 28, 2004 at 11:24 AM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_axo_groups_map`;
CREATE TABLE `%dbprefix%gacl_axo_groups_map` (
  `acl_id` int(11) NOT NULL default '0',
  `group_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`acl_id`,`group_id`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_axo_map`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 28, 2004 at 02:15 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_axo_map`;
CREATE TABLE `%dbprefix%gacl_axo_map` (
  `acl_id` int(11) NOT NULL default '0',
  `section_value` varchar(80) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`acl_id`,`section_value`,`value`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_axo_sections`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 23, 2004 at 03:50 PM
# Last check: Jul 22, 2004 at 01:00 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_axo_sections`;
CREATE TABLE `%dbprefix%gacl_axo_sections` (
  `id` int(11) NOT NULL default '0',
  `value` varchar(80) NOT NULL default '',
  `order_value` int(11) NOT NULL default '0',
  `name` varchar(230) NOT NULL default '',
  `hidden` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `gacl_value_axo_sections` (`value`),
  KEY `gacl_hidden_axo_sections` (`hidden`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_groups_aro_map`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 29, 2004 at 11:38 AM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_groups_aro_map`;
CREATE TABLE `%dbprefix%gacl_groups_aro_map` (
  `group_id` int(11) NOT NULL default '0',
  `aro_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`group_id`,`aro_id`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_groups_axo_map`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 26, 2004 at 11:01 AM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_groups_axo_map`;
CREATE TABLE `%dbprefix%gacl_groups_axo_map` (
  `group_id` int(11) NOT NULL default '0',
  `axo_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`group_id`,`axo_id`)
) ;
# --------------------------------------------------------

#
# Table structure for table `gacl_phpgacl`
#
# Creation: Jul 22, 2004 at 01:00 PM
# Last update: Jul 22, 2004 at 01:03 PM
#

DROP TABLE IF EXISTS `%dbprefix%gacl_phpgacl`;
CREATE TABLE `%dbprefix%gacl_phpgacl` (
  `name` varchar(230) NOT NULL default '',
  `value` varchar(230) NOT NULL default '',
  PRIMARY KEY  (`name`)
) ;

DROP TABLE IF EXISTS `%dbprefix%billingcode`;
CREATE TABLE `%dbprefix%billingcode` (
  `billingcode_id` bigint(20) NOT NULL auto_increment,
  `billingcode_name` varchar(25) NOT NULL default '',
  `billingcode_value` float NOT NULL default '0',
  `billingcode_desc` varchar(255) NOT NULL default '',
  `billingcode_status` int(1) NOT NULL default '0',
  `company_id` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`billingcode_id`)
) ;

INSERT INTO `%dbprefix%gacl_phpgacl` (name, value) VALUES ('version', '3.3.2');
INSERT INTO `%dbprefix%gacl_phpgacl` (name, value) VALUES ('schema_version', '2.1');

INSERT INTO `%dbprefix%gacl_acl_sections` (id, value, order_value, name) VALUES (1, 'system', 1, 'System');
INSERT INTO `%dbprefix%gacl_acl_sections` (id, value, order_value, name) VALUES (2, 'user', 2, 'User');


#
# Table structure for table `sessions`
#

DROP TABLE IF EXISTS `%dbprefix%sessions`;
CREATE TABLE `%dbprefix%sessions` (
  `session_id` varchar(60) NOT NULL default '',
  `session_user` INT DEFAULT '0' NOT NULL,
  `session_data` LONGBLOB,
  `session_updated` TIMESTAMP,
  `session_created` DATETIME NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`session_id`),
  KEY (`session_updated`),
  KEY (`session_created`)
);

# 20050304
# Version tracking table.  From here on in all updates are done via the installer,
# which uses this table to manage the upgrade process.
CREATE TABLE %dbprefix%dpversion (
  code_version varchar(10) not null default '',
  db_version integer not null default '0',
  last_db_update date not null default '0000-00-00',
  last_code_update date not null default '0000-00-00'
);

INSERT INTO %dbprefix%dpversion VALUES ('2.1.8', 2, '2013-01-05', '2013-07-27');

# 20050307
# Additional LDAP search user and search password fields for Active Directory compatible LDAP authentication
INSERT INTO `%dbprefix%config` VALUES (0, 'ldap_search_user', 'Manager', 'ldap', 'text');
INSERT INTO `%dbprefix%config` VALUES (0, 'ldap_search_pass', 'secret', 'ldap', 'password');
INSERT INTO `%dbprefix%config` VALUES (0, 'ldap_allow_login', 'true', 'ldap', 'checkbox');


DROP TABLE IF EXISTS `%dbprefix%dotpermissions`;
CREATE TABLE `%dbprefix%dotpermissions` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `user_id` varchar(80) NOT NULL DEFAULT '',
  `section` varchar(80) NOT NULL DEFAULT '',
  `axo` varchar(80) NOT NULL DEFAULT '',
  `permission` varchar(80) NOT NULL DEFAULT '',
  `allow` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `enabled` int(11) NOT NULL DEFAULT '0',
  KEY `user_id` (`user_id`,`section`,`permission`,`axo`)
);

# 20101216
# Manage contacts properly
INSERT INTO `%dbprefix%config` VALUES (0, 'user_contact_inactivate', 'true', 'auth', 'checkbox');
INSERT INTO `%dbprefix%config` VALUES (0, 'user_contact_activate', 'false', 'auth', 'checkbox');

