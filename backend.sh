#BackEnd Script
source common.sh
my_sql_root_pwd = $1
echo "disable nods.js"
dnf module disable nodejs -y &>>$LOG
echo $?

echo "enable node.js"
dnf module enable nodejs:20 -y &>>$LOG
echo $?

echo "install node.js"
dnf install nodejs -y &>>$LOG
echo $?

echo "adding user"
useradd expense &>>$LOG
echo $?

echo "copying backend.service"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
echo $?

echo "downloading backend.zip"
rm -rf /app &>>$LOG
echo $?
mkdir /app &>>$LOG
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
cd /app &>>$LOG
unzip /tmp/backend.zip &>>$LOG
echo $?

echo "npm install"
cd /app &>>$LOG
npm install &>>$LOG
echo $?

echo "enable backend"
systemctl enable backend &>>$LOG
echo $?

echo "start backend"
systemctl start backend &>>$LOG
echo $?

echo "install mqsql"
dnf install mysql -y &>>$LOG
echo $?

echo "schema add"
mysql -h 172.31.30.79 -uroot -p${my_sql_root_pwd} < /app/schema/backend.sql &>>$LOG
echo $?
