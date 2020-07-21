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
# 全局变量
#
RETURN_TRUE="0"
RETURN_FLASE="1"
EXIT_OK="0"
EXIT_FAIL="1"

# for no systemd
old_way_sw="0"
# for systemd
new_way_sw="0"



#
# 需要用root 用户运行, 检查$USER=="root":
# (在黑屏系统中有效!! 
#  在xorg 可视化系统中, 你用xfce4-terminal 切换root权限, $USER 永远等于adan.
#  即在xorg 可视化系统中, 你用什么用户登录桌面, $USER 永远等于那个用户.)
#
tmp=$(whoami)
#tmp=${USER}
if [ $tmp = "root" ];then
	echo "you are now using account:" $tmp;
	echo "welcome to use tarball package by adan_shaw@qq.com";
else
	echo "you are now using account:" $tmp;
	echo -e "you are not the system manager !!\nplease login root user to run this script";
	# 询问用户是否继续
	read -r -p "Are You Sure That You Wanna Keep Run This Program On? [Y/n] " input;
	case $input in
		[yY][eE][sS]|[yY])
			echo "Yes, the program going on now!!";
		;;

		[nN][oO]|[nN])
		echo "No, thank you, the program now quit!!"
			exit $EXIT_FAIL;
		;;

		*)
		echo "Invalid input... the program now quit!!";
			exit $EXIT_FAIL;
		;;
	esac
fi



#
# 检查系统版本(本程序仅适用于debian 7 or debian 8以上的程序, 其它版本的linux 未尝试过)
#
apt-get install sudo
# debian7 没有hostnamectl 命令, 只能用lsb_release -a 命令!!
# 安装lsb-release 包
sudo apt-get install lsb-release

debian7=$(lsb_release -d | grep "wheezy")
debian8=$(lsb_release -d | grep "jessie")
debian9=$(lsb_release -d | grep "stretch")
debian10=$(lsb_release -d | grep "buster")
debian11=$(lsb_release -d | grep "bullseye")
debian12=$(lsb_release -d | grep "bookworm")

if [ -n "$debian7" ];then old_way_sw="1"; echo "os=debian7, $debian7"; fi
if [ -n "$debian8" ];then new_way_sw="1"; echo "os=debian8, $debian8"; fi
if [ -n "$debian9" ];then new_way_sw="1"; echo "os=debian9, $debian9"; fi
if [ -n "$debian10" ];then new_way_sw="1"; echo "os=debian10, $debian10"; fi
if [ -n "$debian11" ];then new_way_sw="1"; echo "os=debian11, $debian11"; fi
if [ -n "$debian12" ];then new_way_sw="1"; echo "os=debian12, $debian12"; fi



#
# old_way_func(){} 旧的方式, 没有systemd
#

# 扫描service 的状态, 返回service 是否在运行.
# 参数错误: 直接终止
# is running 返回"0"
# is not running 返回"1"(参数错误返回1)
# unrecognized service: 未识别服务, 返回"0", 需要与running 再做区分!!
#
old_way_check_service_son() {
	# 参数检查
	if [ $# != "1" ];then echo "old_way_check_service_son() parameters num of sum"; exit $EXIT_FAIL; fi
	if [ -z "$1" ];then echo "old_way_check_service_son() parameters cant be empty" exit $EXIT_FAIL; fi

	# 执行逻辑检查
	tmp_father=$(sudo service "$1" status)

	# 空也是: 未识别服务名
	if [ -z "$tmp_father" ];then return $RETURN_TRUE; fi
	# 未识别服务名
	tmp=$(echo "$tmp_father" | grep "unrecognized service")
	if [ -n "$tmp" ];then
		#不能显示任何东西, 否则old_way_check_service_father() 会识别是错!
		#echo "$1 is a unrecognized service"
		return $RETURN_TRUE
	fi

	# 正在运行
	tmp=$(echo "$tmp_father" | grep "is running")
	if [ -n "$tmp" ];then
		echo "service [$1] is running"
		return $RETURN_TRUE
	fi

	# 未运行(会被自动重启)
	tmp=$(echo "$tmp_father" | grep "is not running")
	if [ -n "$tmp" ];then
		echo "service [$1] is not running"
		return $RETURN_FLASE
	fi

	# 该service 不支持status 关键字(networking 本身就不支持status 关键字)
	# 被当成是成功!!
	tmp=$(echo "$tmp_father" | grep "start|stop")
	if [ -n "$tmp" ];then
		echo "a usage error on this service [$1]"
		return $RETURN_TRUE
	fi

	# 未知service status(自动尝试重启启动)
	echo "service [$1]: unknow service status!!"
	return $RETURN_FLASE
}

# 自定义的service 检查例程, 主要描述检查之后的操作, 重启, 跳过, 正常=不操作？？
# 参数错误: 直接终止
# service name 错误, 可以return"1", 也可以返回"0" 方便调试
# 其他都返回"0", 表示绝对正确
old_way_check_service_father() {
	# 参数检查
	if [ $# != "1" ];then echo "old_way_check_service_father() parameters num of sum"; exit $EXIT_FAIL; fi
	if [ -z "$1" ];then echo "old_way_check_service_father() parameters cant be empty" exit $EXIT_FAIL; fi

	# 检查sudo service
	tmp=$(old_way_check_service_son "$1")
	#set -x
	if [ "$?" = "$RETURN_TRUE" ];then
		# 没有这个service(也可以返回RETURN_FLASE, 因为这也是参数输入错误!!)
		# 但是你觉得方便的话, 可以容忍错误, 方便全局测试
		if [ -z "$tmp" ];then return $RETURN_TRUE; fi

		# service 正常
		echo "$tmp"
		echo "ok"
		return $RETURN_TRUE;
	else
		# service 不正常,自动重启一次(如果需要循环启动,请用cron实现比较好,这里只做一次性操作)
		tmp=$(sudo service "$1" restart)
		# 再次检查一次service 状态
		tmp=$(old_way_check_service_son "$1")
		if [ "$?" = "$RETURN_TRUE" ];then
			echo "restart {$1} ok "
		else
			echo "restart {$1} fail !!"
		fi
		return $RETURN_TRUE;
	fi
	#set +x
}

#
# 一般情况下, 你需要改动这里!! 添加新的待检测service or 删除待检测的service
#
old_way_func() {
	echo -e "\n\nold_way_func() start: "

	# 检查networking service
	old_way_check_service_father "networking";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查cron service
	old_way_check_service_father "cron";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查rsyslog service
	old_way_check_service_father "rsyslog";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查postgres service
	old_way_check_service_father "postgres";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查nginx service
	old_way_check_service_father "nginx";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查odoo service
	old_way_check_service_father "odoo";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	exit $EXIT_OK
}






#
# new_way_func(){} 新的方式, 有systemd
#

# 扫描service 的状态, 返回service 是否在运行.
# 参数错误: 直接终止
# running 返回"0"
# dead or failed 返回"1"
# service could not be found: 不存在服务, 返回"0", 需要与running 再做区分!!
#
new_way_check_service_son() {
	# 参数检查
	if [ $# != "1" ];then echo "new_way_check_service_son() parameters num of sum"; exit $EXIT_FAIL; fi
	if [ -z "$1" ];then echo "new_way_check_service_son() parameters cant be empty" exit $EXIT_FAIL; fi

	# 执行逻辑检查
	#tmp=$(sudo service $1 status | grep "Active:")
	tmp=$(sudo service "$1" status | grep "Active:" | awk '{print $2}')

	# for test
	#echo "*** $tmp ***" # for test

	# 没有这个服务
	if [ -z "$tmp" ]; then
		#echo "*MY: Unit $1.service could not be found."
		#不能显示任何东西, 否则new_way_check_service_father() 会识别是错!
		return $RETURN_TRUE;
	fi

	# 不活动: inactive (dead)
	if [ "$tmp" = "inactive" ]; then
		echo "service [$1] dead"
		return $RETURN_FLASE
	fi

	# 活动: active (running)
	if [ "$tmp" = "active" ]; then
		echo "service [$1] running"
		return $RETURN_TRUE
	fi

	# 启动失败: failed 
	if [ "$tmp" = "failed" ]; then
		echo "service [$1] failed"
		return $RETURN_FLASE
	fi

	# 未知service status(自动尝试重启启动)
	echo "service [$1]: unknow service status!!"
	return $RETURN_FLASE
}

# 自定义的service 检查例程, 主要描述检查之后的操作, 重启, 跳过, 正常=不操作？？
# 参数错误: 直接终止
# service name 错误, 可以return"1", 也可以返回"0" 方便调试
# 其他都返回"0", 表示绝对正确
new_way_check_service_father() {
	# 参数检查
	if [ $# != "1" ];then echo "new_way_check_service_father() parameters num of sum"; exit $EXIT_FAIL; fi
	if [ -z "$1" ];then echo "new_way_check_service_father() parameters cant be empty" exit $EXIT_FAIL; fi

	# 检查sudo service
	tmp=$(new_way_check_service_son "$1")
	#set -x
	if [ "$?" = "$RETURN_TRUE" ];then
		# 没有这个service(也可以返回RETURN_FLASE, 因为这也是参数输入错误!!)
		# 但是你觉得方便的话, 可以容忍错误, 方便全局测试
		if [ -z "$tmp" ];then return $RETURN_TRUE; fi

		# service 正常
		echo "$tmp"
		echo "ok"
		return $RETURN_TRUE;
	else
		# service 不正常,自动重启一次(如果需要循环启动,请用cron实现比较好,这里只做一次性操作)
		tmp=$(sudo service "$1" restart)
		# 再次检查一次service 状态
		tmp=$(new_way_check_service_son "$1")
		if [ "$?" = "$RETURN_TRUE" ];then
			echo "restart {$1} ok "
		else
			echo "restart {$1} fail !!"
		fi
		return $RETURN_TRUE;
	fi
	#set +x
}

#
# 一般情况下, 你需要改动这里!! 添加新的待检测service or 删除待检测的service
#
new_way_func() {
	echo -e "\n\nnew_way_func() start: "

	# 检查networking service
	new_way_check_service_father "networking";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查cron service
	new_way_check_service_father "cron";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查rsyslog service
	new_way_check_service_father "rsyslog";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查postgres service
	new_way_check_service_father "postgres";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查nginx service
	new_way_check_service_father "nginx";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	# 检查odoo service
	new_way_check_service_father "odoo";
	if [ "$?" = "$RETURN_FLASE" ];then exit $EXIT_FAIL; fi

	exit $EXIT_OK
}



#
# 判断使用新方式, 还是旧方式的逻辑
#
if [ "$old_way_sw" = "1" ]; then old_way_func; fi
if [ "$new_way_sw" = "1" ]; then new_way_func; fi


echo "shouldn't run to here, please check your shell program"
exit $EXIT_FAIL
