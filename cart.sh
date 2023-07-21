echo ">>>>>>> cart service <<<<<<<<"
cp cart.service /etc/systemd/system/cart.service

echo ">>>>>>> nodejs repos download <<<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>>>> install  nodejs <<<<<<<"
yum install nodejs -y

echo ">>>>>>> add application user <<<<<<<"
useradd roboshop

echo ">>>>>>> create directory <<<<<<<"
mkdir /app

echo ">>>>>>> download artifacts <<<<<<<"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

echo ">>>>>>> install artifacts <<<<<<<"
cd /app
unzip /tmp/cart.zip
cd /app

echo ">>>>>>> install dependencies <<<<<<<"
npm install

echo ">>>>>>> enable start cart <<<<<<<"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart

