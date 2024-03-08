source common.sh
$1
if [ -z "$1" ]; then
  echo password is missing
  exit 1
fi
print_task_heading "install mysql service"
dnf install mysql-server -y &>>$LOG
check_status $?

print_task_heading "enable mysql id"
systemctl enable mysqld &>>$LOG
check_status $?

print_task_heading "start mysqlid"
systemctl start mysqld &>>$LOG
check_status $?

print_task_heading "set password"
output= ${mysql_secure_installation --set-root-pass $1 &>>$LOG}
echo $output
if
check_status $?
