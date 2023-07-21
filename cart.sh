echo -e "\e[36m>>>>>>> cart service <<<<<<<<\e[0m"
cp cart.service /etc/systemd/system/cart.service >\tmp\roboshop.log

echo -e "\e[32m>>>>>>> nodejs repos download <<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>\tmp\roboshop.log

echo -e "\e[33m>>>>>>> install  nodejs <<<<<<<\e[0m"
yum install nodejs -y &>>\tmp\roboshop.log

echo -e "\e[34m>>>>>>> add application user <<<<<<<\e[0m"
useradd roboshop &>>\tmp\roboshop.log

echo -e "\e[35m>>>>>>> delete directory <<<<<<<\e[0m"
rm -rf /app &>>\tmp\roboshop.log

echo -e "\e[36m>>>>>>> create directory <<<<<<<\e[0m"
mkdir /app &>>\tmp\roboshop.log

echo -e "\e[32m>>>>>>> download artifacts <<<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>\tmp\roboshop.log

echo -e "\e[33m>>>>>>> install artifacts <<<<<<<\e[0m"
cd /app
unzip /tmp/cart.zip &>>\tmp\roboshop.log
cd /app

echo -e "\e[36m>>>>>>> install dependencies <<<<<<<\e[0m"
npm install &>>\tmp\roboshop.log

echo -e "\e[35m>>>>>>> enable start cart <<<<<<<\e[0m"
systemctl daemon-reload &>>\tmp\roboshop.log
systemctl enable cart &>>\tmp\roboshop.log
systemctl restart cart &>>\tmp\roboshop.log

