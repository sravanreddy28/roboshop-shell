echo ">>>>>>>>>> mysql.repos <<<<<<<<<<"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo ">>>>>>>>>> disable msql <<<<<<<<<<"
yum module disable mysql -y

echo ">>>>>>>>>> install mqsql community server <<<<<<<<<<"
yum install mysql-community-server -y

echo ">>>>>>>>>> enable start mysql <<<<<<<<<<"
systemctl enable mysqld
systemctl start mysqld

echo ">>>>>>>>>> setting password <<<<<<<<<<"
mysql_secure_installation --set-root-pass RoboShop@1