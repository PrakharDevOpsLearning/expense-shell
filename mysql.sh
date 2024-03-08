source common.sh
my_sql_root_pwd=$1
if [ -z "${my_sql_root_pwd}" ]; then
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
output=$(mysql_secure_installation --set-root-pass ${my_sql_root_pwd}) &>>LOG
if [ $output = "Password already set, You cannot reset the password with mysql_secure_installation" ]; then
    exit 0
else
   mysql_secure_installation --set-root-pass ${my_sql_root_pwd} &>>LOG
fi

check_status $?
