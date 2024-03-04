#Front End Script
echo "Install nginx"
dnf install nginx -y
echo "enable nginx"
systemctl enable nginx
echo "start nginx"
systemctl start nginx
echo "removing static html content from nginx"
rm -rf /usr/share/nginx/html/*
echo "downloanding frontend.zip"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo "copying expense.conf file"
cp expense.conf /etc/nginx/default.d/expense.conf
echo "restart of nginx"
systemctl restart nginx

#MySql Script
echo "install mysql service"
dnf install mysql-server -y
echo "enable mysql id"
systemctl enable mysqld
echo "start mysqlid"
systemctl start mysqld
echo "set password"
mysql_secure_installation --set-root-pass ExpenseApp@1

#BackEnd Script
echo "disbale nods.js"
dnf module disable nodejs -y
echo "enable node.js"
dnf module enable nodejs:20 -y
dbf "install nodejs"
dnf install nodejs -y
echo "adding user"
useradd expense
echo "copying backend.service"
cp backend.service /etc/systemd/system/backend.service
mkdir /app
echo "downloading backend.zip"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
cd /app
unzip /tmp/backend.zip
cd /app
echo "npm install"
npm install
echo "enable backend"
systemctl enable backend
echo "start backend"
systemctl start backend
echo "install mqsql"
dnf install mysql -y
echo "schema add"
mysql -h 172.31.19.1 -uroot -pExpenseApp@1 < /app/schema/backend.sql