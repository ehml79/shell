#!/bin/bash

# send or recv

rsync_log=/data/logs/rsync_recv_scripts.log
speed='--bwlimit=5000'
progress='--progress'
#delete='--delete'
ip_list=()

relRsync="rsync -vzrtopg ${delete} ${speed} ${progress}  --password-file=/etc/rsyncd/rsyncd.pass "



start_ctime=$(date +%s)

echo '-------------------------------------------------------------' >> ${rsync_log} 

echo "$(date '+%F %T %s') ${0} ${@} 开始同步" >> ${rsync_log}
echo >> ${rsync_log} 


for remote_ip in ${ip_list[@]}
do
    # recv
    ${relRsync} --exclude="*.git" --exclude="*.svn" --exclude="*.apk" --exclude="*.log" rsync@${remote_ip}::backup  /data/backup/rsync/${remote_ip}  >> ${rsync_log} 2>&1
done



end_ctime=$(date +%s)
echo >> ${rsync_log} 
echo "$(date '+%F %T %s') ${0} ${@} 同步结束 脚本用时:$((${end_ctime}-${start_ctime}))s " >> $rsync_log
