#BackEnd Script
source common.sh
my_sql_root_pwd = $1

if [ -z "${my_sql_root_pwd }" ]; then
  echo password is missing
  exit 1
fi

echo "disable nods.js"
dnf module disable nodejs -y &>>$LOG
check_status $?

echo "enable node.js"
dnf module enable nodejs:20 -y &>>$LOG
check_status $?

echo "install node.js"
dnf install nodejs -y &>>$LOG
check_status $?

echo "adding user"
useradd expense &>>$LOG
check_status $?

echo "copying backend.service"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
check_status $?

echo "downloading backend.zip"
rm -rf /app &>>$LOG
check_status $?
mkdir /app &>>$LOG
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
cd /app &>>$LOG
unzip /tmp/backend.zip &>>$LOG
check_status $?

echo "npm install"
cd /app &>>$LOG
npm install &>>$LOG
check_status $?

echo "enable backend"
systemctl enable backend &>>$LOG
check_status $?

echo "start backend"
systemctl start backend &>>$LOG
check_status $?

echo "install mqsql"
dnf install mysql -y &>>$LOG
check_status $?

echo "schema add"
mysql -h 172.31.3.184 -uroot -p${my_sql_root_pwd} < /app/schema/backend.sql &>>$LOG
check_status $?
