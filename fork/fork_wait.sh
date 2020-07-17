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


# wait 的用法:
#   wait 是等待任意一个子进程结束的命令, 跟c 语言wait() 一样.
#   你可以使用#? 常量宏, 来获取子进程的结束状态.

#   注意: #? 常量宏, 只是一个宏定义, 获取最近一个函数/子进程的结束return.
#        #? 并不会阻塞.
#        但是wait 却只能等待shell子进程, 不能等待shell函数!!
#        shell 函数调用都是阻塞的.


# posix 的方法, 包含shell 函数库
. ./shell_func_lib.sh



#
#1.wait for function 等待'非阻塞函数'
#
# 执行./shell_func_lib.sh中的nonblocking_demo()测试函数:
nonblocking_demo "987654321" &
wait
# 等待'非阻塞函数', 毫无意义!! 返回值总是为0
echo "nonblocking_demo() return: $?"




#
#2.wait for son process 等待子进程
#
echo -e "\n\n"
ping 127.0.0.1 -c 4 &

# 请注释测试, 两句话只能使用一个
echo "不使用wait, 看到这句话first, 然后才看得到: ping 127.0.0.1 -c 4 & 的结果."

wait
echo "使用wait, 看得到: ping 127.0.0.1 -c 4 & 的结果frist. 然后才看到这句话."

# 第二种'&'子进程表达方法:
comm="ping 127.0.0.1 -c 4"
$comm &
wait





func_test() {
	sleep 1
	echo "func_test() finished"
	return $1
}

# 函数的正确用法(前台):
# 说明: wait 对函数无效, 不能用在函数身上!!
#      shell 执行函数肯定是阻塞的, 如果弹到后台执行函数, 即新建一个子进程去执行该函数.
echo -e "\n\nwait正确用法:(想要获取函数的结果, 只能阻塞等待了, 或者 > tmpfs.)"
func_test "123"
echo "func_test() return: $?(非‘&’后台运行函数, 前台阻塞执行函数, 不使用wait)"





exit 0
#
# 错误的函数用法:
#
#####################################################################错误!!
# wait错误用法1(后台):
func_test "123" &
echo "func_test() return: $?(‘&’ 后台运行函数, 不用wait)"
wait
# 这里会丢失$?, 因为上一个函数, 是命令wait !! 所以这里总是等于0
echo "func_test() return: $?(‘&’ 后台运行函数, 使用wait)"

# wait错误用法2(后台):
func_test "123" &
wait
echo "func_test() return: $?(‘&’ 后台运行函数, 使用wait)"

# wait错误用法3(前台):
func_test "123"
wait
echo "func_test() return: $?(非‘&’后台运行函数, 前台阻塞执行函数, 使用wait)"
#####################################################################错误!!





echo "fork_wait.sh finish"





