-------------------------------------------------------
#编写Dockerfile
# https://www.cnblogs.com/saolv/p/12852818.html
>注: CMD ["dotnet","Mc.Server.Station.dll"] 在应用结束时不一定能及时结束容器，而CMD dotnet Mc.Server.Station.dll在应用结束时及时结束容器


# chmod +x 代表添加执行权限   777代表添加读写权限

#Dockerfile(推荐)
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /root/app/mc
# CMD ["dotnet","Mc.Server.Station.dll"]
CMD dotnet Mc.Server.Station.dll

#Dockerfile(推荐)
FROM microsoft/dotnet:2.1-aspnetcore-runtime
CMD ["sh","/root/app/startup.sh"]


#Dockerfile
FROM microsoft/dotnet:2.1-aspnetcore-runtime
ENTRYPOINT ["sh","/root/app/startup.sh"]

#Dockerfile
FROM microsoft/dotnet:2.1-aspnetcore-runtime
ENTRYPOINT ["chmod","777","/root/app/startup.sh"]
ENTRYPOINT ["sh","/root/app/startup.sh"]
 
#http://codingdict.com/questions/53396
#Dockerfile(不建议，因为要求镜像中必须有文件startup.bash)
FROM microsoft/dotnet:2.1-aspnetcore-runtime
COPY startup.bash /root/app/startup.sh
RUN ["chmod","+x","/root/app/startup.sh"]
ENTRYPOINT ["/root/app/startup.sh"]

#创建容器时指定启动命令
docker run --name=mcc -d serset/dotnet:2.1 echo "echoFromCmd"

#创建容器时指定entrypoint
docker run --name=mcc -d --entrypoint echo serset/dotnet:2.1 "echoFromEntrypoint"




-------------------------------------------------------
#为命令指定别名
# https://cloud.tencent.com/developer/ask/46581
# dockerfile 添加如下命令，按需修改
RUN echo '#!/bin/bash\ndotnet /root/app/FileZip.dll $*' > /usr/bin/filezip && chmod +x /usr/bin/filezip



