1. 安装docker

         curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

         查看是否安装成功

         docker -v

2. 安装lrzsz,上传文件

        sudo apt install lrzsz -y

3. 创建目录存放相关文件

        sudo mkdir shared

        cd shared

4. 上传文件

        sudo rz   

        上传
        abci_validator_node.linux.gnu.dyn-linked.gnu
        tendermint.linux.static-linked.linux node
        query_server.linux.gnu.dyn-linked.dynlinked
        config.toml
        run.sh

5. 回到桌面上传dockerfile

        cd ..
        sudo rz
        dockerfile

6. 根据dockerfile 打包镜像

        sudo docker build -t ricky/findora:v1 .
        // 会自动匹配端口对应dockerfile 中的端口
        #sudo docker run -d -P --name findora-v3 ricky/findora:v3

        sudo docker run -d -p 8667:8667 -p 26657:26657 -p 26658:26658 -p 8668:8668 -p 8669:8669 --name findora-v1 ricky/findora:v1