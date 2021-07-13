FROM ubuntu:18.04

#(x.1)install ssh unzip
RUN apt-get update && apt-get -y install openssh-server unzip

# Set password to '123456'. Change as needed.  
RUN echo "root:123456" | chpasswd

#Copy settings file. See else where to find them. 
COPY sshd_config /etc/ssh/sshd_config




 #(x.2)install git
RUN apt-get install -y git
RUN mkdir /root/git


# set git clone default dir
WORKDIR /root/git
VOLUME ["/root/git"]





#(x.3)RUN service ssh start
#startup.sh
COPY startup.sh /root/startup.sh
CMD ["sh","/root/startup.sh"]