echo -e "\e[36m>>>>>>>>>>> create catalogue service <<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>>>>>> create mongodb repo <<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>>>> install  nodejs repo <<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>>> install nodejs <<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>>> create application user <<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>> remove directory <<<<<<<<<<\e[0m"
rm -rf /app

echo -e "\e[36m>>>>>>>>>>> create directory <<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[36m>>>>>>>>>> download application content <<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[36m>>>>>>>>>> extract applicaation content <<<<<<<<<<\e[0m "
cd /app
unzip /tmp/catalogue.zip
cd /app

echo -e "\e[36m>>>>>>>>>> download nodejs dependency <<<<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>>>>> install mongodb org shell <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>> load catalogue schema <<<<<<<<<<\e[0m"
mongo --host mongodb.sdevops28.online </app/schema/catalogue.js

echo -e "\e[36m>>>>>>>>>> enable start catalouge <<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

