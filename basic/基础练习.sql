/*
    基础操作练习
    1.创建数据库
    2.创建表
    3.删除数据库
    4.删除表

 */
drop database if exists mydb1; -- 丢弃旧的数据库
create database mydb1;  -- 创建数据库【mydb1】
use mydb1;  -- 使用该数据库

show table status;  -- 显示所有表的具体细节。
show tables;    -- 显示所有的表名称

drop table if exists student;
create  table if not exists student(
    sid int,
    name varchar(20),
    gender varchar(20),
    age int,
    birth date,
    address varchar(20),
    score double
);
desc student;   -- 显示数据库结构
show create table student;  -- 显示建表语句

# --------------------------------- 基础练习结束 ---------------------------------#
/*
    单表查询
    1.算数运算符
    2.比较运算符
    3.比较运算符
    5.逻辑运算符
    6.位运算符
*/

drop database if exists mydb2;  -- 丢弃旧的数据库
create database if not exists mydb2;    -- 创建数据库【mydb1】
use mydb2;  -- 使用该数据库

#--- 创建商品表 ---
create table product(
 pid int primary key auto_increment, -- 商品编号
 pname varchar(20) not null , -- 商品名字
 price double,  -- 商品价格
 category_id varchar(20) -- 商品所属分类
);

#--- 插入一些数据 ---
insert into product values(null,'海尔洗衣机',5000,'c001');
insert into product values(null,'美的冰箱',3000,'c001');
insert into product values(null,'格力空调',5000,'c001');
insert into product values(null, '九阳电饭煲',200, 'c001');
insert into product values(null,'啄木鸟衬衣',300,'c002');
insert into product values(null,'恒源祥西裤',800,'c002');
insert into product values(null,'花花公子夹克',440,'c002');
insert into product values(null,'劲霸休闲裤',266,'c002');
insert into product values(null,'海澜之家卫衣',180,'c002');
insert into product values(null,'杰克琼斯运动裤',430,'c002');
insert into product values(null,'兰蔻面霜',300,'c003');
insert into product values(null,'雅诗兰黛精华水',200,'c003');
insert into product values(null,'香奈儿香水',350,'c003');
insert into product values(null,'SK-II神仙水',350,'c003');
insert into product values(null,'资生堂粉底液',180,'c003');
insert into product values(null,'老北京方便面',56,'c004');
insert into product values(null,'良品铺子海带丝',17,'c004');
insert into product values(null,'三只松鼠坚果',88,null);

# --- DQL基本查询 --- #
# 1.查询表中的所有数据
select * from product;

# 2.对表中的价格进行去重
select distinct price from product;

# 3.对表中的价格加10
select pid,pname,price+10, category_id from product;

# 4.对表中的价格增加10%
select pid,pname,price*1.1, category_id from product;

# 5.查询种类不是c001和c003的
select * from product where category_id  not in ('c001','c003');

# 6.查询表中价格在200-1000的商品
select * from product where price >= 200 and price <=1000;

# 7.使用between查询表中价格在200-1000的商品
select * from product where price between 200 and 1000;

# 8.查询价格不是800的商品
select * from product where price != 800;
select * from product where price <> 800;
select * from product where not(price=800);

# 9.查询以海作为开头的所有商品
select * from product where pname like '海%';

# 10.查询第二个字为'蔻'的所有商品
select * from product where pname like '_蔻%';

# 11.查询category_id为null的商品
select * from product where category_id is null;
select * from product where category_id <=> null;

# 12.查询category_id不为null的商品
select * from product where category_id is not null;
select * from product where not category_id <=> null;

# 13.使用greatest计算最大值
select greatest(500, 220, 300) as max;
select greatest(10, null, 30) as max;

# 14.使用least计算最小值
select least(500, 220, 300) as min;
select least(10, null, 30) as min;

# 15.查询全表按着字段【pid】进行排序
select * from product order by price;
select * from product order by price ASC ;
select * from product order by price DESC;

# 16.在价格排序(降序)的基础上，以分类排序(降序)
select * from product order by price DESC, category_id DESC ;

# 17.显示商品的价格(去重复)，并排序(降序)
select distinct price from product order by price DESC ;

# --- DQL聚合查询 --- #

# 查询全表
select * from product;

# 1.统计表中记录数
select count(*) as num from product;

# 2.统计pid的记录数
select count(pid) from product;

# 3.查询价格大于200的记录数
select count(*) from product where price > 200;

# 4.查询分类为'c001'的所有商品的金额总和和数量总和
select sum(price) as sum, count(*) count from product where category_id = 'c001';

# 5.查询商品最大价格
select max(price) from product;

# 5.进阶查询最贵的商品信息
select * from product where price = (select max(price) from product);
select p1.pid, p1.pname, p1.price, p1.category_id from product p1 inner join (select max(price) max from product) p2 on p1.price = p2.max;
select * from product order by price DESC limit 1;  -- 不全

# 6.查询商品的最小价格
select min(price) as min from product;

# 7.查询c002商品的平均价格
select avg(price) from product where category_id = 'c002';
select round(avg(price),2) avg from product where category_id = 'c002';

# --- DQL分类查询 --- #
# 1.查询每个种类的商品个数
select category_id, count(*) as count from product group by category_id;

# 2.查询每个种类的商品个数但是不包括null
select category_id, count(*) as count from product where category_id is not null group by category_id;

# 3.查询每个种类的商品总额
select category_id, sum(price) as sum from product group by category_id;

# 4.查询每个种类的商品总额在100以上的
select category_id, sum(price) as sum from product group by category_id having sum > 100;

# 5.查询每个种类商品的平均价格
select category_id, round(avg(price), 2) as sum from product group by category_id;

# 6.查询每个种类商品的综合信息
SELECT category_id, count(*) count, sum(price) sum, round(AVG(price), 2) avg 
from product where category_id is not null group by category_id order by avg;

# --- DQL分页查询 --- #
# 查询全表
select * from product;

# 显示头两个数据
select * from product limit 2;

# 显示从第一个开始的两个数据
select * from product limit 1,2;
select * from product limit 2 offset 1;

# --- DQL正则表达式查询 --- #
# 1. 【^】在字符串开始处进行匹配
SELECT  'abc' REGEXP '^a' as res;

# 2.【$】在尾部进行字符匹配
SELECT  'abc' REGEXP 'c$' as res;

# 3.【.】匹配任意字符
select 'abc' REGEXP '.b' as res;
select 'abc' REGEXP '.c' as res;
SELECT 'abc' REGEXP 'a.' as res;

# 4.【[]】匹配其中的任意字符
SELECT 'abc' REGEXP '[ab]' as res;
SELECT 'abc' REGEXP '[abc]' as res;
select 'abc' REGEXP '[s3v]' as res;

# 4.【[^]】不匹配其中的任意字符
SELECT 'abc' REGEXP '[^ab]' as res;
SELECT 'abc' REGEXP '[^abc]' as res;
select 'abc' REGEXP '[^s3v]' as res;

# 5.【*】匹配一个或者多个字符
SELECT 'stab' REGEXP '.ta*b' as res;
SELECT 'stb' REGEXP '.ta*b' as res;
SELECT '' REGEXP 'a*' as res;

# 6.【+】匹配1个或者多个a,但是不包括空字符
SELECT 'stab' REGEXP '.ta+b' as res;
SELECT 'stb' REGEXP '.ta+b' as res;

# 7.【a{m,n}】 匹配m到n个a,包含m和n
SELECT 'auuuuc' REGEXP 'au{3,5}c' as res;
SELECT 'auuuuc' REGEXP 'au{4,5}c' as res;
SELECT 'auuuuc' REGEXP 'au{5,10}c' as res;

# 8.【(abc)】作为一个整体进行匹配
SELECT 'xababy' REGEXP 'x(abab)y' as res;
SELECT 'xababy' REGEXP 'x(ab)*y' as res;
SELECT 'xababy' REGEXP 'x(ab){1,2}y' as res;