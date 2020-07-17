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
# 0.linux shell下常用输入输出操作符是：
#
:<<!
1. 标准输入(stdin) ：
	 代码为 0 , 使用 < 或 << ;
	 /dev/stdin -> /proc/self/fd/0 
	 0代表：/dev/stdin

2. 标准输出(stdout)：
	 代码为 1 , 使用 > 或 >> ; 
	 /dev/stdout -> /proc/self/fd/1	
	 1代表：/dev/stdout

3. 标准错误输出(stderr)：
	 代码为 2 , 使用 2> 或 2>> ; 
	 /dev/stderr -> /proc/self/fd/2 
	 2代表：/dev/stderr
!


#
# 1.询问用户是否确定?
#
# posix shell 不支持read 有过多参数!!
read -r -p "are you sure? [Y/N] " tmp
case "$tmp" in
	[yY][eE][sS]|[yY])
		echo "Yes"
		;;
	[nN][oO]|[nN])
		echo "No"
		exit 1
		;;
	*)
		echo "invalid input..."
		exit 1
		;;
esac





#
# bash shell 特有!!
#

#
#2.read, 从console 终端输入密码
#
read -p "请输入密码: " -n 6 -t 15 -s password
# -p 输入提示文字
# -n 输入字符长度限制(超出6位, 自动结束输入)
# -t 输入限时15s
# -s 隐藏输入内容
#
echo -e "\n你刚才输入的密码是: $password"



#
#3.read, 从console 终端输入密码.(限制, 不能输入'非法字符'!!)
#
# 用正则表达式进行字符筛选:
# 注意: 
#   正则表达式在if [[ ]]中, 必须以'字符串变量'的方式存在, 不能直接"^\w+$"这么粗暴！
#   if 也必须用拓展模式[[ ]], [] 低级模式, 不能拓展正则表达式.
#   bash3 以下的版本, 也不支持if [[ ]]拓展模式.

# 筛选A-Z, 检索前2 个字符, 后续字符随意
regex="[A-Z]{2}"

# 筛选[0-9]的数字, 选6个, 后续的字符随意.(需要配合: read -n 6 才能选出全部是数字)
regex2="[0-9]{6}"

# 筛选电话号码(需要配合: read -n 11 才能选出全部是数字)
regex3="[0-9]{11}"

# 筛选连用: 只允许英文字母和数字
regex4="[0-9,A-Z,a-z]"

# 复杂正则表达式: 只允许{英文字母,数字,"_"}
regex5="^\w+$"


read -p "筛选A-Z, 检索前2 个字符, 后续字符随意: " tmp
if [[ "$tmp" =~ "$regex" ]];then
	echo "ok: $tmp"
else	
	echo "1 Invalid entry"
fi


read -n 6 -t 15 -s -p "筛选[0-9]的数字, 选6个, 后续的字符随意: " tmp
if [[ "$tmp" =~ "$regex2" ]]
then	
	echo "ok: $tmp"
else	
	echo "2 Invalid entry"
fi


read -n 11 -t 30 -s -p "筛选[0-9]的数字, 选11个, 后续的字符随意: " tmp
if [[ "$tmp" =~ "$regex3" ]]
then	
	echo "ok: $tmp"
else	
	echo "3 Invalid entry"
fi


read -p "筛选连用: 只允许英文字母和数字: " tmp
if [[ "$tmp" =~ "$regex4" ]]
then	
	echo "ok: $tmp"
else	
	echo "4 Invalid entry"
fi


read -p "复杂正则表达式: 只允许{英文字母,数字,"_"}: " tmp
if [[ "$tmp" =~ "$regex5" ]]
then	
	echo "ok: $tmp"
else	
	echo "5 Invalid entry"
fi

