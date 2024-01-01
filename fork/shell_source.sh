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


# 注意, 包含一个shell function library 函数库, 并不会创建新的shell子进程.

# source 关键字(bash shell 特有!!)
#source ./shell_func_lib.sh

# posix shell 包含目标shell function library()
. ./shell_func_lib.sh





#
# 测试1: 调用'shell_func1' shell函数, 传入"123"数字字符串
#
# 装载函数执行过程的所有字符回显输出(即echo打印的字符)
echo_return=$(shell_func1 "123")
# 获取最近一次函数执行结果(shell是单线程的, 不用考虑多线程问题, 这个肯定正确的)
func_return=$?
echo -e "shell function 执行过程中的echo/printf 字符打印:\n$echo_return\n"
echo -e "shell_func1 return value(函数return的整形值)：\n$func_return\n"



# 测试失败!! 不能传入非数字的字符串!! 
#######################################################################
#
# 测试2: 调用'shell_func1' shell函数, 传入"damn it"字符串
#
#shell_func1 "damn it" # 失败!!
#shell_func1 "damnit" # 同样失败, 不是空格字符的问题, 是完全不能传入非数字的字符串!!
#func_return=$?
#echo -e "shell_func1 return value(函数return的字符串)：\n$func_return\n"
#######################################################################



#
# 测试3:(新)echo/printf 回显值-返回函数
#
echo_return=$(echo2STDOUT "love you" &)
echo "echo2STDOUT()证明是阻塞的, $echo_return"





# exec 测试: 等待
sleep 1

# exec 测试: 默认返回值, 正常结束
#exit 0

# exec 测试: 异常返回值(-1=255,即返回值最高位=128,负数为反值,8bit最高255,拆分为正负值)
#exit -1

# exec 测试: 异常返回值
exit 1



