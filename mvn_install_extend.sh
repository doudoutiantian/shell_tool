#!/bin/bash
#主要是为了解决mvn本地打包后，mvn本地仓库留有太多的jar，占用太多的本地磁盘

#mvn对应的本地库根目录
mvn_home='/Users/tanzhenhua/.m2/repository'
#获取当前maven项目的项目名称
cur_dir=`pwd|awk -F'/' '{print $NF}'`

#mvn本地库中的项目路径
snap_dir=`find $mvn_home -name "$cur_dir"`
echo 'mvn路径:'$snap_dir

#按照更新时间倒排,保留最新更新的2个snapshot
ls -dt $snap_dir/*/|tail -n +3|awk '{print $NF}'|xargs rm -rf

#执行mvn install命令
mvn clean install -U -DskipTests
