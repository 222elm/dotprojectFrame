<?php /* ADMIN $Id: vw_active_usr.php 5934 2009-12-29 05:52:11Z merlinyoda $ */
if (!defined('DP_BASE_DIR')) {
    die('You should not access this file directly.');
}

GLOBAL $dPconfig, $canEdit, $stub, $where, $orderby;

$q = new DBQuery;
$q->addTable('users', 'u');
$q->addQuery('DISTINCT(user_id), user_username, contact_last_name, contact_first_name,
    permission_user, contact_email, contact_company');
$q->addJoin('contacts', 'con', 'user_contact = contact_id');
$q->addJoin('permissions', 'per', 'user_id = permission_user');

if ($stub) {
    $q->addWhere("(UPPER(user_username) LIKE '$stub%'" 
                 . " OR UPPER(contact_first_name) LIKE '$stub%'" 
                 . " OR UPPER(contact_last_name) LIKE '$stub%')");
} else if ($where) {
    $where = $q->quote("%$where%");
    $q->addWhere("(UPPER(user_username) LIKE $where" 
                 . " OR UPPER(contact_first_name) LIKE $where" 
                 . " OR UPPER(contact_last_name) LIKE $where)");
}

$q->addOrder($orderby);
$users = $q->loadList();
$canLogin = true;

require DP_BASE_DIR . '/modules/admin/vw_usr.php';
?>
