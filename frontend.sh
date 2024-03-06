#Front End Script
source common.sh

print_task_heading "install nginx"
dnf install nginx -y &>>$LOG
check_status $?

print_task_heading "enable nginx"
systemctl enable nginx &>>$LOG
check_status $?

print_task_heading "start nginx"
systemctl start nginx &>>$LOG
check_status $?

print_task_heading "removing static html content from nginx"
rm -rf /usr/share/nginx/html/* &>>$LOG
check_status $?

print_task_heading "copying expense.conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
check_status $?

print_task_heading "downloanding frontend.zip"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$LOG
cd /usr/share/nginx/html &>>$LOG
check_status $?

print_task_heading "unzip frontend"
unzip /tmp/frontend.zip &>>$LOG
check_status $?

print_task_heading "restart of nginx"
systemctl restart nginx &>>$LOG
check_status $?

