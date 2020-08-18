1. docker run 

        docker run -d -p 80:80 docker/getting-started

        -d : 以分离模式运行容器（在后台)

        -p 80:80 -将主机的端口80映射到容器中的端口80: 

        -docker/getting-started -要使用的镜像

        docker run -dp 80:80 docker/getting-started  简写