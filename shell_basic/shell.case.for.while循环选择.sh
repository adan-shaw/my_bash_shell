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
#1.case 多路选择(相当于c语言里面的switch, 标准posix也可以在case中使用正则表达式)
#
read -p "请输入字符: " user_input 
case "$user_input" in
	1)
		echo "switch 1"
		;;
	2)
		echo "switch 2, cant be a string"
		;;
	3)
		echo "switch 字符 3"
		;;
	"sss")
		echo "匹配sss 字符串"
		;;
	"*adan*")
		echo "通配adan 字符串"
		;;
	*)
		echo "unknow input,exit"
		;;
esac


# 符合正则表达式:(简式)
read -p "Enter a number only or string only here: " user_input
case "$user_input" in
   [0-9]) echo -e "Good job, Your input is a numberic! \n"; ;;
[a-zA-Z]) echo -e "Good job, Your input is a character! \n"; ;;
       *) echo -e "Your input is wrong, input again! \n"; ;;
esac





#
#2.for 循环(倾向于有限循环) -- 一切皆是字符串, 允许重复!!
#
# 字符串-子集 + 随意插入的字符串(打乱测试)
# 字符串之间, 会自动根据' '空格来划分字符串(空格默认是分隔符号)
str="i'm a asshole !!"
for i in "f***you" "f***er" $str
do
	echo $i
done


# bash shell 特有: 字符串数组
if false; then
echo "
	# 数字字符串-数组(数组初始化方式: ()括号 + 空格)
	num_set=(9 99 999 9999 90909)

	# {,} 会被'全部'当成一串字符串
	max={"1","2","3","4"}

	# 用逗号','分割, 会被'全部'当成一个字符串
	maxx="1","2"

	# 数组-字符雷同测试:(允许重复字符串)
	for i in 1 2 3 1 1 1 5 $maxx $max ${num_set[*]}
	do
		echo $i
	done
	# 注意: shell 数据的详细操作方式, 还请参照: shell变量定义(数组).sh
" > /dev/null
fi





#
#3.while循环(倾向于无限循环,一定要在循环外,有控制变量控制循环结束,否则就会成为死循环)
#
tmp="0"
while :
do
	if [ "$tmp" -gt 25 ];then
		break
	else
		tmp=$(($tmp+1))
		echo "$tmp"
	fi
done





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


