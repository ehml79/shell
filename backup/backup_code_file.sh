#!/bin/bash

# vars
# 备份代码文件
start_ctime=$(date +%s)
date=$(date +%F)
ctime=$(date +%H-%M-%S)
backup_code_dir=/data/backup/code
backup_dir=/data/backup/code/${date}/${ctime}
backup_log=/data/logs/backup_code_file.log
keep_day=7

# 减锁，执行脚本
if [ -e ${backup_code_dir} ];then
    chattr -R -i ${backup_code_dir}
fi

# 建立备份目录
if [ ! -e ${backup_dir} ];then
    mkdir -p ${backup_dir}
fi


# 建立备份日志目录
if [ ! -e /data/logs ];then
    mkdir -p /data/logs
fi

# 删除旧备份
function clean_backup(){
    find ${backup_code_dir} -mtime +${keep_day} -exec rm -fr {} \;
}


function backup_code_file(){

    ls /data | while read line
    do
        backup_dirs=$(echo ${line} | grep -v backup | grep -v  save | grep -v service | grep -v sh | grep -v database  | grep -v svn | grep -v logs )
        #echo ${backup_dirs}
        for dir in ${backup_dirs}
        do
            #echo ${dir}
            cd /data &&  tar -czf ${dir}.tar.gz --exclude=*.apk  --exclude=*.log  ${dir}
            mv ${dir}.tar.gz ${backup_dir}
        done
    done
}


echo "$(date '+%F %T %s') ${0} ${@} 清理旧备份" >> ${backup_log}
clean_backup
echo "$(date '+%F %T %s') ${0} ${@} 开始备份" >> ${backup_log}
backup_code_file
end_ctime=$(date +%s)
echo "$(date '+%F %T %s') ${0} ${@} 备份结束 脚本用时:$((${end_ctime}-${start_ctime}))s " >> $backup_log

# 加锁,防误删
chattr -R +i ${backup_code_dir}
