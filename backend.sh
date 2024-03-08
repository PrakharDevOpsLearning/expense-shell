#BackEnd Script
source common.sh
my_sql_root_pwd=$1

if [ -z "${my_sql_root_pwd}" ]; then
   echo password is missing
   exit 1
fi

print_task_heading "disable nods.js"
dnf module disable nodejs -y &>>$LOG
check_status $?

print_task_heading "enable node.js"
dnf module enable nodejs:20 -y &>>$LOG
check_status $?

print_task_heading "install node.js"
dnf install nodejs -y &>>$LOG
check_status $?

print_task_heading "adding user"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense &>>$LOG
fi
check_status $?

print_task_heading "copying backend.service"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
check_status $?

print_task_heading "downloading backend.zip"
rm -rf /app &>>$LOG
check_status $?
mkdir /app &>>$LOG
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
cd /app &>>$LOG
unzip /tmp/backend.zip &>>$LOG
check_status $?

print_task_heading "npm install"
cd /app &>>$LOG
npm install &>>$LOG
check_status $?

print_task_heading "enable backend"
systemctl enable backend &>>$LOG
check_status $?

print_task_heading "start backend"
systemctl start backend &>>$LOG
check_status $?

print_task_heading "install mqsql"
dnf install mysql -y &>>$LOG
check_status $?

print_task_heading "schema add"
mysql -h 172.31.3.184 -uroot -p${my_sql_root_pwd} < /app/schema/backend.sql &>>$LOG
check_status $?
