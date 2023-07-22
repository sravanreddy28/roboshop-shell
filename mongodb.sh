echo ">>>>>>>>>> mongbd repo <<<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>>>>>>> install mongodb <<<<<<<<<<"
yum install mongodb-org -y

# update listen address from 127.0.0.1 to 0.0.0.0

echo ">>>>>>>>>> enable start mongob <<<<<<<<<<"
systemctl enable mongod
systemctl restart mongod