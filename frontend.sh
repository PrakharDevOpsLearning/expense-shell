#Front End Script
echo "install nginx"
dnf install nginx -y >/tmp/expense.log
echo $?

echo "enable nginx"
echo $?
systemctl enable nginx

echo "start nginx"
systemctl start nginx
echo $?

echo "removing static html content from nginx"
rm -rf /usr/share/nginx/html/*
echo $?

echo "copying expense.conf file"
pwd
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

echo "downloanding frontend.zip"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html
echo $?

echo "unzip frontend"
unzip /tmp/frontend.zip
echo $?

echo "restart of nginx"
systemctl restart nginx
echo $?

