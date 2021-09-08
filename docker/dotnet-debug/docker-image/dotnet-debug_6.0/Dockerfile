FROM mcr.microsoft.com/dotnet/sdk:6.0

#(x.1)install ssh
RUN apt-get update && apt-get -y install openssh-server unzip

# Set password to '123456'. Change as needed.  
RUN echo "root:123456" | chpasswd

#Copy settings file. See elsewhere to find them. 
COPY sshd_config /etc/ssh/sshd_config

#RUN service ssh restart


#(x.2)install vs-debugger
# latest Ö§³Ö vs2022 vs2019 vsfm-8 vs2017u5
# vs2017u1
RUN curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /root/.vs-debugger/latest
RUN curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v vs2017u5 -l /root/.vs-debugger/vs2017u5
RUN chmod +x  /root/.vs-debugger



#(x.3)startup.sh
COPY startup.sh /root/app/startup.sh
CMD ["sh","/root/app/startup.sh"]