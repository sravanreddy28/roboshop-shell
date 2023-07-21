echo -e "\e[36m>>>>>>> cart service <<<<<<<</e[0m"
cp cart.service /etc/systemd/system/cart.service

echo -e "\e[32m>>>>>>> nodejs repos download <<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[33m>>>>>>> install  nodejs <<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[34m>>>>>>> add application user <<<<<<<\e[0m"
useradd roboshop

echo -e "\e[35m>>>>>>> delete directory <<<<<<<\e[0m"
rm -rf /app

echo -e "\e[36m>>>>>>> create directory <<<<<<<\e[0m"
mkdir /app

echo -e "\e[32m>>>>>>> download artifacts <<<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

echo -e "\e[33m>>>>>>> install artifacts <<<<<<<\e[0m"
cd /app
unzip /tmp/cart.zip
cd /app

echo -e "\e[36m>>>>>>> install dependencies <<<<<<<\e[0m"
npm install

echo -e "\e[35m>>>>>>> enable start cart <<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart

