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
# 本函数库约定:
#
#1.lib_API函数: 返回值约定
:<<!
	但凡返回的结果, 只有'布尔郎值', 那么都用return 返回; 
	其它都用echo ""返回结果.
	因为'布尔郎值'只能是[0-255]之间的数字, 比较局限,
	但是echo "" 可以返回'较长的数字'和'任意字符串'结果!!
!
#2.lib_API函数: 参数检查->{出错,不用过}
:<<!
	对于复杂函数输入, 通常伴随着参数正确性检查.
	这时候, 判断函数是否正常运行, 需要做先做判断:
		tmp=$ (lib_API函数)
		if[ $? = $RETURN_TRUE ];then
			echo "结果: $tmp"
		fi
!


#
# 本函数库约定宏:
#
#布尔郎值
#(为什么以'0'为正确函数返回?? 因为posix shell return 关键字, 只能返回数字!!
# 第二个原因是: 子进程结束状态='0'表示正常结束, 为了对齐, 统一'0'表示true, '1'=false)
RETURN_TRUE="0"
RETURN_FLASE="1"
EXIT_OK="0"
EXIT_FAIL="1"
#本shell库的名称
MY_SHELL_FUNC_LIB_FILENAME="my_shell_func_lib.sh"





#1.检查是不是root 用户:
user_root_check() {
	tmp=$(whoami)
	#tmp=$USER
	#tmp=$UID
	if [ $tmp = "root" ];then
		return $RETURN_TRUE
	else
		return $RETURN_FLASE
	fi
}


#2.求字符串长度:
get_str_len() {
	if [ $# != "1" ];then return $RETURN_FLASE; fi
	if [ -z "$1" ];then return $RETURN_FLASE; fi

	#echo "$#-${#1}"# for test
	echo "${#1}"
	return $RETURN_TRUE
}


#3.获取当前所在的路径PATH:
get_working_path() {
	echo $(pwd)
	return $RETURN_TRUE
}


#4.获取本shell库的名称:
get_my_shell_func_lib_name() {
	echo $MY_SHELL_FUNC_LIB_FILENAME
	return $RETURN_TRUE
}


#5.输入密码[6-16]个字符(bash shell):
input_password() {
	read -p "please input your password(english text of {[a,z][A,Z][0,9]\"_\"} only!!): " -t 15 -s tmp
	#echo $tmp #for test
	# 非空检测
	if [ -z $tmp ];then
		return $RETURN_FLASE
	fi
	# 密码长度检测
	len=${#tmp}
	if [[ $len -lt "6" || $len -gt "16" ]];then
		return $RETURN_FLASE
	fi
	# 正则表达式: 检查杂乱字符(只允许一个特殊字符:下划线)
	my_regex="^\w+$"
	if [[ $tmp =~ $my_regex ]];then
		echo $tmp
		return $RETURN_TRUE
	else
		return $RETURN_FLASE
	fi
}


#6.输入账户名[4-16]个字符(bash shell):
input_account() {
	read -p "please input your account(english text of {[a,z][A,Z][0,9]\"_\"} only!!): " -t 15 tmp
	# 非空检测
	if [ -z $tmp ];then
		return $RETURN_FLASE
	fi
	# 密码长度检测
	len=${#tmp}
	if [[ $len -lt "4" || $len -gt "16" ]];then
		return $RETURN_FLASE
	fi
	# 正则表达式: 检查杂乱字符(只允许一个特殊字符:下划线)
	my_regex="^\w+$"
	if [[ $tmp =~ $my_regex ]];then
		echo $tmp
		return $RETURN_TRUE
	else
		return $RETURN_FLASE
	fi
}


#7.输入6位数字密码(bash shell):
input_6password() {
	read -p "please input your password(only 6 numbers): " -n 6 -t 15 -s tmp
	# 非空检测
	if [ -z $tmp ];then
		return $RETURN_FLASE
	fi
	# 密码长度检测
	len=${#tmp}
	if [[ $len != "6" ]];then
		return $RETURN_FLASE
	fi
	# 正则表达式: 检查杂乱字符(只允许一个特殊字符:下划线)
	my_regex="[0-9]{6}"
	if [[ $tmp =~ $my_regex ]];then
		echo $tmp
		return $RETURN_TRUE
	else
		return $RETURN_FLASE
	fi
}


#8.显示系统基础信息:
:<<!
这个j脚本有 6 部分, 细节如下：
1. 通用系统信息
2. CPU/内存当前使用情况
3. 硬盘使用率超过 80%
4. 列出系统 WWN 详情
5. Oracle DB 实例
6. 已经安装的包的数量统计
!
show_system_info() {
	echo -e "-------------------------------System Information----------------------------"
	echo -e "Hostname:\t\t"`hostname`
	echo -e "uptime:\t\t\t"`uptime | awk '{print $3,$4}' | sed 's/,//'`
	echo -e "Manufacturer:\t\t"`cat /sys/class/dmi/id/chassis_vendor`
	echo -e "Product Name:\t\t"`cat /sys/class/dmi/id/product_name`
	echo -e "Version:\t\t"`cat /sys/class/dmi/id/product_version`
	echo -e "Serial Number:\t\t"`cat /sys/class/dmi/id/product_serial`
	echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi`
	echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
	echo -e "Kernel:\t\t\t"`uname -r`
	echo -e "Architecture:\t\t"`arch`
	echo -e "Processor Name:\t\t"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'`
	echo -e "Active User:\t\t"`w | cut -d ' ' -f1 | grep -v USER | xargs -n1`
	echo -e "System Main IP:\t\t"`hostname -I`
	echo ""
	echo -e "-------------------------------CPU/Memory Usage------------------------------"
	free
	tmp=$(free -t | awk '/Mem/{printf("%.2f"), $3/$2*100}')
	echo -e "Memory Usage:\t"$tmp"%"
	tmp=$(free t- | awk '/Swap/{printf("%.2f"), $3/$2*100}')
	echo -e "Swap Usage:\t"$tmp"%"
	tmp=$(cat /proc/stat | awk '/cpu/{printf("%.2f\n"),($2+$4)*100/($2+$4+$5)}' | awk '{print $0}' | head -1)
	echo -e "CPU Usage:\t"$tmp"%"
	echo ""
	echo -e "-------------------------------Disk Usage >80%-------------------------------"
	df -Ph | sed s/%//g | awk '{ if($5 > 80) print $0;}'
	echo ""
	echo -e "-------------------------------For WWN Details-------------------------------"
	vserver=$(lscpu | grep Hypervisor | wc -l)
	if [ $vserver -gt 0 ]
	then
		echo "$(hostname) is a VM"
	else
		#cat /sys/class/fc_host/host?/port_name
		echo "$(hostname) is a real machine"
		lspci -n
	fi
	echo ""
	echo -e "-------------------------------Oracle DB Instances---------------------------"
	if id oracle >/dev/null 2>&1; then
		/bin/ps -ef|grep pmon
	else
		echo "oracle user does not exist on $(hostname)"
	fi
	echo ""
	echo -e "-------------------------------Package Installed Count-----------------------"
	if (( $(cat /etc/*-release | grep -w "Debian" | wc -l) > 0 ))
	then
		tmp=$(cat /var/lib/apt/extended_states | wc -l)
		echo "installed packages: $tmp"
		echo "details: cat /var/lib/apt/extended_states"
	fi
	if (( $(cat /etc/*-release | grep -w "Ubuntu" | wc -l) > 0 ))
	then
		tmp=$(cat /var/lib/apt/extended_states | wc -l)
		echo "installed packages: $tmp"
		echo "details: cat /var/lib/apt/extended_states"
	fi
	echo -e "-----------------------------------------------------------------------------"
	return $RETURN_TRUE
}


# 慎用 #
#9.逐行读取一个文件, 然后逐行打印tty(你可以修改简单的逐行打印为: 你想要的字符串处理逻辑)
:<<!
	用shell 字符串变量, 需要慎重!! shell 字符串变量很弱, 装载文本内容, 不安全!! 
	如果shell 变量不能满足需求, 你可以将字符数据读入到tmpfs ??
	这样还不如直接cp 文件到tmpfs!!
	如果shell 变量不能满足需求, 只能逐行处理, 逐行分析了.
!
print_file2tty() {
	# 文件路径的合法性
	if [[ $# != "1" || -z "$1" ]];then
		return $RETURN_FLASE
	fi
	# 存在且可读时, 才读取
	if [[ -e "$1" && -r "$1" ]];then
		while read line; do
			echo $line
		done < "$1"
		return $RETURN_TRUE
	else
		echo "file does not exist or this user has no read authority"
		return $RETURN_FLASE
	fi
}


# 慎用 #
#10.逐行读取一个文件, 逐行添加一个前置字符串"# ",(你可以实现对任意text文件,进行逐行加'前置字符')
:<<!
	再打印到tty, 最后逐行保存到一个新的文件中(源文件名.new)
	参数说明:
		$1 = source file path(源数据文件,最好给绝对路径or "./这样的相对路径",这个文件不被修改)
		$2 = prefix string(要添加的'前缀字符串')
	注意: 
		为了区分真正备注, 和普通备注的关系, 这里的自动添加备注, 自动去除备注. 多用空格!
		例如:
			"#_#"
			"//_/"
!
add_prefix2file() {
	# 文件路径的合法性
	if [[ $# != "2" || -z "$1" || -z "$2" ]];then
		return $RETURN_FLASE
	fi
	# 存在且可读时, 才读取
	tmp="$1.new"
	echo "$2" > $tmp;
	if [[ -e "$1" && -r "$1" && -e $tmp && -w $tmp ]];then
		while read line; do
			# 加'前缀字符串'后, 追加写入新的文件中
			echo "$2$line" >> $tmp
		done < "$1"
		return $RETURN_TRUE
	else
		echo "source file not exist or this user has no read authority"
		echo "or target file cant be create!! no authority"
		return $RETURN_FLASE
	fi
}


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
del_prefix2file() {
	# 文件路径的合法性
	if [[ $# != "2" || -z "$1" || -z "$2" ]];then
		return $RETURN_FLASE
	fi
	# 存在且可读时, 才读取
	tmp="$1.new"
	echo "" > $tmp;
	if [[ -e "$1" && -r "$1" && -e $tmp && -w $tmp ]];then
		while read line; do
			if [[ "$line" =~ "$2" ]];then
				# 删减所有类似的'前缀字符串'
				line=${line/$2/}
				# 减'前缀字符串'后, 追加写入新的文件中
				echo "$line" >> $tmp
			fi
		done < "$1"
		return $RETURN_TRUE
	else
		echo "source file not exist or this user has no read authority"
		echo "or target file cant be create!! no authority"
		return $RETURN_FLASE
	fi
}


# 12.查看自己支持那种shell
#    原理: 利用/bin/sh posix 标准shell 的通用性, 
#         用低级/bin/sh shell, 询问系统是否支持/bin/bash shell

# 这个函数库, 也要区分sh shell 和bash shell 了, 尽量sh shell 吧!!
# 把没啥用的shell 踢入bash shell 库, 把常用的加入到sh shell 中.


