# ��ƽ̨���� Docker ����x86��arm
> https://docs.docker.com/engine/reference/commandline/buildx/
> https://blog.csdn.net/alex_yangchuansheng/article/details/103146303
> https://www.latelee.org/docker/armdocker-cross-comiple-for-arm-on-x86.html


#----------------------------------------------------------------------------
#���� buildx ���

#����ʵ������ 
export DOCKER_CLI_EXPERIMENTAL=enabled

#��֤�Ƿ���
docker buildx version

#����binfmt_misc
docker run --rm --privileged docker/binfmt:66f9012c56a8316f9244ffd7622d7c21c1f6f28d

#��֤binfmt_misc�Ƿ���
ls -al /proc/sys/fs/binfmt_misc/



#�鿴�������Ƿ����
if [ "$(docker buildx ls | grep mybuilder)" ]; then echo 'already exist'; else echo 'not exist'; fi

#����������
#docker buildx create --use --name mybuilder
if [ ! "$(docker buildx ls | grep mybuilder)" ]; then docker buildx create --use --name mybuilder; fi

#����������
docker buildx inspect mybuilder --bootstrap

#�鿴��ǰʹ�õĹ�������������֧�ֵ� CPU �ܹ������Կ���֧�ֺܶ� CPU �ܹ���
docker buildx ls



#----------------------------------------------------------------------------
#ʹ��buildx����arm�ܹ���Docker���� 
cd /home/ec2-user/image 
docker buildx build -t serset/raspi_opencv --platform=linux/arm/v7 -o type=docker .



#����֧�� arm��arm64 �� amd64 ��ܹ��� Docker ����ͬʱ�������͵� Docker Hub
docker login -u serset -p xxxxxxxxx
cd /home/ec2-user/image 
docker buildx build -t serset/opencv  --platform=linux/arm/v7,linux/arm64,linux/amd64 . --push
 
 

#----------------------------------------------------------------------------
#���������� �Ƴ�������
#docker buildx rm mybuilder -f;
if [ "$(docker buildx ls | grep mybuilder)" ]; then docker buildx rm mybuilder; fi








