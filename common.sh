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
  echo "Inside common function"
  print_task_heading "cleanup Old content"
  rm -rf $app_dir/*  &>>$LOG
  check_status $?

<<EOF
  print_task_heading "Creating App Directory"
  mkdir $app_dir  &>>$LOG
  check_status $?
EOF

  print_task_heading "downloading App content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
  cd $app_dir &>>$LOG
  check_status $?

  print_task_heading "unzip frontend"
  unzip /tmp/${component}.zip &>>$LOG
  check_status $?

}