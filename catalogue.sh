echo ">>>>> create catalogue service <<<<<"
cp catalogue.service /etc/systemd/system/catalogue.service

echo ">>>>> create mongodb repo <<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>> install  nodejs repo <<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>> install nodejs <<<<<"
yum install nodejs -y

echo ">>>>> create application user <<<<<"
useradd roboshop

echo ">>>>> create directory <<<<<"
mkdir /app

echo ">>>>> download application content <<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>> extract applicaation content <<<<< "
cd /app
unzip /tmp/catalogue.zip
cd /app

echo ">>>>> download nodejs dependency <<<<<"
npm install

echo" >>>>> install mongodb org shell >>>>>"
yum install mongodb-org-shell -y

echo ">>>>> load catalogue schema >>>>>"
mongo --host mongodb.sdevops28.online </app/schema/catalogue.js

echo ">>>>> enable start catalouge >>>>>"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

