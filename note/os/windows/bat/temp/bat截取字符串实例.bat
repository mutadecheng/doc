@echo off
set str=123456789
echo 字符串为：%str%
echo 第一个字符为：%str:~0,1%
echo 头两个字符为：%str:~0,2%
echo 头5个字符为：%str:~0,5%
echo 去掉最后一个字符后的字符串为：%str:~0,-1%
echo 去掉最后3个字符后的字符串为：%str:~0,-3%
echo 第4个字符为：%str:~3,1%
echo 第4个及其之后的3个字符为：%str:~3,4%
echo 最后一个字符为：%str:~-1%
echo 最后一个字符为：%str:~-1,1%
echo 最后两个字符为：%str:~-1,2%
echo 倒数第4个字符为：%str:~-4,1%
echo 倒数第4个及其之后的字符为：%str:~-4%
echo 倒数第4个及其之后的1个字符为：%str:~-4,2%
echo 倒数第4个及其之后的2个字符为：%str:~-4,3%
pause