#Front End Script
source common.sh

app_dir=/usr/share/nginx/html
component=frontend

print_task_heading "install nginx"
dnf install nginx -y &>>$LOG
check_status $?

print_task_heading "copying expense.conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
check_status $?

AppPreReq

print_task_heading "enable nginx"
systemctl enable nginx &>>$LOG
check_status $?

print_task_heading "restart of nginx"
systemctl restart nginx &>>$LOG
check_status $?

