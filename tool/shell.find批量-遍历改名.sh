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
# ***尝试获取可用的tmpfs***
# ***本程序在debian 10中测试成功,普通用户可以在tmpfs分区"/run/lock"中获取读写权限***
#
# 获取所有的tmpfs 分区
tmpfs_all=$(df -h | grep tmpfs | awk '{print $6}')

# 检查哪个分区可以写入
tmp_file_check=$(date "+%Y%m%d%H%M%S")
tmp_file_check="tmp_file_check-$tmp_file_check"
tmp_fs=""
for tmp in $tmpfs_all
do
	echo "" > $tmp/$tmp_file_check
	if [ -f "$tmp/$tmp_file_check" ];then
		tmp_fs="$tmp"
		echo "tmp_fs now = $tmp_fs"
		rm $tmp_fs/$tmp_file_check
		break
	fi
done
if [ -z $tmp_fs ];then
	echo "没有可用的tmpfs 分区!! tmp_fs=$tmp_fs"
	exit 1
fi



#
# 创建内存分区(将频繁修改数据的文件,写入内存分区) -- 需要root 权限, 太麻烦!!
#
#mount -t tmpfs -o size=128M tmpfs $tmp_fs



#
# 用文件保存path数据, 代替读取path字符串的时候, 遇到空格会被分拆为两个字符串的尴尬局面
# shell 程序还是file 考得住!!
# 字符串就是个笑话!!
#
all_set_file="$tmp_fs/all_set_file"
folder_count="$tmp_fs/folder_count"
file_count="$tmp_fs/file_count"
finished_count="$tmp_fs/finished_count"

# 防止数据冲突
echo "" > $all_set_file
echo "" > $folder_count
echo "" > $file_count
echo "" > $finished_count


#
# 询问用户, 目标路径
#
echo -e "请输入要批量操作的文件夹路径.\n
(请不要以'/'结束,例如: /home/adan 即可, 不能/home/adan/ !!)"
read -r -p "please: " input;
target=$input



#
# find 找到文件3个文件集
#
find $target > $all_set_file
tmp=$(cat $all_set_file | wc | head -n 1 | awk '{print $1}')
tmp=$(echo $tmp)
echo -e "文件+文件夹总数=$tmp \n\n"

#find $target -type d > $folder_count



#
# 读取每一行, 并打印
#
count2="0"
count3="0"
cat $all_set_file | while read line
do
	# -d 可以判断出, 该文件是不是文件夹, 并且存在不存在
	if [ -d "$line" ];then
		echo "$line"
		let count3=$count3+1
		echo "$count3" > $folder_count
	fi
	# -f 可以判断出, 该文件是不是文件, 并且存在不存在
	if [ -f "$line" ];then
		echo "$line"
		let count2=$count2+1
		echo "$count2" > $file_count
	fi
done
count=$(cat $all_set_file | wc | head -n 1 | awk '{print $1}')
count2=$(cat $file_count)
count3=$(cat $folder_count)
echo "总数: $count"
echo "文件总数: $count2"
echo "文件夹总数: $count3"


tmp=$[count2+count3]
if test "$tmp" != "$count"
then
	echo "总数 != (文件总数 + 文件夹总数)"
else
	echo "总数=$tmp == (文件总数=$count2 + 文件夹总数=$count3)"
fi

# 取文件的第一行(这样的效率太低!! 性能不好)
#tmp=$(cat $all_set_file | head -n 1)
#if [ -d "$tmp" ];then
#	echo "$tmp"
#fi



#
# 询问用户: 文件数量和文件名是否匹配, 是否继续?
#
read -r -p "文件数量和文件名是否匹配, 是否继续? [Y/n] " input;
case $input in
	[yY][eE][sS]|[yY])
		echo "Yes, the program going on now!!";
	;;

	[nN][oO]|[nN])
		echo "No, thank you, the program now quit!!"
		exit 1;
	;;

	*)
		echo "Invalid input... the program now quit!!";
		exit 1;
	;;
esac

echo "go on"



#
# 执行改名
#
count_x="0"
head_name="x"
time_name=$(date "+%Y%m%d%H%M%S")
xx=""
cat $all_set_file | while read line
do
	# -d 可以判断出, 该文件是不是文件夹, 并且存在不存在
	#if [ -d "$line" ];then
		#echo "$line"
		#let count3=$count3+1
		#echo "$count3" > $folder_count
	#fi
	# -f 可以判断出, 该文件是不是文件, 并且存在不存在
	if [ -f "$line" ];then
		echo "$line"
		let count_x=$count_x+1
		echo "$count_x" > $finished_count
		# 取修改前的路径前缀, 保证原位置, 就地改名
		xx=$(dirname $line | head -n 1)
		#echo "叼$xx"
		# 批量改名
		mv "$line" "$xx/$head_name$time_name-$count_x"
		# 
		# 批量删除(专门用来生产测试数据,勿用!!)
		#rm "$line"
		#echo "" > "$line"
		#
	fi
done
tmp=$(cat $finished_count)
echo -e "改名个数:$count2, 被改名的文件总数:$tmp\n\n"



#
# 卸载内存分区(数据全部丢失, 不用删除) -- 需要root 权限, 太麻烦!!
#
#umount -v $tmp_fs



