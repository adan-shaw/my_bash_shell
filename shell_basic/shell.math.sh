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
#***1.定义'数字变量'
#
# (shell没有数字,数字变量实际上还是字符串,但你可以让'数字-字符串'进行计算;
#  shell 中不能存在小数点, 没有浮点数!! <除法需谨慎!! 负数可以有!!>)

num1='12345'
num2="23435"

#
# shell 算术运行中带数字和符号测试:
#
# bash shell特有!! bash shell 允许数字计算中, 有字符; 
# posix shell 根本语法层都通过不了, 执行前语法检测时, 直接中断.
:<<!
# 数字计算中, 允许有'字母', 但带字母的变量会被忽略, 算术结果出错!!
num3="-a123A"
# 数字计算中, 不允许有任何'符号', 否则报错!! (可以带'-'负数符号, 唯一可带的符号??)
#num3="a123."
tmp=$((num1+num3));echo "num1=$num1 + num3=$num3 = $tmp(带字母进行算术!!)"
!

#
# posix shell 标准写法!!(注意: 数字不允许有空值""[即:不允许有空字符串])
#
tmp=$((num1+num2))
echo "num1=$num1 + num2=$num2 = $tmp"

tmp=$((num1-num2))
echo "num1=$num1 - num2=$num2 = $tmp"

tmp=$((num1*num2))
echo "num1=$num1 * num2=$num2 = $tmp"

tmp=$((num1/num2))
echo "num1=$num1 / num2=$num2 = $tmp"



#
# bash shell 写法(其实posix shell 也可以用, 但是某些情况下容易出错.):
#
:<<!
# 让'数字-字符串'进行计算(方法1: 单个变量+1,+n 用这种方法)
echo "num1=$num1"
let num1=$num1+5
echo "num1+5=$num1"

echo "num1=$num1"
let num1=$num1-50
echo "num1-50=$num1"

echo "num1=$num1"
let num1=$num1*5
echo "num1*5=$num1"

echo "num1=$num1"
let num1=$num1/25
echo "num1/25=$num1"


# 让'数字-字符串'进行计算(方法2: 两个变量相加用这种方法)
tmp=$[num1+num2]
echo "num1=$num1 + num2=$num2 = $tmp"

tmp=$[num1-num2]
echo "num1=$num1 - num2=$num2 = $tmp"

tmp=$[num1*num2]
echo "num1=$num1 * num2=$num2 = $tmp"

tmp=$[num1/num2]
echo "num1=$num1 / num2=$num2 = $tmp"
!





#
#***2.复杂运算
#
sum="0"


sum=$((sum+=66))
#let sum+=66
echo $sum

#let sum-=55 # 无效, 失败的写法(统一用加法, 没有减法!! 想要减法, 自己加一个负数)
sum=$((sum+=-55))
#let sum+=-55
echo $sum

sum=$((sum*=100))
#let sum*=100
echo $sum

sum=$((sum/=100))
#let sum/=100
echo $sum


# 11/7 = 1, 小数位被自动忽略
sum=$((sum/=7))
#let sum/=7
echo $sum


# 3%2 = 1(求余数正确, 可用)
sum=3
sum=$((sum%2))
#let sum=sum%2
echo $sum


# (求余数正确, 可用2)
sum=8
#sum=7
tmp=$(($sum%2))
#let tmp=sum%2
if [ $tmp -eq "0" ]; then
	echo "num是偶数：$sum"
else
	echo "num是奇数：$sum"
fi






