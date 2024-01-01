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


# 0.shell 跟system 的亲源性. 
# shell = system command 编程, shell 可以直接跑系统大部分的命令;
# (当然su root 切换用户, 然后要二次输入密码的shell 很难写)
# 运行shell 需要chmod 授权(需要先授权再运行)
ls
ping "-help"
# 打印字符串的新方式(格式化打印字符串), 比echo 打印稍微复杂一点.
printf '\n%s' "hello you idiot"
printf '\n%s' "love off me idiot"





#1.posix shell 与bash shell 的区别:
if false; then
	echo "
	1)
		posix shell 是bash shell 的子集, 但是执行条件更苛刻,
		很多拓展特性不能用, 例如if 不能使用[[]] 拓展判断.
		source 关键字不能用, 等等.

		但posix shell 的好处是:
			跨平台流通性.

		bash shell 虽然流通性不高, 主要是各大平台的默认shell 都不一样, 
		但是各大平台都支持安装bash shell, 安装和使用都十分简单方便.

	2)
		只要安装了bash shell, 剩下只要定义:
			#!/bin/bash, 就表示以bash shell 标准, 执行这个shell, 
			程序会自己找到bash shell 程序的.
		同理:
			#!/bin/sh
			表示: 
				以posix 标准, 执行这个shell 程序, 
				也会自动找到posix shell 程序执行此脚本的.
		如:
			#!/bin/bash
			#!/bin/sh
			#!/bin/sh 实际等于 #!/bin/bash --posix, 表示遵循posix的特定规范

	3)
		但是, 单靠shell 文本行头指定的shell 标准, 不一定就是使用posix 标准的规则去运行shell.
		bash shell 开启posix 标准, 其实也会放水, 
		有时候posix shell 不允许的语句, bash shell的posix 标准, 也会放行.(十分奇怪)

		所以, 想要真正写出posix shell 标准的程序, 最安全的办法是:
			直接执行/bin/sh, 然后运行程序进行测试, 这样才能真正体验到posix shell !!

	4)
		注意:
			xfce4-terminal shell默认是bash shell, 想使用posix shell, 直接执行/bin/sh
	" > /dev/null
fi





#2.shell 的备注:
# 单行备注:
######禁止在执行语句的后面, 打单行备注!! 虽然shell这样做, 但容易出错.####
######ini 配置文件肯定出错, ini 配置文件不让在语句后面打备注的.#########


# 多行备注:
# posix 标准shell 的多行注释(万能):
if false; then
	echo "
		shell 是一种一边执行, 一边翻译的语言, 不需要预先编译, 只会预先检查语法是否正确.
		这意味着, 你可以像这样做注释, 丝毫不影响shell 程序.
		也不会增加shell 程序的消耗.
		shell 程序只有在读到这个语句的时候, 才会调用echo 程序, 然后将字符串弹入echo 程序.
		然后监控echo 程序的执行结果.
		但是这是一个永远读不到的语句!!

		不过这里多了一个读取消耗.
		但是其实第一种方法, 也有读取消耗的.
		shell 是一直逐句逐句读取的, 所以肯定会继续向下读取, 就算是注释语句, 也要读.
		也就是: 注释语句也要if 一下, 其实原理都一样.
	" > /dev/null
fi
# 空式(方便copy)
if false; then
	echo "
		
	" > /dev/null
fi


# bash 标准shell 的多行注释(用来注释文字容易, 用来注释'shell执行语句', 困难).
# posix shell 也支持这种注释方式.
# 但如果有语法错误, 可以切换到if false; then 那种方法进行注释.
:<<!
注意:
	多行备注不能完全屏蔽部分关键字, 如:
		$ () # 这两个字符不能合并, 否则shell 可以运行, 但仍然会在这一句报错.

	posix 其实也可以用这种多行注释, 但是可能关键字限制更严重.
	实在不行, 你就用if false; then 来注释, 万能.

!





#3.shell 简写式 与 ';'行结束 符号:
:<<!
		shell 简写式, 每一句都要打';'号结束, 
		否则会出现很多未知错误!! 语法错误!!
		而且很难定位错误, 直接就是显示:
			最后一行缺失fi or done or esac之类的.
			十分诡异, 麻烦!!
		ps: shell 定位错误, 本来就比较困难, 尽量写得标准点, 才是关键.
!

# shell 行结束符号';':
# ';'行结束符号, 可以让一行中, 执行多句shell语句!!
# (但后面不能加'#'单行注释,防止出错)
echo "hello"; echo "hello again";





#
#4.查看当前系统支持哪些shell
#
cat /etc/shells

# 检查当前系统是否支持bash shell
tmp=$(cat /etc/shells | grep "bash")
if [ -z "$tmp" ];then
	echo "this system is not support bash shell"
else
	echo "this system support bash shell"
fi




#
#5.开启shell 调试模式
#
# 开启调试模式
set -x
:<<!
		shell 是先装载字符串, 再执行的; 
		shell 在'执行前'会先检查一遍语法, 
		只要shell 中有任何一个'语法错误', shell 不会运行, 
		但会告诉你什么语句错了.

		在set -x, debug 模式下, shell 会告诉你是哪一行出错, 跟lua 差不多.
		你也可以用'显式命令'debug shell: 
			sh -x ./test.sh

		常用的shell debug 模式:
			# 开启debug 模式(不打印备注)
			set -x
			# 开启debug 非常详细模式(打印备注, 从这一行开始, 备注也会被打印出来)
			set -vx
			# 关闭debug 模式(默认模式)
			set +x

		你可以在任意地方开启and关闭调试模式, 以方便进行区域调试.
		这样不用显示所有的调试信息, 免得追查困难
!
# 关闭调试模式(只调试本段程序)
set +x





#
#6.shell 脚本出现编码格式差异时:
#
:<<!
	如果出现: /bin/bash^M: bad interpreter
	一般情况下, 不是UTF-8 的字符编码格式问题, 
	而是换行符号\n or \r\n 的问题.

	unix 下的换行符, 与windows 下的换行符'\r\n' 是不一样的. 
	所以你需要转换一下.
	# vim 查询字符的编码格式
	:set ff?
	# 设置fileformat=unix
	:set ff=unix
	:set ff=dos
!




