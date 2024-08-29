create user 'sync_admin'@'%' identified with 'mysql_native_password' by '123456';
grant replication slave,replication client on *.* to 'sync_admin'@'%';
flush privileges;
