#BackEnd Script
echo "disbale nods.js"
dnf module disable nodejs -y
echo $?

echo "enable node.js"
dnf module enable nodejs:20 -y
echo $?

echo "install node.js"
dnf install nodejs -y
echo $?

echo "adding user"
useradd expense
echo $?

echo "copying backend.service"
cp backend.service /etc/systemd/system/backend.service
echo $?

echo "downloading backend.zip"
rm -rf /app
echo $?
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
cd /app
unzip /tmp/backend.zip
echo $?

echo "npm install"
cd /app
npm install
echo $?

echo "enable backend"
systemctl enable backend
echo $?

echo "start backend"
systemctl start backend
echo $?

echo "install mqsql"
dnf install mysql -y
echo $?

echo "schema add"
mysql -h 172.31.19.1 -uroot -pExpenseApp@1 < /app/schema/backend.sql
echo $?
