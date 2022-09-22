# /root/app/startup.sh


# run on back
# sh /root/app/App2.sh > /root/app/App2.log 2>&1 &


# run on front
# sh /root/app/app1.sh > /root/app/app1.log 2>&1


# run on front
echo "start dotnet app in docker"
cd   /root/app/app1
dotnet app1.dll


# run on front
# while [ 1 -lt 2 ]
# do
# 	sleep 3600
# done



