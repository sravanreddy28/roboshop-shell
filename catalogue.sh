log= /tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>> create catalogue service <<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>${log}

echo -e "\e[36m>>>>>>>>>>>> create mongodb repo <<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "\e[36>>>>>>>>>>> install  nodejs repo <<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo -e "\e[36>>>>>>>>>> install nodejs <<<<<<<<<<\e[0m"
yum install nodejs -y &>>${log}

echo -e "\e[36>>>>>>>>>> create application user <<<<<<<<<<\e[0m"
useradd roboshop &>>${log}

echo -e "\e[36>>>>>>>>>>> remove directory <<<<<<<<<<\e[0m"
rm -rf /app &>>${log}

echo -e "\e[36>>>>>>>>>>> create directory <<<<<<<<<<\e[0m"
mkdir /app &>>${log}

echo -e "\e[36>>>>>>>>>> download application content <<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}

echo -e "\e[36>>>>>>>>>> extract applicaation content <<<<<<<<<<\e[0m "
cd /app
unzip /tmp/catalogue.zip &>>${log}
cd /app

echo -e "\e[36>>>>>>>>>> download nodejs dependency <<<<<<<<<<\e[0m"
npm install &>>${log}

echo -e "\e[36 >>>>>>>>>> install mongodb org shell <<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y &>>${log}

echo -e "\e[36>>>>>>>>>> load catalogue schema <<<<<<<<<<\e[0m"
mongo --host mongodb.sdevops28.online </app/schema/catalogue.js &>>${log}

echo -e "\e[36>>>>>>>>>> enable start catalouge <<<<<<<<<<\e[0m"
systemctl daemon-reload &>>${log}
systemctl enable catalogue &>>${log}
systemctl restart catalogue &>>${log}

