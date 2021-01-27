1. 镜像获取的两种形式，一个根据dockerfile 生成镜像，一个是直接拉取镜像

+ 拉取镜像

        https://hub.docker.com/_/redis?tab=tags

        sudo docker pull redis:tag  tag 默认为latest 最新版本

        docker pull redis:latest

2. 查看当前的镜像images

        sudo docker images

        或者

        sudo docker image ls

3. 删除镜像

   删除镜像时，必须确保该镜像下没有容器，查看容器 

        sudo docker ps // 正在运行的容器

        sudo docker ps -a // 所有容器

   如果容器有在运行的，要先停止容器

        sudo docker stop containerId(容器id)

        sudo docker rm containerId(容器id)
    
    删除完该镜像下所有的容器，在删除镜像

        sudo docker rmi imageId(镜像id)
    
   强制删除镜像，但是不会删除容器

        sudo docker rmi imageId -f

4. 根据dockerfile 生成镜像

        sudo docker build -t ricky/findora:v1 .

