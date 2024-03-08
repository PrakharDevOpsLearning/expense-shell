source common.sh
$1
if [ -z "$1" ]; then
  echo password is missing
  exit 1
fi
echo "install mysql service"
dnf install mysql-server -y &>>$LOG
check_status $?

echo "enable mysql id"
systemctl enable mysqld &>>$LOG
check_status $?

echo "start mysqlid"
systemctl start mysqld &>>$LOG
check_status $?

echo "set password"
mysql_secure_installation --set-root-pass $1 &>>$LOG
check_status $?
