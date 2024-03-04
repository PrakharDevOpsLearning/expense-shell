#Front End Script
echo "install nginx"
dnf install nginx -y >/tmp/expense.log
echo $?

echo "enable nginx"
systemctl enable nginx >/tmp/expense.log
echo $?

echo "start nginx"
systemctl start nginx >/tmp/expense.log
echo $?

echo "removing static html content from nginx"
rm -rf /usr/share/nginx/html/* >/tmp/expense.log
echo $?

echo "copying expense.conf file"
pwd
cp expense.conf /etc/nginx/default.d/expense.conf >/tmp/expense.log
echo $?

echo "downloanding frontend.zip"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip >/tmp/expense.log
cd /usr/share/nginx/html >/tmp/expense.log
echo $?

echo "unzip frontend"
unzip /tmp/frontend.zip >/tmp/expense.log
echo $?

echo "restart of nginx"
systemctl restart nginx >/tmp/expense.log
echo $?

