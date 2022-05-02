#/bin/bash

file='/tmp/cpu-mem.stat'
rm -f $file
echo "getting CPU stats into $file "
echo "########\n
      ########"

echo "CPU Stats" > $file
ps -eo pid,ppid,%mem,%cpu,comm --sort=-%cpu | head -n 4|sed '2,3'd >>"$file"

echo "checking port for most consumed"
pid=`cat $file |awk '{print $1}'|grep -v PID|grep -v -i cpu`
echo "$pid"
netstat -ltnup  |grep $pid|grep LISTEN >/tmp/test

vars=`cat /tmp/test`

if [[ $vars == *":::"* ]] ; then

port=`awk -F":" '{print $4}' /tmp/test`

echo "TCP6 and port is $port"
exit

else [[ "$vars" == *"0.0.0.0:"* ]]; 

port=`awk -F":" '{print $1}' /tmp/test`
echo "TCP4 and port is $port"
exit

fi
