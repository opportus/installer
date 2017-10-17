#!/bin/bash

# Exits the script if an error occurs...
set -e

# Project installation...
echo ""
echo "Running the project installation..."
echo ""
echo "Enter the ABSOLUTE PATH of your project directory (will be created if it doesn't exist...):"
read project_dir
echo ""
echo "Enter the URL of the Git repository to clone (https://github.com/user/project.git):"
read repo_url
echo ""
echo "Installing your project in ${project_dir}..."
git clone ${repo_url} ${project_dir}
echo "Installing your project dependencies..."
cd ${project_dir}
composer install
echo ""

# MySQL environment setup...
echo "Running MySQL environment setup for your project..."
echo ""
echo "Enter your MySQL root user NAME (\"root\" by default...):"
read mysql_root_name
echo ""
echo "Enter your MySQL root user PASSWORD:"
read -s mysql_root_password
echo ""
echo "Enter your new database NAME:"
read db_name
echo ""
echo "Enter your new database HOST (\"localhost\" by default):"
read db_host
echo ""
echo "Enter your new database CHARACTER SET (\"utf8\" by default):"
read db_charset
echo ""
echo "Enter your new database COLLATION (\"utf8_general_ci\" by default):"
read db_collate
echo ""
echo "Creating your new database..."
mysql -u ${mysql_root_name} -p${mysql_root_password} -e "CREATE DATABASE ${db_name} CHARACTER SET = '${db_charset}' COLLATE = '${db_collate}';"
echo "Database successfully created..."
echo "Showing existing databases..."
mysql -u ${mysql_root_name} -p${mysql_root_password} -e "SHOW DATABASES;"
echo ""
echo "Enter your new database user NAME:"
read db_user
echo ""
echo "Enter your new database user PASSWORD:"
read -s db_pass
echo ""
echo "Creating the new user..."
mysql -u ${mysql_root_name} -p${mysql_root_password} -e "CREATE USER ${db_user}@localhost IDENTIFIED BY '${db_pass}';"
echo "Database user successfully created..."
echo "Granting ALL privileges on ${db_name} to ${db_user}..."
mysql -u ${mysql_root_name} -p${mysql_root_password} -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost';"
mysql -u ${mysql_root_name} -p${mysql_root_password} -e "FLUSH PRIVILEGES;"
echo "Creating the new database tables..."
#mysql -u ${mysql_root_name} -p${mysql_root_password} -e "USE ${db_name}; CREATE TABLE demo ();"
echo "Installation done... Enjoy!"
exit
