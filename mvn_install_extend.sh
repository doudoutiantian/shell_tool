#!/bin/bash
exec_dir="$1"

if [ -z "$exec_dir" ];then
exec_dir=`pwd`
fi
echo "执行路径:"$exec_dir


#判断执行路径是否是mvn项目
if [ ! -e "$exec_dir/pom.xml" ]; then
    echo "执行路径($exec_dir)为非maven项目"
    exit
fi

#mvn对应的本地库根目录
mvn_home='/Users/tanzhenhua/.m2/repository'
#获取当前maven项目的项目名称
cur_dir=`echo $exec_dir|awk -F'/' '{print $NF}'`

#mvn本地库中的项目路径
snap_dir=`find $mvn_home -name "$cur_dir"`
echo 'mvn路径:'$snap_dir

#按照更新时间倒排,保留最新更新的2个snapshot
ls -dt $snap_dir/*/|tail -n +3|awk '{print $NF}'|xargs rm -rf

#执行mvn install命令
mvn clean install -U -DskipTests
