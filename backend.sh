#BackEnd Script
echo "disbale nods.js"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

echo "enable node.js"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

echo "install node.js"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

echo "adding user"
useradd expense &>>/tmp/expense.log
echo $?

echo "copying backend.service"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

echo "downloading backend.zip"
rm -rf /app &>>/tmp/expense.log
echo $?
mkdir /app &>>/tmp/expense.log
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

echo "npm install"
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

echo "enable backend"
systemctl enable backend &>>/tmp/expense.log
echo $?

echo "start backend"
systemctl start backend &>>/tmp/expense.log
echo $?

echo "install mqsql"
dnf install mysql -y &>>/tmp/expense.log
echo $?

echo "schema add"
mysql -h 172.31.19.1 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log
echo $?
