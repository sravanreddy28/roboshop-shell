func_nodejs() {
log=\tmp\roboshop.log

echo -e "\e[36m>>>>> user service file <<<<<\e[0m "
cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

echo -e "\e[32m>>>>> copying mongo repos <<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "\e[33m>>>>> download nodejs rpm <<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo -e "\e[34m>>>>> install nodejs <<<<<\e[0m"
yum install nodejs -y &>>${log}

echo -e "\e[36m>>>>> adding user <<<<<\e[0m"
useradd roboshop &>>${log}

echo -e "\e[36m>>>>> remove directioy <<<<<\e[0m"
rm -rf /app &>>${log}

echo -e "\e[35m>>>>> create directioy <<<<<\e[0m"
mkdir /app &>>${log}

echo -e "\e[33m>>>>> download artificats <<<<<\e[0m"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

echo -e "\e[32m>>>>> extract artifacts <<<<<\e[0m"
cd /app
unzip /tmp/${component}.zip &>>${log}
cd /app

echo -e "\e[36m>>>>> install nodejs dependencies <<<<<\e[0m"
npm install &>>${log}

echo -e "\e[35m>>>>> install mongodb org shell <<<<<\e[0m"
yum install mongodb-org-shell -y &>>${log}

echo -e "\e[35m>>>>> load user schema <<<<<\e[0m"
mongo --host mongodb.sdevops28.online </app/schema/${component}.js &>>${log}

echo -e "\e[33m>>>>> enable restart user <<<<<\e[0m"
systemctl daemon-reload &>>${log}
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}

}

func_java() {

echo -e "\e[25m>>>>> user service file <<<<<\e[0m "
cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

echo -e "\e[33m>>>>> install maven<<<<<\e[0m "
yum install maven -y &>>${log}

echo -e "\e[36m>>>>> add application user <<<<<\e[0m "
useradd roboshop &>>${log}

echo -e "\e[26m>>>>> creating directory <<<<<\e[0m "
mkdir /app &>>${log}
echo -e "\e[40m>>>>> download artifacts <<<<<\e[0m "
curl -L -o /tmp/${component}zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

echo -e "\e[38m>>>>> extract artifacts <<<<<\e[0m "
cd /app
unzip /tmp/${component}.zip &>>${log}
cd /app

echo -e "\e[35m>>>>> jar file <<<<<\e[0m "
mvn clean package &>>${log}
mv target/${component}-1.0.jar ${component}.jar &>>${log}

echo -e "\e[34m>>>>> install mysql <<<<<\e[0m "
yum install mysql -y &>>${log}

 echo -e "\e[33m>>>>> load schema <<<<<\e[0m "
mysql -h mysql.sdevops28.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}

echo -e "\e[32m>>>>> enable start service <<<<<\e[0m "
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
}
