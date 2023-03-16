# PASSWORD="tysf1839"

#プロンプトをechoを使って表示
echo -n INPUT_STR:
#入力を受付、その入力を「str」に代入
read PASSWORD
#結果を表示
tty -s && echo
# echo $PASSWORD

echo $PASSWORD | sudo -l
