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
#1.shell 里面的if 机制简介:
#
if false; then
echo "
	(基础版)-[]和test: {# !/bin/sh 标准posix 中特有}
		两者是一样的, 在命令行里 test 'expr表达式' 和 [ 'expr表达式' ] 的效果相同. 
		test的三个基本作用是判断文件、判断字符串、判断整数. 
		支持使用"与,或,非"将表达式连接起来. 

		test中可用的比较运算符只有==和!=, 
		两者都是用于字符串比较的, 不可用于整数比较, 整数比较只能使用-eq, -gt这种形式. 

		无论是字符串比较还是整数比较都千万不要使用大于号小于号. 
		当然, 如果你实在想用也是可以的, 
		对于字符串比较可以使用尖括号的转义形式, 
		如果比较"ab"和"bc": [ ab \< bc ], 结果为真, 也就是返回状态为0.


	(拓展版)-[[ ]]: {# !/bin/bash 'bash shell' 中特有}
		这是内置在shell中的一个命令, 它就比刚才说的test强大的多了. 
		支持字符串的模式匹配(使用=~操作符时甚至支持shell的正则表达式).

		逻辑组合可以不使用test的-a,-o而使用 && || 等C语言常用的"与或非"符号.

		字符串比较时可以把'右边的表达式'作为一个模式(这是右边的字符串不加双引号的情况下.
		如果右边的字符串加了双引号, 则认为是一个文本字符串.), 
		而不仅仅是一个字符串, 比如[[ hello == hell? ]], 结果为真. 

		注意: 
			使用[]和[[]]的时候不要吝啬空格, 
			每一项两边都要有空格, 因为例如:
			[[ 1 == 2 ]]的结果为“假”, 但[[ 1==2 ]]的结果为“真”！


	赋值符号:
	'=' 就是赋值运算.
	':='就是当冒号前面的变量不存在或值为空时, 就把等号后的值赋值给变量.
	'+='这个应该不用解释吧, 和C中一样, 变量等于本身和另一个变量的和.
" > /dev/null
fi





#
# (基础版)字符串比较:
#
:<<!
<判断单个字符串是否为空>
	-z string ;如果string长度为零, 则为真[ -z "$str" ]
	-n string ;如果string长度非零, 则为真[ -n "$str" ]

<判断两个字符串是否相等>
	string1 = string2 ;如果string1与string2相同, 则为真[ "$str" = "one two" ]
	string1 != string2 ;如果string1与string2不同, 则为真[ "$str" != "one two" ]

注意:
	每个变量都需要加双引号!! 不能裸奔:
		if [ -z $string4 ]; then 错!!
		if [ $string1 = $string2 ]; then 错!!
		这种直接在if[] or if[[]] 中, 不加双引号的比较, 都是极度容易出错的!!
		不要偷懒, 不打双引号!!

注意2:
	等于逻辑, 尽量不要用'==', 而使用'='
	'=='双等号很有问题, shell 里面的等于, 只有一个'='等于号.

!
string1="oh fuck"
string2="oh fuck"
string3="are you kidding ?"
string4=""
if [ -z "$string4" ]; then
	echo "string4 is empty"
fi

if [ -n "$string1" ]; then
	echo "string1 is not empty"
fi

if [ "$string1" = "$string2" ]; then
	echo "string1 = string2"
fi
# '=='双等于号, 禁用！！(问题多多！！)
:<<!
if [ "xxx" == "xxx" ]; then
	echo "$string1 == $string2"
else
	echo "string1 != string2"
fi
!
if [ "$string1" != "$string3" ]; then
	echo "string1 != string3"
fi



#
# (基础版)数字比较:
#
:<<!
num1 -eq num2  等于 [ 3 -eq $num ]
num1 -ne num2  不等于 [ 3 -ne $num ]
num1 -lt num2  小于 [ 3 -lt $num ]
num1 -le num2  小于或等于 [ 3 -le $num ]
num1 -gt num2  大于 [ 3 -gt $v ]
num1 -ge num2  大于或等于 [ 3 -ge $num ]
!
num="3"
if [ "3" -eq "$num" ]; then echo "3 -eq $num"; fi
if [ "3" -ne "$num" ]; then echo "3 -ne $num"; fi
if [ "3" -lt "$num" ]; then echo "3 -lt $num"; fi
if [ "3" -le "$num" ]; then echo "3 -le $num"; fi
if [ "3" -gt "$num" ]; then echo "3 -gt $num"; fi

if [ "3" -ge "$num" ]; then
	echo "3 -ge $num"
fi

tmp=$(($num % 2))
if [ "$tmp" -eq "0" ]; then
	echo "num是偶数：$num"
else
	echo "num是奇数：$num"
fi



#
# (基础版)文件比较:
#
:<<!
-e filename  如果filename存在, 则为真[ -e /home/adan/file ]
-d filename  如果filename为目录, 则为真[ -d /home/adan/folder ]
-f filename  如果filename为常规文件, 则为真[ -f /home/adan/file ]
-L filename  如果filename为符号链接, 则为真[ -L /home/adan/link ]
-r filename  如果filename可读, 则为真[ -r /home/adan/file ]
-w filename  如果filename可写, 则为真[ -w /home/adan/file ]
-x filename  如果filename可执行, 则为真[ -L /home/adan/file ]

filename1 -nt filename2  如果filename1比filename2新, 
                         则为真[ ./file -nt /home/adan/file ]
filename1 -ot filename2  如果filename1比filename2旧, 
                         则为真[ ./file - ot /home/adan/file ]
!
if [ -e "/home/adan/file" ]; then echo "文件存在"; fi
if [ -d "/home/adan/folder" ]; then echo "文件夹存在"; fi
if [ -f "/home/adan/file" ]; then echo "常规文件存在"; fi
if [ -L "/home/adan/link" ]; then echo "符号链接存在"; fi
if [ -r "/home/adan/file" ]; then echo "文件可读"; fi
if [ -w "/home/adan/file" ]; then echo "文件可写"; fi
if [ -x "/home/adan/file" ]; then echo "文件可执行"; fi

if [ "./file" -nt "/home/adan/file" ]; then
	echo "当前./file文件 比/home/adan/file目标文件新, 可执行更新操作."
fi

if [ "./file" -ot "/home/adan/file" ]; then
	echo "当前./file文件 比/home/adan/file目标文件旧, 不需要执行更新操作."
fi

# '如果文件不存在'版本
if [ ! -e "/home/adan/file" ]; then
	echo "cant find this file"
fi



#
# 与或非
#
# 非[ ! ]
if ! false;then
	echo "hello 非"
fi

# 与[ -a ] -- and
if [ true -a true ];then
	echo "hello 与"
fi

# 或[ -o ] -- or
if [ true -o false ];then
	echo "hello 或1"
fi
if [ false -o true ];then
	echo "hello 或2"
fi


######################以上都是"#!/bin/sh"通用posix shell 标准#################





#!/bin/bash
#
#if 拓展版(正则表达式, 不懂可以查表, #!/bin/bash 才可以用):
#

# 注意: 正则表达式变量, 不要再用""双引号'括起来'了!! 
#      反而字符串变量, 可以再用""双引号'括起来'.

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
if [[ "$tmp" =~ $regex ]]; then
	echo "ok: $tmp"
else	
	echo "1 Invalid entry"
fi


read -p "筛选[0-9]的数字, 选6个, 后续的字符随意: " -n 6 -t 15 tmp
if [[ "$tmp" =~ $regex2 ]]; then
	echo "ok: $tmp"
else	
	echo "2 Invalid entry"
fi


read -p "筛选[0-9]的数字, 选11个, 后续的字符随意: " -n 11 -t 30 tmp
if [[ "$tmp" =~ $regex3 ]]; then
	echo "ok: $tmp"
else	
	echo "3 Invalid entry"
fi


read -p "筛选连用: 只允许英文字母和数字: " tmp
if [[ "$tmp" =~ $regex4 ]]; then
	echo "ok: $tmp"
else	
	echo "4 Invalid entry"
fi


read -p "复杂正则表达式: 只允许{英文字母,数字,"_"}: " tmp
if [[ "$tmp" =~ $regex5 ]]; then
	echo "ok: $tmp"
else	
	echo "5 Invalid entry"
fi

