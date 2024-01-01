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


# 包含my shell function library()
. ./my_shell_func_lib.sh





#1.检查是不是root 用户
:<<!
tmp=$(user_root_check)
if [ $? = $RETURN_TRUE ];then
	echo "user_root_check() ok: YES"
else
	echo "user_root_check() fail: NO"
fi
!


#2.获取字符串的长度
:<<!
tmp=$(get_str_len "love you bitch")
if [ $? = $RETURN_TRUE ];then
	echo "get_str_len() ok: $tmp"
else
	echo "get_str_len() fail: $tmp"
fi
!


#3.获取当前所在的路径PATH
:<<!
tmp=$(get_working_path)
if [ $? = $RETURN_TRUE ];then
	echo "get_working_path() ok: $tmp"
else
	echo "get_working_path() fail: $tmp"
fi
!


#4.获取本shell库的名称
:<<!
tmp=$(get_my_shell_func_lib_name)
if [ $? = $RETURN_TRUE ];then
	echo "get_my_shell_func_lib_name() ok: $tmp"
else
	echo "get_my_shell_func_lib_name() fail: $tmp"
fi
!


#5.输入密码[6-16]个字符(bash shell)
:<<!
tmp=$ (input_password)
if [ $? = $RETURN_TRUE ];then
	echo "input_password() ok: $tmp"
else
	echo "input_password() fail: $tmp"
fi
!


#6.输入账户名[4-16]个字符(bash shell)
:<<!
tmp=$ (input_account)
if [ $? = $RETURN_TRUE ];then
	echo "input_account() ok: $tmp"
else
	echo "input_account() fail: $tmp"
fi
!


#7.输入6位数字密码(bash shell)
:<<!
tmp=$ (input_6password)
if [ $? = $RETURN_TRUE ];then
	echo "input_6password() ok: $tmp"
else
	echo "input_6password() fail: $tmp"
fi
!


#8.显示系统基础信息
:<<!
show_system_info;
!


# 慎用 #
#9.逐行读取一个文件, 然后逐行打印tty(你可以修改简单的逐行打印为: 你想要的字符串处理逻辑)
:<<!
	用shell 字符串变量, 需要慎重!! shell 字符串变量很弱, 装载文本内容, 不安全!! 
	如果shell 变量不能满足需求, 你可以将字符数据读入到tmpfs ??
	这样还不如直接cp 文件到tmpfs!!
	如果shell 变量不能满足需求, 只能逐行处理, 逐行分析了.
!
:<<!
tmp=$ (print_file2tty "./test.home/test.txt")
if [ $? = $RETURN_TRUE ];then
	echo "print_file2tty() ok"
else
	echo "print_file2tty() fail"
fi
!


# 慎用 #
#10.逐行读取一个文件, 逐行添加一个前置字符串"# ",(你可以实现对任意text文件,进行逐行加'前置字符')
:<<!
	再打印到tty, 最后逐行保存到一个新的文件中(源文件名.new)
	参数说明:
		$1 = source file path(源数据文件,最好给绝对路径or "./这样的相对路径",这个文件不被修改)
		$2 = prefix string(要添加的'前缀字符串')
!
:<<!
add_prefix2file "./test.home/test.txt" '// ';
if [ $? = $RETURN_TRUE ];then
	echo "add_prefix2file() ok"
else
	echo "add_prefix2file() fail"
fi
!


# 慎用 #
#11.逐行读取一个文件, 逐行去除一个前置字符串"# ",(你可以实现对任意text文件,进行逐行去除'前置字符')
#   再打印到tty, 最后逐行保存到一个新的文件中(源文件名.new)
:<<!
	del_prefix2file() 原理:
		匹配中'前缀字符串', 执行删除全部匹配字符串! 然后回写到新文件.
		由于没有差别删除, 可能会删掉后面的备注, 所以'前缀字符串', 尽量需要像下面那样特别一点!!
	注意: 
		为了区分真正备注, 和普通备注的关系, 这里的自动添加备注, 自动去除备注. 多用空格!!
		"#_#"
		"//_/"
!
:<<!
del_prefix2file "./test.home/test.txt.new" '// ';
if [ $? = $RETURN_TRUE ];then
	echo "del_prefix2file() ok"
else
	echo "del_prefix2file() fail"
fi
!


