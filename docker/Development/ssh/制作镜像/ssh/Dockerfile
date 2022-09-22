FROM ubuntu:18.04

#(x.1)
ENV LANG C.UTF-8

#(x.2)install ssh
RUN apt-get update && apt-get -y install openssh-server unzip

# Set password to '123456'. Change as needed.  
RUN echo "root:123456" | chpasswd

#Copy settings file. See elsewhere to find them. 
COPY sshd_config /etc/ssh/sshd_config

#RUN service ssh restart


#(x.3)set default dir
WORKDIR /root

#(x.4)start ssh
#CMD ["sh","-c","service ssh start ; tail -f /dev/null;"]
CMD  service ssh start && tail -f /dev/null
