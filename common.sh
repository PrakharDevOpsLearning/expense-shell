LOG=/tmp/expense.log

print_task_heading() {
  echo $1
  echo "################$1#############" &>>$LOG
}

check_status() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi
}

AppPreReq() {

  print_task_heading "removing static html content from nginx"
  rm -rf $app_dir/*  &>>$LOG
  check_status $?

  print_task_heading "downloanding frontend.zip"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
  cd $app_dir &>>$LOG
  check_status $?

  print_task_heading "unzip frontend"
  unzip /tmp/${component}.zip &>>$LOG
  check_status $?

}