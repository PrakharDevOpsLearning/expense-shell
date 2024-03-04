#Front End Script
echo "install nginx"
dnf install nginx -y
echo $?

echo "enable nginx"
echo $?
systemctl enable nginx

echo "start nginx"
systemctl start nginx
echo $?

echo "removing static html content from nginx"
rm -rf /usr/share/nginx/html/*
echo $?

echo "copying expense.conf file"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

echo "downloanding frontend.zip"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html
echo $?

echo "unzip frontend"
unzip /tmp/frontend.zip
echo $?

echo "restart of nginx"
systemctl restart nginx
echo $?

#MySql Script

echo "install mysql service"
dnf install mysql-server -y
echo $?

echo "enable mysql id"
systemctl enable mysqld
echo $?

echo "start mysqlid"
systemctl start mysqld
echo $?

echo "set password"
mysql_secure_installation --set-root-pass ExpenseApp@1
echo $?

#BackEnd Script
echo "disbale nods.js"
dnf module disable nodejs -y
echo $?

echo "enable node.js"
dnf module enable nodejs:20 -y
echo $?

echo "install node.js"
dnf install nodejs -y
echo $?

echo "adding user"
useradd expense
echo $?

echo "pwd command"
pwd

echo "CD command"
cd

echo "New Location"
pwd

echo "copying backend.service"
cp backend.service /etc/systemd/system/backend.service


echo "downloading backend.zip"
rm -rf /app
echo $?
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
cd /app
unzip /tmp/backend.zip
echo $?

echo "npm install"
npm install
echo $?

echo "enable backend"
systemctl enable backend
echo $?

echo "start backend"
systemctl start backend
echo $?

echo "install mqsql"
dnf install mysql -y
echo $?

echo "schema add"
mysql -h 172.31.19.1 -uroot -pExpenseApp@1 < /app/schema/backend.sql
echo $?
