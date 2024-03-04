source common.sh

echo "install mysql service"
dnf install mysql-server -y &>>$LOG
echo $?

echo "enable mysql id"
systemctl enable mysqld &>>$LOG
echo $?

echo "start mysqlid"
systemctl start mysqld &>>$LOG
echo $?

echo "set password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG
echo $?
