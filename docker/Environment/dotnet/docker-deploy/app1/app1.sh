
cd   /root/app/app1

while [ 1 -lt 2 ]
do
    echo "start dotnet app in docker"
    dotnet app1.dll
    sleep 1
done