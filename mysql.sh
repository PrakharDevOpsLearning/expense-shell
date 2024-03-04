echo "install mysql service"
dnf install mysql-server -y &>>/tmp/expense.log
echo $?

echo "enable mysql id"
systemctl enable mysqld &>>/tmp/expense.log
echo $?

echo "start mysqlid"
systemctl start mysqld &>>/tmp/expense.log
echo $?

echo "set password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/expense.log
echo $?
