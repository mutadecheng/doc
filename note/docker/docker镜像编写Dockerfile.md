-------------------------------------------------------
#��дDockerfile
# https://www.cnblogs.com/saolv/p/12852818.html
>ע: CMD ["dotnet","Mc.Server.Station.dll"] ��Ӧ�ý���ʱ��һ���ܼ�ʱ������������CMD dotnet Mc.Server.Station.dll��Ӧ�ý���ʱ��ʱ��������


# chmod +x �������ִ��Ȩ��   777������Ӷ�дȨ��

#Dockerfile(�Ƽ�)
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /root/app/mc
# CMD ["dotnet","Mc.Server.Station.dll"]
CMD dotnet Mc.Server.Station.dll

#Dockerfile(�Ƽ�)
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
#Dockerfile(�����飬��ΪҪ�����б������ļ�startup.bash)
FROM microsoft/dotnet:2.1-aspnetcore-runtime
COPY startup.bash /root/app/startup.sh
RUN ["chmod","+x","/root/app/startup.sh"]
ENTRYPOINT ["/root/app/startup.sh"]

#��������ʱָ����������
docker run --name=mcc -d serset/dotnet:2.1 echo "echoFromCmd"

#��������ʱָ��entrypoint
docker run --name=mcc -d --entrypoint echo serset/dotnet:2.1 "echoFromEntrypoint"




-------------------------------------------------------
#Ϊ����ָ������
# https://cloud.tencent.com/developer/ask/46581
# dockerfile ���������������޸�
RUN echo '#!/bin/bash\ndotnet /root/app/FileZip.dll $*' > /usr/bin/filezip && chmod +x /usr/bin/filezip



