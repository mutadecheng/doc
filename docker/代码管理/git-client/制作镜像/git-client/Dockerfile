FROM ubuntu:18.04

#(x.1)install ssh unzip
RUN apt-get update && apt-get -y install openssh-server unzip

# Set password to '123456'. Change as needed.  
RUN echo "root:123456" | chpasswd

#Copy settings file. See else where to find them. 
COPY sshd_config /etc/ssh/sshd_config


#(x.2)install curl
RUN apt-get install curl -y


#(x.3)install git
RUN apt-get install git -y


#(x.4)install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install git-lfs


#(x.5)set default dir
RUN mkdir -p /root/git
WORKDIR /root/git
VOLUME ["/root/git"]



#(x.6)RUN service ssh start
#startup.sh
COPY startup.sh /root/startup.sh
CMD ["sh","/root/startup.sh"]