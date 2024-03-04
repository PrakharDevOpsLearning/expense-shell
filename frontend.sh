#Front End Script
source common.sh
echo "install nginx"
dnf install nginx -y &>>$LOG
echo $?

echo "enable nginx"
systemctl enable nginx &>>$LOG
echo $?

echo "start nginx"
systemctl start nginx &>>$LOG
echo $?

echo "removing static html content from nginx"
rm -rf /usr/share/nginx/html/* &>>$LOG
echo $?

echo "copying expense.conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
echo $?

echo "downloanding frontend.zip"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$LOG
cd /usr/share/nginx/html &>>$LOG
echo $?

echo "unzip frontend"
unzip /tmp/frontend.zip &>>$LOG
echo $?

echo "restart of nginx"
systemctl restart nginx &>>$LOG
echo $?

