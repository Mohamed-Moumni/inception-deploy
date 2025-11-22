#!/bin/bash


# change the bind to 0.0.0.0 only accept client connections made to 0.0.0.0 (accept connection to any address)
sed -i 's/bind-address            = 127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
# Start MySQL in the background
mysqld_safe &

# Wait for MySQL to initialize
sleep 5


# create the database if not exist
mysql -u root -p$MYSQL_ROOTPASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

# create the user if not exist
mysql -u root -p$MYSQL_ROOTPASSWORD -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

# grant all priviliges on the created database to the user
mysql -u root -p$MYSQL_ROOTPASSWORD -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"

# this command tell the MySQL or MariaDB server to reload the grant tables and update its internal data structures with the current contents of the grant tables.
mysql -u root -p$MYSQL_ROOTPASSWORD -e "FLUSH PRIVILEGES;"

# set the password to the root
mysql -u root -p$MYSQL_ROOTPASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOTPASSWORD';"

wait $!