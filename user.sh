echo -e "\e[36m>>>>> user service file <<<<<\e[0m "
cp user.service /etc/systemd/system/user.service >\tmp\roboshop.log

echo -e "\e[32m>>>>> copying mongo repos <<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo >\tmp\roboshop.log

echo -e "\e[33m>>>>> download nodejs rpm <<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >\tmp\roboshop.log

echo -e "\e[34m>>>>> install nodejs <<<<<\e[0m"
yum install nodejs -y >\tmp\roboshop.log

echo -e "\e[36m>>>>> adding user <<<<<\e[0m"
useradd roboshop >\tmp\roboshop.log

echo -e "\e[36m>>>>> remove directioy <<<<<\e[0m"
rm -rf /app >\tmp\roboshop.log

echo -e "\e[35m>>>>> create directioy <<<<<\e[0m"
mkdir /app >\tmp\roboshop.log

echo -e "\e[33m>>>>> download artificats <<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip >\tmp\roboshop.log

echo -e "\e[32m>>>>> extract artifacts <<<<<\e[0m"
cd /app
unzip /tmp/user.zip >\tmp\roboshop.log
cd /app

echo -e "\e[36m>>>>> install nodejs dependencies <<<<<\e[0m"
npm install >\tmp\roboshop.log

echo -e "\e[35m>>>>> install mongodb org shell <<<<<\e[0m"
yum install mongodb-org-shell -y >\tmp\roboshop.log

echo -e "\e[35m>>>>> load user schema <<<<<\e[0m"
mongo --host mongodb.sdevops28.online </app/schema/user.js >\tmp\roboshop.log

echo -e "\e[33m>>>>> enable restart user <<<<<\e[0m"
systemctl daemon-reload >\tmp\roboshop.log
systemctl enable user >\tmp\roboshop.log
systemctl restart user >\tmp\roboshop.log

