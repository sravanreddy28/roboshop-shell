echo -e "\e[36m>>>>> user service file <<<<<\e[0m "
cp user.service /etc/systemd/system/user.service

echo -e "\e[32m>>>>> copying mongo repos <<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33m>>>>> download nodejs rpm <<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m>>>>> install nodejs <<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>> adding user <<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>> remove directioy <<<<<\e[0m"
rm -rf /app

echo -e "\e[35m>>>>> create directioy <<<<<\e[0m"
mkdir /app

echo -e "\e[33m>>>>> download artificats <<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

echo -e "\e[32m>>>>> extract artifacts <<<<<\e[0m"
cd /app
unzip /tmp/user.zip
cd /app

echo -e "\e[36m>>>>> install nodejs dependencies <<<<<\e[0m"
npm install

echo -e "\e[35m>>>>> install mongodb org shell <<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[35m>>>>> load user schema <<<<<\e[0m"
mongo --host mongodb.sdevops28.online </app/schema/user.js

echo -e "\e[33m>>>>> enable restart user <<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

