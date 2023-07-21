echo ">>>>> user service file <<<<< "
cp user.service /etc/systemd/system/user.service

echo ">>>>> copying mongo repos <<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>> download nodejs rpm <<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>> install nodejs <<<<<"
yum install nodejs -y

echo ">>>>> adding user <<<<<"
useradd roboshop

echo ">>>>> create directioy <<<<<"
mkdir /app

echo ">>>>> download artificats <<<<<"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

echo ">>>>> extract artifacts <<<<<"
cd /app
unzip /tmp/user.zip
cd /app

echo ">>>>> install nodejs dependencies <<<<<"
npm install

echo ">>>>> install mongodb org shell <<<<<"
yum install mongodb-org-shell -y

echo ">>>>> load user schema <<<<<"
mongo --host mongodb.sdevops28.online </app/schema/user.js

echo ">>>>> enable restart user <<<<<"
systemctl daemon-reload
systemctl enable user
systemctl restart user

