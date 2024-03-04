#Front End Script

dnf install nginx -y
systemctl enable nginx
systemctl start nginx
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
cp expense.conf /etc/nginx/default.d/expense.conf
systemctl restart nginx

#MySql Script

dnf install mysql-server -y
systemctl enable mysqld
systemctl start mysqld
mysql_secure_installation --set-root-pass ExpenseApp@1

#BackEnd Script
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
useradd expense
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
cd /app
unzip /tmp/backend.zip
cd /app
npm install
cp backend.service /etc/systemd/system/backend.service
systemctl enable backend
systemctl start backend
dnf install mysql -y
mysql -h 172.31.19.1 -uroot -pExpenseApp@1 < /app/schema/backend.sql