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

# exec 用法:
# exec 是启动一个新的shell子进程, 不能用来包含shell function library 函数库

# exec 返回值:
# 所以, 其实很简单, 你想要新建一个子进程, 去执行一个shell 任务, 可以用exec.
# 但你不能获取其执行结果？
# 可以获取其$echo_return 回显结果, 
# 但是起执行结果return 是没有什么意义!! 只是shell 子进程的结束状态, 是否正常结束.
# exit 1 就是异常退出

# exec 与 wait, 等待结束:
# 但可以等其结束, exec 创建出来的, 同样是子进程.
# wait 同样有效

echo_return=$(exec ./shell_source.sh)
func_return=$?
wait
echo $echo_return
echo -e "exec ./shell_source.sh return:\n$func_return"


# exec 测试: 默认返回值, 正常结束
#exit 0

# exec 测试: 异常返回值(-1=255,即返回值最高位=128,负数为反值,8bit最高255,拆分为正负值)
#exit -1

# exec 测试: 异常返回值
exit 1



