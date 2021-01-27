1. 根据镜像启动容器

   docker run -p 本机映射端口:镜像映射端口 -d  --name 启动镜像名称 -e 镜像启动参数  镜像名称:镜像版本号

   参数名称：

   + -p：本机端口和容器启动端口映射

   + -P: dockerfile 中Expose 设置的端口公开

   + -d: 后台运行

   + --name: 设置容器名称

   + -e ： 启动参数

        sudo docker run imageName:tag
        tag 默认为last

2. 启动停止的容器

        sudo docker start containerID

3. 停止启动的容器

        sudo docker stop containerID

4. 重启容器

        sudo docker restart containerID

5. 删除容器

   在删除容器时，如果容器是运行状态，则应该先停止容器运行

        sudo docker stop containerID

        sudo docker rm contianerID

6. 查看容器

        sudo docker ps // 正在运行的容器

        sudo docker ps -a // 停止的容器

7. 进入容器

        sudo docker exec -it 775c7c9ee1e1(容器id) /bin/bash  
