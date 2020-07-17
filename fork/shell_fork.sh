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

#
# shell 多进程编码详解:
#
# shell有2种创建子进程的方式(exec or 直接执行shell命令),1种包含shell函数库的方式(source)
# 其中包含shell函数库的方式, 略, 自己看shell_source.sh
# 这里主要谈exec and 直接执行shell命令(相当于fork), 这两种创建shell子进程的方式.


# exec 创建子进程, 执行一个新的shell.sh 程序的方式, 请查看shell_exec.sh
# 这里主要谈论shell 如何fork 子进程.


#
# 1.正常执行, 会自动阻塞'当前父进程', 在这种模式下, 显得傻逼！！
#
# 什么是‘直接执行shell命令(相当于fork)’ 的方式??
# 正确写法1:
echo_return=$(ping 127.0.0.1 -c 4)
# 正确写法2:
echo_return=$(ping "127.0.0.1" -c 4)
# 错误写法:
#echo_return=$(ping "127.0.0.1 -c 4") # 错误写法!! 参数也不能完全字符串化!! 命令参数也不是字符串
#echo_return=$("ping 127.0.0.0 -c 4") # 错误写法!! 不能执行一段字符串!! 命令不是字符串
func_return=$?


echo $echo_return
echo -e "直接执行shell命令1 return:\n$func_return"


# 直接执行, 不装载echo_return, 所有echo/printf 都会直接打印到'当前父进程'的tty 中
echo -e "\n\n"
ping 127.0.0.1 -c 4
func_return=$?
echo -e "直接执行shell命令2 return:\n$func_return"



#
# 2.非阻塞!! 后台执行!!
#
# 误区!! 只要你echo_return=$(子进程语句), 这样父进程就会阻塞!! 
# 从而等待‘子进程的所有echo/printf回显输出’, 因此这样做肯定是阻塞的!!
# 想要非阻塞, 应该不能: echo_return=$(子进程语句)
# 而是要直接: $(子进程语句) > $tmpfs, 将结果全部打印到tmpfs 内存分区上(保存到tmpfs上的文件)
# 然后再分析'tmpfs上的文件'的echo/printf回显结果.
#
# (错误的非阻塞方法, 这里只是屏蔽了echo/printf 回显结果而已!!)
echo_return=$(ping 127.0.0.1 -c 4 &)
func_return=$?

echo $echo_return
echo -e "直接执行shell命令1 return:\n$func_return"

# 误区2:
# 注意: $() > /dev/null; 只能消灭‘echo/printf回显’, 不能非阻塞执行shell子进程!!
#      想要非阻塞, 必须使用 & , 而且还不能用变量'接住'echo/printf回显!!
echo "非阻塞-误区2"
ping 127.0.0.88 -c 4 > /dev/null
ping 127.88.0.0 -c 4 > /dev/null
echo "非阻塞-误区2-end"
##################################################


# 2.1: 非阻塞-shell子进程执行方法1:
echo "非阻塞-shell子进程执行方法1"
ping 192.168.5.1 -c 4 &
ping 192.168.5.4 -c 4 &
echo "非阻塞-shell子进程执行方法1-end"

#wait
echo -e "如果此处不wait, 就会直接结束父进程,
子进程ping 需要一定时间才会结束, 因此子进程肯定会成为孤儿进程!!
但子进程ping 仍然会将输出的字符打印到'未关闭的tty'上面!!
因此, 你可以看到这句话first, 后面才是:ping 192.168.5.1 -c 4 & 的结果!!
其实此时, 子进程ping 已经成为孤儿进程了!!
"


# 2.2: 非阻塞-shell子进程执行方法2:
shell_son_comm="ping 127.0.66.0 -c 4"
echo "非阻塞-shell子进程执行方法2"
$shell_son_comm & > /dev/null
$shell_son_comm & > /dev/null
echo "非阻塞-shell子进程执行方法2-end"


# 2.3: 非阻塞-shell子进程执行方法3:
echo "非阻塞-shell子进程执行方法3"
ping 127.0.44.0 -c 4 & > /dev/null
ping 127.0.44.0 -c 4 & > /dev/null
echo "非阻塞-shell子进程执行方法3-end"


echo "shell_fork.sh 结束"
exit 0



