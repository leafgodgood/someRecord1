# someRecord1
日常记录

### 1、利用容器实现编译、安装
需求：git clone代码、启动容器进行编译，组成集群3fe 3be

### ssh免密相关
ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''  
ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' 

sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

echo "123" | passwd --stdin root

ssh-keygen -t rsa
ssh-copy-id 192.168.154.128
ssh-keygen -R 172.16.152.209


### 安装MySQL客户端
rpm -ivh https://repo.mysql.com//mysql57-community-release-el7-11.noarch.rpm
yum install mysql-community-client.x86_64 -y

### 删除容器
docker rm $(docker ps -qf status=exited)

docker rm $(docker ps -qf name=doris*)

### git操作
git branch -r       #查看远程所有分支
git branch           #查看本地所有分支
git branch -a       #查看本地及远程的所有分支
git branch -d 分支名  #删除本地分支

git fetch   #将某个远程主机的更新，全部取回本地：
git rebase origin/master

git checkout 分支 #切换分支：

git push origin -d 分支名  #删除远程分支: 



git remote show origin  #查看远程分支和本地分支的对应关系

git remote prune origin #删除远程已经删除过的分支