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
#1.管道概述:
# 管道 父=>子=>孙 . 孙STDOUT=>父STDIN, 子STDOUT=>孙STDIN
#      ^<<<<<<*   
# 父进程收集'管道语句集'的echo/printf 回显结果
tmp=$(ls -l | grep "target_file")
echo $tmp

# 父进程不收集'管道语句集'的echo/printf 回显结果到字符串变量中,但仍然打印到父进程tty中
ls -l | grep "target_file"

# 父进程不收集'管道语句集'的echo/printf 回显结果, 而且tty 也不收集字符, '&'拉到后台执行.
ls -l | grep "target_file" &



#
#2.反向管道: A(STDIN) <= B(STDOUT)
#
# 父进程收集'管道语句集'的echo/printf 回显结果
tmp=$(ls -l)

# 父进程不收集'管道语句集'的echo/printf 回显结果到字符串变量中,但仍然打印到父进程tty中
ls -l

# 父进程不收集'管道语句集'的echo/printf 回显结果, 而且tty 也不收集字符, '&'拉到后台执行.
ls -l &



#
#3.正向管道: A(STDOUT) => B(STDIN) 
#  {一般用法, 管道后面都是字符串处理工具: awk,grep or sed, 不能用作递归!!}
#  (递归需要改变思路, 别用这么复杂的方法)
#
# 传入什么, 显示什么
triple_echo() {
	echo "$1"
	echo "$1 again"
	return "99"
}

sleep 1
echo -e "\n\n\n"

#显示两行:
#fuck you
#fuck you again
#选中: again 行
echo_return=$(triple_echo "fuck you" | grep "again")
echo "func_return=$?, echo_return=$echo_return"



#
#4.shell 中的'函数递归'调用思维:
#

#4.1 递归执行自己100 次(tmp=传入值$1 版本<-->去除if [ $tmp -lt 100 ] 真的会无限循环.)
recursion() {
	tmp=$(($1+1))
	if [ $tmp -lt 100 ];then
		echo "fuck you $tmp"
		recursion $tmp
	fi
	return $tmp
}
recursion "0"


#4.2 全局变量控制版本(不是一个真正的递归, 而是一个全局变量控制下的循环体):
# 全局变量count
global_count="0"
recursion2() {
	global_count=$(($global_count+1))
	if [ $global_count -lt 100 ]
	then
		echo "fuck you2 $global_count"
		recursion2
	fi
	return $global_count
}
recursion2



sleep 1
echo "fork_pipe.sh end"
exit 0





