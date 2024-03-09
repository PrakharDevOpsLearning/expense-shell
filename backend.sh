#BackEnd Script
source common.sh
my_sql_root_pwd=$1
component=backend
app_dir=/app

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

AppPreReq

print_task_heading "npm install"
cd $app_dir &>>$LOG
npm install &>>$LOG
check_status $?

print_task_heading "enable backend"
systemctl enable backend &>>$LOG
check_status $?

print_task_heading "start backend"
systemctl start backend &>>$LOG
check_status $?

print_task_heading "install mysql"
dnf install mysql -y &>>$LOG
check_status $?

print_task_heading "schema add"
mysql -h 172.31.15.231 -uroot -p${my_sql_root_pwd} < /app/schema/backend.sql &>>$LOG
check_status $?
