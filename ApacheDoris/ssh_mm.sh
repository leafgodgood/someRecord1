#!/usr/bin/bash
 
# # 安装expect，minimal没有此rpm包，需联网或有本地yum源
# yum install expect -y
# expect << EOF
# set timeout 10

# # 创建公有密钥

spawn ssh-keygen -t rsa
expect {
        "*to save the key" {send "\n";exp_continue}
        "*(y/n)" {send "y\r";exp_continue}
        "Enter passphrase" {send "\n";exp_continue}
        "Enter same passphrase" {send "\n";exp_continue}
}

# EOF

# #  获取/etc/hosts文件中除localhost的映射关系
# ip_list=`grep -v 'localhost' /etc/hosts | awk -F ' ' '{print $1,$2}'`
# for ip in $ip_list
# do
# expect << EOF
#         set timeout 2

#         # 发送公有密钥
#         spawn ssh-copy-id root@$ip
#         expect {
#                 "yes/no" {send "yes\r";exp_continue}
#                 "password" {send "root\r";exp_continue}
#         }

#         # 拷贝/etc/hosts文件到远程机器
#         spawn scp /etc/hosts $ip:/etc
#         expect {
#                 "yes/no" {send "yes\r";exp_continue}
#                 "password" {send "root\r";exp_continue}
#         }
# EOF
# done






cat > ./host_ip.txt << EOF
172.19.0.2 root 123456
172.19.0.3 root 123456
172.19.0.4 root 123456
EOF


#!/usr/bin/bash
[ ! -f /root/.ssh/id_rsa.pub ] && ssh-keygen -t rsa -p '' &>/dev/null  # 密钥对不存在则创建密钥
while read line;do
        ip=`echo $line | cut -d " " -f1`             # 提取文件中的ip
        user_name=`echo $line | cut -d " " -f2`      # 提取文件中的用户名
        pass_word=`echo $line | cut -d " " -f3`      # 提取文件中的密码
expect <<EOF
        spawn ssh-copy-id -i /root/.ssh/id_rsa.pub $user_name@$ip
        expect {
                "yes/no" { send "yes\n";exp_continue}
                "password" { send "$pass_word\n"}
        }
        expect eof
EOF

done < ./host_ip.txt      # 读取存储ip的文件

[root@vinsent app]# cat host_ip.txt 
172.18.14.123 root 123456
172.18.254.54 root 123456


