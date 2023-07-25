echo -e "\e[35m>>>>> install mongodb org shell <<<<<\e[0m"
yum install nginx -y

echo -e "\e[35m>>>>> install mongodb org shell <<<<<\e[0m"
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[35m>>>>> install mongodb org shell <<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35m>>>>> install mongodb org shell <<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

systemctl enable nginx
systemctl restart nginx