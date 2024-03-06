LOG=/tmp/expense.log
print_task_heading() {
  echo $1
  echo "################$1#############" &>>$LOG
}
