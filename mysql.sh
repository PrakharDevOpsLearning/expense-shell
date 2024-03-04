echo "install mysql service"
dnf install mysql-server -y
echo $?

echo "enable mysql id"
systemctl enable mysqld
echo $?

echo "start mysqlid"
systemctl start mysqld
echo $?

echo "set password"
mysql_secure_installation --set-root-pass ExpenseApp@1
echo $?
