1. FROM： FROM 必须为 Dockerfile 的第一条指令

   设置 Dockerfile 使用的基础镜像;随后的指令皆执行于这个镜像之上。基础镜像以“镜 像:标签”(IMAGE:TAG)的格式表示(例如 debian:wheezy)。如果省略标签，那么就被 视为最新(latest)，但我强烈建议你一定要给标签设置为某个特定版本，以免出现任 何意想不到的事情。

        FROM ubuntu:focal-20210119

        ubuntu: 镜像名称
        focal-20210119： tag 标签（或者可以看成版本号）

2. ENV： 环境变量

    设置镜像内的环境变量。这些变量可以被随后的指令引用。例如:

          ENV MY_VERSION 1.3

          RUN apt-get install -y mypackage=$MY_VERSION

    在镜像中这些变量仍然可用。

3. WORKDIR： 工作目录或者可以认为当前目录, 当run 命令中使用了cd 但是下一个run 命令中仍然是当前的workdir 指定的目录

    可以定义多次，命令执行的时候以最新定义的一次为准

   对任何后续的 RUN、CMD、ENTRYPOINT、ADD 或 COPY 指令设置工作目录。这个指令可多次使用。支持使用相对路径，按上次定义的 WORKDIR 解析

        RUN mkdir shared
        WORKDIR /shared

    当使用exec 进入容器时，指定的默认目录

4. COPY: 拷贝本地机器内容到docker 容器中

    COPY shared .  // 把本地机器中shared目录下的内容拷贝到docker 容器中workdir 指定的当前目录中

5. RUN： 执行命令，可以有多条，在创建镜像时执行，即调用docker build 时执行

        RUN apt update
        RUN apt install openssl -y
        RUN chmod +x run.sh;
        RUN chmod +x tendermint.linux.static-linked.linux
        RUN chmod +x abci_validator_node.linux.gnu.dyn-linked.gnu
        RUN chmod +x query_server.linux.gnu.dyn-linked.dynlinked

        RUN yum -y install openssh-server \
            && useradd natash \
            && echo "redhat"|passwd --stdin natash \
            && echo "redhat"|passwd --stdin root   \
            && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''\
            && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
            && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
            && echo "$TZ"\
            && cp /keys/ssh_host_ecdsa_key  /keys/ssh_host_ed25519_key  /keys/ssh_host_rsa_key  /tmp/

6. EXPOSE: 公开端口

    向 Docker 表示该容器将会有一个进程监听所指定的端口。提供这个信息的目的是用 于连接容器或在执行docker run命令时通过-P参数把端口发布开来; EXPOSE 指令本身并不会对网络有实质性的改变

    或者可以使用

        sudo docker run -d -p 8667:8667 -p 8668:8668 -p 8669:8669 -p 26657:26657 -p 26658:26658 ubuntu:focal-20210119
    
    -p: 指定单个
    -P: 公开dockerfile 中expose 指定的所有端口

            EXPOSE 8667
            EXPOSE 8668
            EXPOSE 8669
            EXPOSE 26657
            EXPOSE 26658
        公开五个端口

            EXPOSE  22  80

7. CMD： docker run 容器启动时执行的命令，只能有一个CMD

   当容器启动时执行指定的指令。如果还定义了 ENTRYPOINT ，该指令将被解释为 ENTRYPOINT 的参数(在这种情况下，请确保使用的是 exec 格式)。
   
   CMD 指令也会被 docker run命令中镜像名称后面的所有参数覆盖。
   
   ***假如定义了多个CMD指令，那么只有 最后一个生效，前面出现过的 CMD 指令全部无效(包括出现在基础镜像中的那些)***

        CMD ["sh", "run.sh"]

        CMD ["nginx", "-g", "daemon off;"]

8. ENTRYPOINT相当于CMD,是配置容器后的一个指令,***但是他不会被提docker run供的参数覆盖,每个Dockerfile只能有一个ENTRYPOINT，如果指定了多个，只有最后一个被执行,而且一定会被执行***

9. ADD 和copy 差不多，但是可以用于远程，压缩文件（会被自动解压缩）

        ADD keys.tar.gz   /