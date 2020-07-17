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


#1.shell 中能否切换用户？ 答案: NO!!
:<<!
	一旦你切换了用户, 那么shell 的执行环境会被切换;
	相当于exec("/bin/bash")执行一个新的shell, 而且会切换用户(拥有不同的执行权限);
	所以在shell 执行的过程中, 是不可以切换用户的.

	切换用户, 执行某段shell 代码, 这种用法基本就是行不通的.
	而且你还需要手动输入'被切换的用户的密码'
!


#2.替代方案: sudo 指定某个用户执行某个指令
:<<!
	(sudo -u "user_name"操作在root用户手上, 万试万灵)
	一般情况下, shell 运行过程中不允许切换用户.
	如果有特殊情况, 可以使用sudo -u 指定用户执行某些任务.
	不需要密码, 但需要高级权限, 可以随意切换用户最好.
!
sudo -u adan ls
sudo -u postgres ./psql


#3.shell 的启动与关闭
:<<!
	shell 启动的时候, 都是从tty 中执行: 
		exec("/bin/bash") # 启动一个新的空shell 终端.
	xfce4-terminal 默认使用:/bin/bash
	debian 默认使用:/bin/bash

	但你可以强行执行:
		/bin/sh
	来启动posix shell

	执行过程中不能切换用户!!
!



