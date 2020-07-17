# , , , , ,,, , , , ,,, ,,, , , ,  , , , ,, ,  , , ,, , , , , , ,, , ,, ,, ,
# text rules simple version for public:
# !_1.'行-字符长度'测试(how many char in one line):
# 1111111111111111111111111111111111111111111111111111111111111111111111111
# 邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵邵
# *************************************************************************
# !_2.标题命名规则(headline named rules):
# 		!_1.xxx:	'level 1' headline
# 		!_2.xxx:	'level 1' headline
# 		!_3.xxx:	'level 1' headline
# 			@_2.xxx:	'level 2' headline
# 				#_3.xxx:	'level 3' headline
# !_3.统一使用english US(英文)的标点符号, 作为编码统一标点字符.
# !_4.文件更改日志(file changed log):
# 		...
# , , , , ,,, , , , ,,, ,,, , , ,  , , , ,, ,  , , ,, , , , , , ,, , ,, ,, ,

#!/bin/sh
#set -x

#
# 未整理!!
#


# 测试3(命名管道fifo 测试, 有些复杂, 可以先不要搞, 没时间的话):
echo "test 3 start"
# sub process do something
function a_sub_process { 
  echo "processing in pid [$$]"
  sleep 1
}


# 创建一个fifo文件
FIFO_FILE=./$.fifo
mkfifo $FIFO_FILE

# 关联'fifo文件'和fd6
exec 6<>$FIFO_FILE # 将fd6指向fifo类型
rm $FIFO_FILE


PROCESS_NUM=4 # 最大进程数
# 向'fd6'中输入'$PROCESS_NUM'个字符串'fuck'
for ((idx=0;idx<$PROCESS_NUM;idx++));
do
  echo "fuck"
done >&6 


# 处理业务, 可以使用while
for ((idx=0;idx<20;idx++));
do
  read -u6  # read -u6 命令执行一次, 相当于尝试从fd6中获取一行, 
            # 如果获取不到, 则阻塞.
  {
    # 获取到了一行后, fd6就少了一行了, 开始处理子进程, 子进程放在后台执行
    a_sub_process && { 
       echo "sub_process is finished"
    } || {
       echo "sub error"
    }
    # 完成后再补充一个回车到fd6中, 释放一个锁
    echo >&6 # 当进程结束以后, 再向fd6中加上一个回车符, 即补上了read -u6减去的那个
  } &
done


# 关闭fd6
exec 6>&-

echo "test 3 end"
