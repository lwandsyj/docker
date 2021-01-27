1. 安装docker

        curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

        查看 docker -v

2. 安装ubuntu 镜像，指定版本

        sudo  docker pull  ubuntu:focal-20210119

   查看已安装的镜像

        sudo docker images
        或者
        sudo docker image ls

   查看某个镜像详细信息

        sudo docker inspect docker.io/mysql:5.7

        sudo docker inspect ubuntu:focal-20210119

        ubuntu 是repository,tag 是focal-20210119

    删除镜像

    如果镜像下面有容器，要先删除容器才能删除镜像。
    如果容器正在运行，要先停止镜像

        sudo docker stop containerId
        sudo docker rm containerId
        sudo docker rmi imagesId

        docker image rm [image]
        -f, -force: 强制删除镜像，即便有容器引用该镜像；
        -no-prune: 不要删除未带标签的父镜像；

3. 启动镜像

        docker run -p 本机映射端口:镜像映射端口 -d  --name 启动镜像名称 -e 镜像启动参数  镜像名称:镜像版本号

        参数释义：

        -p   本机端口和容器启动端口映射
        -d   后台运行
        --name   容器名称
        -e    镜像启动参数 
        例：docker run -p 3306:3306 -d --name mysql01 -e MYSQL_ROOT_PASSWORD=admin mysql:5.6

        公开多个端口

        docker run -it -p20180:80   -p20181:8080  -p20182:8976 --name containerName image:tag

        sudo docker run -d -p 8667:8667 -p 8668:8668 -p 8669:8669 -p 26657:26657 -p 26658:26658 ubuntu:focal-20210119

    查看启动的镜像

        docker ps // 已启动的

        sudo docker ps -a // docker 已启动的也显示

4. 容器启动后可以进入里面

        sudo docker exec -it c2b15db1ae6e(容器id) /bin/bash(执行命令)

        sudo docker attach 容器ID

        退出容器
        如果要正常退出不关闭容器，请按Ctrl+P+Q进行退出容器
        exit;

5. dockerfile expose 端口后

   外界要和Docker容器进行通讯，那么除了link必须是port映射

    dockerfile

        # PORT
        EXPOSE 8080
        EXPOSE 22
        EXPOSE 8009
        EXPOSE 8005
        EXPOSE 8443

    根据dockerfile 生成镜像

        docker build -t port_list . // 查找当前目录的dockerfile 文件
        docker images | grep port_list

    构建成功后运行该 images，注意在容器运行的时候一定要加-P

        docker run -d -it -P --name port_list_container port_list

        -d: 后端运行
        --name: 容器名称  port_list_container
        port_list: 启动容器

    OK，Container已经running，分别映射端口为（22，8005，8009，8443，8080）映射到本机中的(32775，32776，32777，32773，32774)

6. dockerfile cmd

   CMD命令发生在容器启动时,当一个镜像文件被创建为容器的时候执行,***一个容器默认只启动一个进程，所以一个Dockerfile中只可以有一个CMD,如果有多个，则最后一个生效用来指定容器启动时默认执行的程***。

   要执行多个cmd 命令，可以把命令放到一个sh 文件里面

        #!/bin/bash // 不能省略
        ./tendermint.linux.static-linked.linux init
        export LEDGER_DIR=/tmp 
        ./abci_validator_node.linux.gnu.dyn-linked.gnu
        ./query_server.linux.gnu.dyn-linked.dynlinked

7. dockerfile run 命令

    run 命令是在打包镜像的时候运行，即docker build
    run 可以有多条

            RUN apt update  // 解决E: Unable to locate package openssh-server
            RUN apt install openssl -y
            RUN chmod +x run.sh;
            RUN chmod +x tendermint.linux.static-linked.linux
            RUN chmod +x abci_validator_node.linux.gnu.dyn-linked.gnu
            RUN chmod +x query_server.linux.gnu.dyn-linked.dynlinked

8. apt install

+ E: Unable to locate package openssh-server 问题

        apt update

+ -y： 有些安装中间要用户同意，可以直接使用-y

9. 根据dockerfile 生成镜像

+ 当前目录，生成镜像冰袋标签

        docker build -t runoob/ubuntu:v1 . 
        :v1: 为tag 标签

+ 通过-f 指定dockerfile

        docker build -f /path/to/a/Dockerfile .