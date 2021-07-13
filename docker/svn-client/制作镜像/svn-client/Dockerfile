FROM ubuntu:18.04

#(x.1)
ENV LANG C.UTF-8

#(x.2)install svn
RUN apt-get update && apt-get -y install subversion

#(x.3)set default dir
RUN mkdir /root/svn
WORKDIR /root/svn
VOLUME ["/root/svn"]


#(x.4)run startup.sh
COPY startup.sh /root/startup.sh
CMD ["sh","/root/startup.sh"]