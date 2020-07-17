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


#!/bin/bash



# bash shell定义数组变量:
:<<!
	shell 数组, 是bash shell特有;
	posix shell 根本没有数组, 根本不能:
		${arr_num[*]}
		${#arr_str[@]}
		等等复杂操作都不能做.
	因此, posix shell 很难做复杂数组运算的!!

	bash shell数组按照下标的类型可分为两种: 
		1.索引(indexed)数组: 
			下标为0、1、2等'非负整数'. 
		2.关联(associative)数组: 
			下标为'自定义的字符串'. 
!


#1.'索引'数组定义:
declare -a arr_str
declare -a arr_num


# '索引'数组初赋值:
arr_str=("miley" "niki" "jim" "fiona")
echo -e "arr_str 初赋值:\n ${arr_str[*]}"
#arr_str=([7]="xXx" [8]="V")
#echo -e "arr_str 初赋值:\n ${arr_str[*]}"

#arr_num=(1,2,3,4,5,6,7,8) # 错误!! 只能用' '空格间隔元素, 不能用','逗号!!
arr_num=(1 2 3 4 5 6 7 8)
echo -e "arr_num 初赋值:\n ${arr_num[*]}"
#arr_num=([9]=10 [10]=11)
#echo -e "arr_num 初赋值:\n ${arr_num[*]}"


# '索引'数组变量,全数组打印:
echo "全值打印:${arr_str[*]}"
echo "全值打印:${arr_num[*]}"


# '索引'数组变量,遍历组打印:
echo "遍历打印:${arr_str[@]}"
echo "遍历打印:${arr_num[@]}"


# '索引'数组变量,显示下标:
echo "遍历打印下标:${!arr_str[@]}"
echo "遍历打印下标:${!arr_num[@]}"


# '@'符号和'*'符号的索引区别:
echo -e "${arr_num[*]} = \"1 2 3 4 5 6 7 8\" = 一条字符串为整体传入echo"
echo "等价于: tmp=\"1 2 3 4 5 6 7 8\";echo tmp;"

echo -e "${arr_num[@]} = \"1 2 3 4 5 6 7 8\" = 八条字符串单独传入echo"
echo "等价于: echo 1 2 3 4 5 6 7 8;"


# '索引'数组尾部追加元素:
arr_str[${#arr_str[@]}]="adam"
arr_str+=("michel")


# '索引'数组下标'修改/新增/查询'值:
# (3种方法, 数组从下标0开始, 自己注意数组序号, 空位会自动默认为: "" 空字符串;
#  其实'字符串数组','数字数组', 本质上都是'字符串数组-索引数组', 因为shell里面, 没有数字.
#  只有当shell 数组不能通过下标查找时[关联数组],才是特别的.
arr_str[4]="adan shaw"
arr_str[5]="tarlor swift"
arr_str[6]="elon musk"
echo ${arr_str[@]}

arr_num[8]="9"
echo "arr_num[8]=${arr_num[8]}"


# '索引'数组-切片引用(即显示[3,5] 之间的元素):
echo "arr_str[3,5] = ${arr_str[@]:3:5}"
echo "arr_num[3,5] = ${arr_num[@]:3:5}"


# '索引'数组删除元素(只能根据下标来删除):
unset arr_str[0]
unset arr_str[1]
echo ${arr_str[@]}
unset arr_num[0]
unset arr_num[1]
echo ${arr_num[@]}


# '索引'数组, 计算数组的元素个数(只能遍历累加了),用下标遍历性能更优!! 字符串少, 代价少:
# 压缩式:
count=0;for tmp in "${!arr_str[@]}"; do let count=count+1; done
echo "arr_str[] 元素个数: $count";

# 展开式:
count=0;
for tmp in "${!arr_num[@]}";
do
	count=$((count+1));
done
echo "arr_num[] 元素个数: $count";


# 删除整个'索引'数组:
unset arr_str
unset arr_num





#2.'关联'数组定义(太复杂, 略):
declare -A arr_map

arr_map=([name]=zwl [age]=28 [sex]=male)

# 显示所有value(即数组中的值)
echo ${arr_map[@]}
# 显示所有key(即数组中的下标)
echo ${!arr_map[@]}



