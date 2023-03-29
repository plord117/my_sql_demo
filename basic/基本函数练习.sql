/*
    SQL函数
    1.聚合函数
    2.数学函数
    3.字符串函数
    4.日期函数
 */

# --- 1:聚合函数 ---#
use mydb4;
# 1.查询每一个部门的员工
select  d.DNAME,group_concat(distinct ENAME) from emp e join dept d on e.DEPTNO = d.DEPTNO group by d.DNAME;

# 2.查询每一个部门的员工，使用指定的分隔符，员工按着薪资进行排序
select  d.DNAME, group_concat(distinct ENAME order by SAL DESC separator ';') from emp e join dept d on e.DEPTNO = d.DEPTNO group by d.DNAME;

# --- 2:数学函数 --- #
# 1.返回x的绝对值
select abs(-1) as res;

# 2.返回大于或等于 x 的最小整数　
select ceil(1.5) as res;

# 3.返回列表中的最大值
select GREATEST(3, 12, 34, 5, 8) as res;

# 4.返回列表中的最小值
select LEAST(3, 12, 34, 5, 8) as res;

# 5.返回3的2次方
select pow(3, 2) as res;

# 6.返回 0 到 1 的随机数。
select rand() as res;

# 7.四舍五入
select round(3.1415926, 3) as res;

# 8.不进行四舍五入
select truncate(3.1415926, 3) as res;

# --- 3:字符串函数 --- #

# 1.返回字符串长度
select CHAR_LENGTH('abc') as res;

# 2.字符串有分隔符拼接
select concat_ws(';' , 'a', 'b', 'c') as res;
select concat('a', 'b', 'c') as res;

# 3.从字符串 s 的 n 位置截取长度为 len 的子字符串
select mid('abcdefg', 2, 2) as res;

# 4.获取字符串A在B中的起始位置
select position('abc' in 'acswabclfkjiw') as res;

# 5.将字符串 s2 替代字符串 s 中的字符串 s1
select replace('abcde', 'ab', 'zx') as res;

# 6.比较字符串 s1 和 s2，如果 s1 与 s2 相等返回 0 ，如果 s1>s2 返回 1，如果 s1<s2 返回 -1
select strcmp('ab', 'ac') as res;
select strcmp('ab', 'ab') as res;

# 7.转换大写
select upper('abc') as res;

# 8.转换小写
select lower('ABC') as res;

# --- 4:日期函数 --- #

# 1.返回当前日期
select curdate() as res;

# 2.返回从1970-01-01 00:00:00到当前毫秒值
select unix_timestamp() as res;

# 3.返回当前时间
select curtime() as res;

# 4.从日期或日期时间表达式中提取日期值
select Date('2022-01-03') as res;

# 5.计算日期 d1->d2 之间相隔的天数
select datediff('2022-03-05', '2022-03-06') as res;

# 6.计算时间差
select timediff('2021-02-02 13:05:00', '2021-02-03 13:05:00') as res;

# 7.日期减去指定的时间间隔
select date_sub('2022-04-07', INTERVAL 2 DAY ) as res;

# 8.日期添加指定的时间间隔
select date_add('2022-04-08', INTERVAL 1 Day ) as res;

# 9.从日期 d 中获取指定的值
select extract(YEAR from '2021-02-02 13:05:00') as year;
select extract(MONTH from '2021-02-02 13:05:00') as month;
select extract(DAY from '2021-02-02 13:05:00') as day;
select extract(HOUR from '2021-02-02 13:05:00') as hour;
select extract(MINUTE from '2021-02-02 13:05:00') as minute;

# 10.返回给定月份的最后一天
select LAST_DAY('2022-02-02') as res;

# 11.返回指定日期是第几个星期
select week('2022-03-06') as res;

# 12.返回日期是星期几
select weekday('2022-03-06') + 1 as res;

# 13.返回当前的日期和时间
select now() as now;

# 14.返回年份
select year('2022-03-06 14:25:52') as year;

# 15.返回月份
select month('2022-03-06 14:25:52') as month;

# 16.返回日
select day('2022-03-06 14:25:52') as day;

# 17.返回小时
select hour('2022-03-06 14:25:52') as hour;

# 18.返回分钟
select minute('2022-03-06 14:25:52') as minute;

# 19.返回秒钟
select second('2022-03-06 14:25:52') as second;

# 20.返回季度
select quarter('2022-03-06 14:25:52') as quarter;

# 21.按表达式 f的要求显示日期 d
SELECT DATE_FORMAT('2011-11-11 11:11:11','%Y-%m-%d %r') as res;

# 22.将字符串转变为时间
SELECT STR_TO_DATE('August 10 2017', '%M %d %Y') as res;