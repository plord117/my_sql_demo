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

/*
    多表联合查询
    1.七种join形式，等价理解为是集合之间的各种连接形式。
    2.子查询。
    3.综合示例。
 */

drop database if exists mydb3;  -- 删除旧的数据库
create database if not exists mydb3;  -- 创建数据库
use mydb3;  -- 使用该数据库

-- 创建部门表
create table if not exists dept(
  deptno varchar(20) primary key ,  -- 部门号
  name varchar(20) -- 部门名字
);

# 创建员工表
create table if not exists emp(
  eid varchar(20) primary key , -- 员工编号
  ename varchar(20), -- 员工名字
  age int,  -- 员工年龄
  dept_id varchar(20),  -- 员工所属部门
  constraint emp_fk foreign key (dept_id) references dept (deptno)
);

    -- 1、添加主表数据
-- 注意必须先给主表添加数据
insert into dept values('1001','研发部');
insert into dept values('1002','销售部');
insert into dept values('1003','财务部');
insert into dept values('1004','人事部');

-- 2、添加从表数据
insert into emp values('1','乔峰',20, '1001');
insert into emp values('2','段誉',21, '1001');
insert into emp values('3','虚竹',23, '1001');
insert into emp values('4','阿紫',18, '1002');
insert into emp values('5','扫地僧',35, '1002');
insert into emp values('6','李秋水',33, '1003');
insert into emp values('7','鸠摩智',50, '1003');
insert into emp values('8','张无忌',50, null);

         # --- 7种join--- #
# 查看emp表
select * from emp;

# 查看dept表
select * from dept;

# 进行全连接查询
select * from dept, emp;

# 1.进行emp和dept的右连接
select * from emp right join dept d on d.deptno = emp.dept_id;

# 2.进行emp和dept的左连接
select * from emp left join dept d on d.deptno = emp.dept_id;

# 3.进行emp和dept的内连接
select * from emp inner join dept d on emp.dept_id = d.deptno;

# 4.查询dept表和emp表的并集-交集
select * from emp e left join dept d on d.deptno = e.dept_id where d.deptno is null union
select * from emp e right join dept d on d.deptno = e.dept_id where e.dept_id is null;

# 5.查询dept和emp的并集
select * from emp e left join dept d on d.deptno = e.dept_id union
select * from emp e right join dept d on d.deptno = e.dept_id;

# 6.找出emp表中不属于dept表的部分
select * from emp e left join dept d on d.deptno = e.dept_id where d.deptno is null;

# 7.找出dept表中不属于emp表的部分
select * from emp e right join dept d on d.deptno = e.dept_id where e.dept_id is null;

        # --- 子查询 --- #
drop database if exists mydb4;  -- 删除旧的数据库
create database if not exists mydb4;    -- 创建新的数据库
use mydb4;  -- 使用数据库

drop table if exists dept;  -- 删除dept表
drop table  if exists emp;  -- 删除emp表
drop table if exists salgrade;  -- 删除salgrade表

# 创建DEPT表
CREATE TABLE DEPT
       (DEPTNO int(2) not null ,
	DNAME VARCHAR(14) ,
	LOC VARCHAR(13),
	primary key (DEPTNO)
	);

# 创建EMP表
CREATE TABLE EMP
       (EMPNO int(4)  not null ,
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	MGR INT(4),
	HIREDATE DATE  DEFAULT NULL,
	SAL DOUBLE(7,2),
	COMM DOUBLE(7,2),
	primary key (EMPNO),
	DEPTNO INT(2)
	)
	;

# 创建SALGRADE表
CREATE TABLE SALGRADE
      ( GRADE INT,
	LOSAL INT,
	HISAL INT );

# 添加DEPT表相关数据
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
30, 'SALES', 'CHICAGO');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
40, 'OPERATIONS', 'BOSTON');

# 添加EMP表相关数据
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7369, 'SMITH', 'CLERK', 7902,  '1980-12-17'
, 800, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7499, 'ALLEN', 'SALESMAN', 7698,  '1981-02-20'
, 1600, 300, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7521, 'WARD', 'SALESMAN', 7698,  '1981-02-22'
, 1250, 500, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7566, 'JONES', 'MANAGER', 7839,  '1981-04-02'
, 2975, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7654, 'MARTIN', 'SALESMAN', 7698,  '1981-09-28'
, 1250, 1400, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7698, 'BLAKE', 'MANAGER', 7839,  '1981-05-01'
, 2850, NULL, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7782, 'CLARK', 'MANAGER', 7839,  '1981-06-09'
, 2450, NULL, 10);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7788, 'SCOTT', 'ANALYST', 7566,  '1987-04-19'
, 3000, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7839, 'KING', 'PRESIDENT', NULL,  '1981-11-17'
, 5000, NULL, 10);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7844, 'TURNER', 'SALESMAN', 7698,  '1981-09-08'
, 1500, 0, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7876, 'ADAMS', 'CLERK', 7788,  '1987-05-23'
, 1100, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7900, 'JAMES', 'CLERK', 7698,  '1981-12-03'
, 950, NULL, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7902, 'FORD', 'ANALYST', 7566,  '1981-12-03'
, 3000, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7934, 'MILLER', 'CLERK', 7782,  '1982-01-23'
, 1300, NULL, 10);

# 添加SALGRADE表数据
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
1, 700, 1200);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
2, 1201, 1400);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
3, 1401, 2000);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
4, 2001, 3000);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
5, 3001, 9999);

# 1.查询工资大于平均工资的员工信息
select * from emp where SAL > (select avg(SAL) from emp);

# 2.查询工资等于最大工资的员工信息
select * from emp where SAL = (select max(SAL) from emp);

# 3.查询20和30部门中工资大于2000的员工信息并按工资升序排序
select * from (select * from emp where SAL > 2000) as temp where temp.DEPTNO in (20, 30) order by SAL;

        # --- 综合示例 --- #
# 1.查询研发部门的所属员工
use mydb3;
select
       e.eid,
       e.ename,
       e.age, d.name
from emp e
    join dept d on e.dept_id = d.deptno
where d.name = '研发部';

select
       e.eid,
       e.ename,
       e.age,
       d.name
from emp e
    join dept d on e.dept_id = d.deptno
where d.name in ('研发部');

# 2.查询每个部门的员工数,并升序排序
select
       d.name,
       d.deptno,
       count(1) as count
from emp e
    join dept d on e.dept_id = d.deptno
group by
         d.deptno, d.name
order by
         count;

# 3.查询人数大于等于3的部门，并按照人数降序排序
select
       d.name,
       d.deptno,
       count(1) as count
from emp e
    join dept d on d.deptno = e.dept_id
group by

         d.name, d.deptno
having
       count >= 3
order by
       count;

/*
    约束
    1.主键约束
    2.自增长约束
    3.零填充约束
    4.外键约束
    5.非空约束
    6.唯一约束
    7.默认值约束
 */
drop database if exists mydb5;  -- 删除旧的数据库
create database if not exists mydb5;    -- 创建数据库mydb5
use mydb5;  -- 使用数据库

# --- 1:添加主键约束 ---#

drop table if exists mydb5.t_user1;
# 添加单列主键（创建表的时候进行实现）
create table if not exists t_user1(
  eid int primary key ,
  name varchar(20),
  deptId int,
  salary double
);

# 插入数据进行验证
insert into t_user1(eid, name) values (null, 'a');  -- 插入非空值错误
insert into t_user1(eid, name) values (1, 'b');
insert into t_user1(eid, name) values (1, 'c');  -- 插入相同的值错误

drop table if exists mydb5.t_user1;  -- 删除旧的表
create table if not exists t_user1(
  eid int,
  name varchar(20),
  deptId int,
  salary double
);

# 添加单列主键（通过修改表结构实现）
alter table t_user1 add primary key(eid);
# 插入数据进行验证
insert into t_user1(eid, name) values (null, 'a');  -- 插入非空值错误
insert into t_user1(eid, name) values (1, 'b');
insert into t_user1(eid, name) values (1, 'c');  -- 插入相同的值错误

# 删除t_user1的主键
alter table t_user1 drop primary key;
# 插入数据进行验证
insert into t_user1(eid, name) values (1, 'b');
insert into t_user1(eid, name) values (1, 'c');  -- 插入相同的值不报错

# 创建t_user2表
drop table if exists t_user2;
# 创建多列联合主键（创建表的时候）
create table if not exists t_user2(
  eid int,
  name varchar(20),
  deptId int,
  salary double,
  primary key (eid, deptId)
);

# 插入数据进行验证
insert into t_user2(eid, name, deptId) values (1, 'a', 1);
insert into t_user2(eid, name, deptId) values (1, 'a', 1);  -- 插入相同的值报错
insert into t_user2(eid, name, deptId) values (1, 'a', 2);   -- 只有一列不相同不报错
insert into t_user2(eid, name, deptId) values (1, 'a', null);  -- 插入空值报错
insert into t_user2(eid, name, deptId) values (null, 'a', 3);  -- 插入空值报错

# 创建t_user2表
drop table if exists t_user2;
create table if not exists t_user2(
  eid int,
  name varchar(20),
  deptId int,
  salary double
);
# 添加多列主键（更改表结构）
alter table t_user2 add primary key(eid, deptId);
# 插入数据进行验证
insert into t_user2(eid, name, deptId) values (1, 'a', 1);
insert into t_user2(eid, name, deptId) values (1, 'a', 1);  -- 插入相同的值报错
insert into t_user2(eid, name, deptId) values (1, 'a', 2);   -- 只有一列不相同不报错
insert into t_user2(eid, name, deptId) values (1, 'a', null);  -- 插入空值报错
insert into t_user2(eid, name, deptId) values (null, 'a', 3);  -- 插入空值报错

# 删除t_user2的主键
alter table t_user2 drop primary key;
# 插入数据进行验证
insert into t_user2(eid, name, deptId) values (1, 'a', 1);
insert into t_user2(eid, name, deptId) values (1, 'a', 1);  -- 插入相同的值不报错
insert into t_user2(eid, name, deptId) values (1, 'a', null);  -- !!删除主键约束不会删除非空约束
insert into t_user2(eid, name, deptId) values (null, 'a', 3);  -- !!删除主键约束不会删除非空约束
insert into t_user2(eid, name, deptId) values (null, 'a', null);  -- !!删除主键约束不会删除非空约束

# --- 2:添加自增长约束 ---#
drop table if exists t_user3;   -- 删除旧的数据库
# 添加自增长约束（创建表的时候）
create table if not exists t_user3 (
  id int primary key auto_increment,
  name varchar(20)
);
# 插入数据进行验证
insert into t_user3(name) values ('a');
insert into t_user3(name) values ('b');
insert into t_user3(name) values ('c');
delete from t_user3 where name = 'c';   -- 删除最后一个数据
insert into t_user3(name) values ('d'); -- delete数据之后自动增长从上一次断点开始

# --- 3:添加0填充约束 ---#
drop table if exists t_user4;
# 添加0填充约束（创建表的时候）
create table if not exists t_user4 (
  id int zerofill, -- 零填充约束
  name varchar(20)
);
# 插入数据进行验证
insert into t_user4 values(123, '张三');
insert into t_user4 values(1, '李四');
insert into t_user4 values(2, '王五');

# 删除0填充约束
alter table t_user4 modify id int;

# --- 4:添加外键约束 ---#
drop database if exists mydb3;  -- 删除旧的数据库
create database if not exists mydb3;    -- 创建新的数据库
use mydb3;  -- 使用数据库

-- 创建部门表
drop table if exists dept;
create table if not exists dept(
  deptno varchar(20) primary key ,  -- 部门号
  name varchar(20) -- 部门名字
);

-- 创建员工表
drop table if exists emp;
create table if not exists emp(
  eid varchar(20) primary key , -- 员工编号
  ename varchar(20), -- 员工名字
  age int,  -- 员工年龄
  dept_id varchar(20),  -- 员工所属部门
  constraint emp_fk foreign key (dept_id) references dept(deptno)
);

-- 创建员工表
drop table if exists emp;
create table if not exists emp(
  eid varchar(20) primary key , -- 员工编号
  ename varchar(20), -- 员工名字
  age int,  -- 员工年龄
  dept_id varchar(20)  -- 员工所属部门
);

-- 创建部门表
drop table if exists dept;
create table if not exists dept(
  deptno varchar(20) primary key ,  -- 部门号
  name varchar(20) -- 部门名字
);

# 添加外键约束（更改表结构）
alter table emp add constraint dept_id_fk foreign key(dept_id) references dept (deptno);

# 插入数据
-- 1、添加主表数据
 -- 注意必须先给主表添加数据
insert into dept values('1001','研发部');
insert into dept values('1002','销售部');
insert into dept values('1003','财务部');
insert into dept values('1004','人事部');

-- 2、添加从表数据
-- 注意给从表添加数据时，外键列的值不能随便写，必须依赖主表的主键列
insert into emp values('1','乔峰',20, '1001');
insert into emp values('2','段誉',21, '1001');
insert into emp values('3','虚竹',23, '1001');
insert into emp values('4','阿紫',18, '1002');
insert into emp values('5','扫地僧',35, '1002');
insert into emp values('6','李秋水',33, '1003');
insert into emp values('7','鸠摩智',50, '1003');

-- 删除数据
 /*
   注意：
       1：主表的数据被从表依赖时，不能删除，否则可以删除
       2: 从表的数据可以随便删除
 */
delete from dept where deptno = '1001'; -- 不可以删除
delete from dept where deptno = '1004'; -- 可以删除
delete from emp where eid = '7'; -- 可以删除

# --- 5:添加非空约束 ---#
use mydb5;
drop table if exists t_user6;
# 添加非空约束（创建表的时候）
create table if not exists t_user6 (
  id int ,
  name varchar(20)  not null,   -- 指定非空约束
  address varchar(20) not null  -- 指定非空约束
);
# 插入数据进行验证
insert into t_user6(id, name, address) values (1,null, null);
insert into t_user6(id, name, address) values (2,'a', null);
insert into t_user6(id, name, address) values (3, null, 'beijing');

drop table if exists t_user6;   -- 删除旧的t_user6表
create table if not exists t_user6 (
  id int ,
  name varchar(20),
  address varchar(20)
);

# 添加非空约束（更改表结构）
alter table t_user6 modify name varchar(20) not null ;
# 插入数据进行验证
insert into t_user6(id, name, address) values (1,null, null);
insert into t_user6(id, name, address) values (2,'a', null);
insert into t_user6(id, name, address) values (3, null, 'beijing');

# 删除非空约束
alter table t_user6 modify name varchar(20);
# 插入数据进行验证
insert into t_user6(id, name, address) values (1,null, null);
insert into t_user6(id, name, address) values (2,'a', null);
insert into t_user6(id, name, address) values (3, null, 'beijing');

# --- 6:添加唯一约束 ---#
drop table if exists t_user7;
# 添加唯一性约束（创建表的时候）
create table if not exists t_user7 (
 id int ,
 name varchar(20) ,
 phone_number varchar(20) unique  -- 指定唯一约束
);
# 插入数据进行验证
insert into t_user7(id, name, phone_number) values (1, 'a', '123456');
insert into t_user7(id, name, phone_number) values (1, 'a', '123456');  -- 添加相同的数据报错

drop table if exists t_user7;   -- 删除旧的表
create table if not exists t_user7 (
 id int ,
 name varchar(20) ,
 phone_number varchar(20)
);

# 添加唯一性约束（更改表的结构）
alter table t_user7 add constraint unique(phone_number);
# 插入数据进行验证
insert into t_user7(id, name, phone_number) values (1, 'a', '123456');
insert into t_user7(id, name, phone_number) values (1, 'a', '123456');  -- 添加相同的数据报错

# 删除唯一性约束
alter table t_user7 drop constraint phone_number;
# 插入数据进行验证
insert into t_user7(id, name, phone_number) values (1, 'a', '123456');
insert into t_user7(id, name, phone_number) values (1, 'a', '123456');  -- 添加相同的数据报错

# --- 7:添加默认约束 ---#
drop table if exists t_user8;
# 添加默认约束（创建表的时候）
create table if not exists t_user8 (
  id int ,
  name varchar(20) ,
  address varchar(20) default '北京' -- 指定默认约束
);

# 插入一些数据验证
insert into t_user8(id, name) values (1, 'a');
insert into t_user8(id, name) values (2, 'b');

drop table if exists t_user8;   -- 删除旧的表
create table if not exists t_user8 (
  id int ,
  name varchar(20) ,
  address varchar(20)
);

# 插入一些数据验证
insert into t_user8(id, name) values (1, 'a');
insert into t_user8(id, name) values (2, 'b');

# 添加默认值约束（更改表的结构）
alter table t_user8 modify address varchar(20) default '北京';
# 插入一些数据验证
insert into t_user8(id, name) values (3, 'c');
insert into t_user8(id, name) values (4, 'd');

# 删除默认值约束
alter table t_user8 modify address varchar(20) default null;
# 插入一些数据验证
insert into t_user8(id, name) values (5, 'e');
insert into t_user8(id, name) values (6, 'f');

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

/*
    窗口数函
    1. 开窗序号函数
    2. 开窗聚合函数
    3. 分布函数
    4. 前后函数
    5. 头尾函数
    6. 其他函数
 */
use mydb4;  -- 使用mydb4数据库

# --- 1:开窗序号函数 --- #

use mydb4;  -- 使用mydb4数据库
# 按着顺序标号
select *, row_number()  over (partition by DEPTNO order by SAL DESC) as rm from emp;
# 按着顺序标号，排序字段同值同序号，序号不连续
select *, rank() over (partition by DEPTNO order by SAL DESC) as rm from emp;
# 按着顺序标号，排序字段同值同序号，序号连续
select *, DENSE_RANK() over (partition by DEPTNO order by SAL DESC ) as rm from emp;
# 按部门分组后按工资降序，并添加组内序号，并显示出前3名
select * from (select *, rank() over (partition by DEPTNO order by SAL DESC) as rm from emp) as temp where temp.rm <= 3;
# 不进行【partition by】则默认整个数据为一组
select *, rank() over (order by SAL DESC) as rm from emp;

# --- 2:开窗聚合函数 --- #

use mydb4;  -- 使用mydb4数据库

# 1.按着部门进行分区金额累加
select *, sum(SAL) over (partition by DEPTNO order by SAL DESC) from emp;

# 2.按着部门进行分区金额累加（从开头加到当前行）
select *, sum(SAL) over (partition by DEPTNO order by SAL DESC rows between unbounded preceding and current row) from emp;

# 3.按着部门进行分区金额累加（从当前行加到最后）
select *, sum(SAL) over (partition by DEPTNO order by SAL DESC rows between current row and unbounded following) from emp;

# --- 3:分布函数 --- #

use mydb4;  -- 使用mydb4数据库
# 1.分组内查询工资小于、等于当前工资值的比例
select ENAME, DEPTNO, SAL, cume_dist()  over (partition by DEPTNO order by SAL ) as percent from emp;

# 2.不常用
select ENAME, DEPTNO, SAL, PERCENT_RANK()  over (partition by DEPTNO order by SAL ) as percent from emp;

# --- 4:前后函数 --- #

use mydb4;  -- 使用mydb4数据库
# 1.分组内排序查询与前一个人的工资差值
select ENAME, DEPTNO, SAL, SAL - lag(SAL, 1) over (partition by DEPTNO order by SAL) as sub from emp;
# 2.分组内排序查询与后一个人的工资差值
select ENAME, DEPTNO, SAL, SAL - lead(SAL, 1) over (partition by DEPTNO order by SAL) as sub from emp;

# --- 5:头尾函数 --- #

use mydb4;  -- 使用mydb4数据库
# 1.分组内排序查询当前为止本组内最后一个员工的工资
select ENAME, DEPTNO, SAL, last_value(sal) over (partition by DEPTNO order by SAL) as last from emp;
# 2.分组内排序查询当前为止本组内第一个员工的工资
select ENAME, DEPTNO, SAL, first_value(sal) over (partition by DEPTNO order by SAL) as last from emp;

# --- 6:其他函数 --- #

use mydb4;  -- 使用mydb4数据库
# 1.到目前为止，查询分组中员工工资最低的
select ENAME, DEPTNO, SAL, NTH_VALUE(sal, 1) over (partition by DEPTNO order by SAL) as tar_sal from emp;
# 2.分组内排序查询均分成三组。
select ENAME, DEPTNO, SAL, NTILE(3) over (partition by DEPTNO order by SAL) as classgroup from emp;

/*
    索引
    1.创建索引
    2.查看索引
    3.删除索引
    4.组合索引
    5.全文索引
    6.空间索引
 */

drop database if exists mydb6;  -- 删除旧的数据库
create database if not exists mydb6;    -- 创建新的数据库
use mydb6;  -- 使用数据库

# --- 1:创建索引 --- #

use mydb6;
# 1.创建表的时候直接指定
drop table if exists student2;
create  table if not exists student2(
    sid int primary key,
    card_id varchar(20),
    name varchar(20),
    gender varchar(20),
    age int,
    birth date,
    phone_num varchar(20),
    score double,
    unique index_card_id(card_id) -- 给card_id列创建索引
);

drop table if exists student2;  -- 删除旧的表
create  table if not exists student2(
    sid int primary key,
    card_id varchar(20),
    name varchar(20),
    gender varchar(20),
    age int,
    birth date,
    phone_num varchar(20),
    score double
);

# 2.创建唯一性索引（直接创建）
create unique index index_card_id on student2(card_id);

drop table if exists student2;  -- 删除旧的表
create  table if not exists student2(
    sid int primary key,
    card_id varchar(20),
    name varchar(20),
    gender varchar(20),
    age int,
    birth date,
    phone_num varchar(20),
    score double
);

# 3.创建唯一性索引（更改表结构）
alter table student2 add unique index_phone_num(phone_num);

# --- 2:查看索引 --- #

use mydb6;
# 1.查看指定数据库的索引
select * from mysql.`innodb_index_stats` a where a.`database_name` = 'mydb6' ;

# 2.查看指定表中的所有索引
show index from student2;

# --- 3:删除索引 --- #

use mydb6;
drop table if exists student;
create  table if not exists student(
    sid int primary key,
    card_id varchar(20),
    name varchar(20),
    gender varchar(20),
    age int,
    birth date,
    phone_num varchar(20),
    score double
);

# 添加联合索引前验证
show index from student;
# 给card_id和age分别添加一个普通索引
create index index_card_id on student(card_id);
create index index_age on student(age);
# 添加联合索引后验证
show index from student;

# 1.删除索引（直接删除）
drop index index_card_id on student;
# 删除索引后验证
show index from student;

# 2.删除索引（更改表结构）
alter table student drop index index_age;
# 验证索引后验证
show index from student;

# --- 4:组合索引 --- #

use mydb6;
drop table if exists student;
create  table if not exists student(
    sid int primary key,
    card_id varchar(20),
    name varchar(20),
    gender varchar(20),
    age int,
    birth date,
    phone_num varchar(20),
    score double
);

# 创建联合索引前验证
show index from student;
# 1.创建phone_num，name的联合索引
create index index_phone_name on student(phone_num,name);
# 创建联合索引后验证
show index from student;

# 删除索引
 drop index index_phone_name on student;
# 删除联合索引后验证
show index from student;

# --- 5:全文索引 --- #

use mydb6;  -- 重置使用数据库
drop table if exists t_article;
create table if not exists t_article (
     id int primary key auto_increment ,
     title varchar(255) ,
     content varchar(1000) ,
     writing_date date -- ,
     -- fulltext (content) -- 创建全文检索
);

# 添加数据
insert into t_article values(null,"Yesterday Once More","When I was young I listen to the radio",'2021-10-01');
insert into t_article values(null,"Right Here Waiting","Oceans apart, day after day,and I slowly go insane",'2021-10-02');
insert into t_article values(null,"My Heart Will Go On","every night in my dreams,i see you, i feel you",'2021-10-03');
insert into t_article values(null,"Everything I Do","eLook into my eyes,You will see what you mean to me",'2021-10-04');
insert into t_article values(null,"Called To Say I Love You","say love you no new year's day, to celebrate",'2021-10-05');
insert into t_article values(null,"Nothing's Gonna Change My Love For You","if i had to live my life without you near me",'2021-10-06');
insert into t_article values(null,"Everybody","We're gonna bring the flavor show U how.",'2021-10-07');

# 创建全文索引前验证
show index from t_article;
# 创建全文索引（更改表结构）
alter table t_article add fulltext index_content(content);
# 创建全文索引后验证
show index from t_article;

# 删除全文索引
drop index index_content on t_article;
# 删除全文索引后验证
show index from t_article;

# 创建全文索引（直接创建）
create fulltext index index_content on t_article(content);
# 创建全文索引后验证
show index from t_article;

# 使用索引
select * from t_article where match(content) against('yo'); -- 没有结果
select * from t_article where match(content) against('you'); -- 有结果
select * from t_article where content like '%you%'; -- 有结果

# 查看各个引擎的全文索引最小、最大长度
show variables like '%ft%';

# --- 6:空间索引 --- #

use mydb6;  -- 重置使用数据库
create table shop_info (
    id  int  primary key auto_increment comment 'id',
    shop_name varchar(64) not null comment '门店名称',
	geom_point geometry not null comment '经纬度',
    spatial key geom_index(geom_point)
);

# 创建空间索引后验证
show index from shop_info;

/*
    事务
    1.开启、提交事务
    2.事务的隔离等级
 */

drop database if exists mydb7;  -- 删除旧的数据库
create database if not exists mydb7;    -- 创建新的数据库
use mydb7;
# 创建账户表
create table account(
	id int primary key, -- 账户id
	name varchar(20), -- 账户名
	money double -- 金额
);
#  插入数据
insert into account values(1,'zhangsan',1000);
insert into account values(2,'lisi',1000);

# --- 1:开启、提交事务 --- #

# 查看当前的自动提交状态
select @@autocommit;
# 设置手动进行提交
set autocommit = 0;
# 查看当前的自动提交状态
select @@autocommit;

# 查看数据库初始状态
select * from account;

# 开启事务-模拟用户转账
begin;  -- 开启事务
update account set money = money - 200 where name = 'zhangsan'; -- 张三账户-200
update account set money = money + 200 where name = 'lisi'; -- 李四账户+200
commit; -- 提交事务

# 查看数据库状态
select * from account;

# 回滚事务-回滚失败，只能回滚到最后一次commit
rollback;
select * from account;

# 中途进行回滚
begin;  -- 开启事务
update account set money = money - 200 where name = 'zhangsan'; -- 张三账户-200
update account set money = money + 200 where name = 'lisi'; -- 李四账户+200
rollback ;

# 查看数据库状态-回滚成功
select * from account;

# --- 2:事务隔离等级 --- #

# 查看事务的隔离级别
show variables like '%isolation%';

-- 设置read uncommitted - 这种隔离级别会引起脏读，A事务读取到B事务没有提交的数据
set session transaction isolation level read uncommitted;
show variables like '%isolation%';

-- 设置read committed - 这种隔离级别会引起不可重复读，A事务在没有提交事务之前，可看到数据不一致
set session transaction isolation level read committed;
show variables like '%isolation%';

-- 设置repeatable read （MySQ默认的） - 这种隔离级别会引起幻读，A事务在提交之前和提交之后看到的数据不一致
set session transaction isolation level repeatable read;
show variables like '%isolation%';

-- 设置serializable - 这种隔离级别比较安全，但是效率低，A事务操作表时，表会被锁起，B事务不能操作。
set session transaction isolation level serializable;
show variables like '%isolation%';

/*
    优化和日志
    查看SQL执行类型统计
    查看执行计划
    查看日志
    索引失效问题
 */

# --- 数据准备 --- #

drop database if exists mydb8;
create database if not exists mydb8;
use mydb8;

drop table if exists dept;  -- 删除dept表
drop table  if exists emp;  -- 删除emp表
drop table if exists salgrade;  -- 删除salgrade表

# 创建DEPT表
CREATE TABLE  if not exists DEPT
       (DEPTNO int(2) not null ,
	DNAME VARCHAR(14) ,
	LOC VARCHAR(13),
	primary key (DEPTNO)
	);

# 创建EMP表
CREATE TABLE if not exists EMP
       (EMPNO int(4)  not null ,
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	MGR INT(4),
	HIREDATE DATE  DEFAULT NULL,
	SAL DOUBLE(7,2),
	COMM DOUBLE(7,2),
	primary key (EMPNO),
	DEPTNO INT(2)
	)
	;

# 创建SALGRADE表
CREATE TABLE if not exists SALGRADE
      ( GRADE INT,
	LOSAL INT,
	HISAL INT );

# 添加DEPT表相关数据
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
30, 'SALES', 'CHICAGO');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
40, 'OPERATIONS', 'BOSTON');

# 添加EMP表相关数据
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7369, 'SMITH', 'CLERK', 7902,  '1980-12-17'
, 800, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7499, 'ALLEN', 'SALESMAN', 7698,  '1981-02-20'
, 1600, 300, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7521, 'WARD', 'SALESMAN', 7698,  '1981-02-22'
, 1250, 500, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7566, 'JONES', 'MANAGER', 7839,  '1981-04-02'
, 2975, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7654, 'MARTIN', 'SALESMAN', 7698,  '1981-09-28'
, 1250, 1400, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7698, 'BLAKE', 'MANAGER', 7839,  '1981-05-01'
, 2850, NULL, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7782, 'CLARK', 'MANAGER', 7839,  '1981-06-09'
, 2450, NULL, 10);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7788, 'SCOTT', 'ANALYST', 7566,  '1987-04-19'
, 3000, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7839, 'KING', 'PRESIDENT', NULL,  '1981-11-17'
, 5000, NULL, 10);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7844, 'TURNER', 'SALESMAN', 7698,  '1981-09-08'
, 1500, 0, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7876, 'ADAMS', 'CLERK', 7788,  '1987-05-23'
, 1100, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7900, 'JAMES', 'CLERK', 7698,  '1981-12-03'
, 950, NULL, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7902, 'FORD', 'ANALYST', 7566,  '1981-12-03'
, 3000, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7934, 'MILLER', 'CLERK', 7782,  '1982-01-23'
, 1300, NULL, 10);

# 添加SALGRADE表数据
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
1, 700, 1200);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
2, 1201, 1400);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
3, 1401, 2000);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
4, 2001, 3000);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
5, 3001, 9999);

# --- 1:查看SQL执行类型 --- #

use mydb8;  -- 重置使用数据库
# 1.查看当前会话SQL执行类型的统计信息
show session status like 'Com_______';

# 2.查看全局（自从上次MySQL服务器启动至今）执行类型的统计信息
show global status like 'Com_______';

# 3.查看针对InnoDB引擎的统计信息
show status like 'Innodb_rows_%';

# --- 2:查看执行计划 --- #

use mydb8;  -- 重置使用数据库

# 查看执行计划1
explain select * from emp join dept d on emp.DEPTNO = d.DEPTNO;
/*
    /* select#1 *\/ select
    `test`.`emp`.`EMPNO` AS `EMPNO`,
    `test`.`emp`.`ENAME` AS `ENAME`,
    `test`.`emp`.`JOB` AS `JOB`,`test`.`emp`.`MGR` AS `MGR`,
    `test`.`emp`.`HIREDATE` AS `HIREDATE`,
    `test`.`emp`.`SAL` AS `SAL`,
    `test`.`emp`.`COMM` AS `COMM`,
    `test`.`emp`.`DEPTNO` AS `DEPTNO`,
    `test`.`d`.`DEPTNO` AS `DEPTNO`,
    `test`.`d`.`DNAME` AS `DNAME`,
    `test`.`d`.`LOC` AS `LOC`
    from `test`.`emp`
    join `test`.`dept` `d`
    where (`test`.`emp`.`DEPTNO` = `test`.`d`.`DEPTNO`)
*/

# 查看执行计划2
explain select * from emp join dept d on emp.DEPTNO = d.DEPTNO where SAL > 200 order by SAL;
/*
 /* select#1 *\/
 select
     `mydb8`.`emp`.`EMPNO` AS `EMPNO`,
     `mydb8`.`emp`.`ENAME` AS `ENAME`,
     `mydb8`.`emp`.`JOB` AS `JOB`,
     `mydb8`.`emp`.`MGR` AS `MGR`,
     `mydb8`.`emp`.`HIREDATE` AS `HIREDATE`,
     `mydb8`.`emp`.`SAL` AS `SAL`,
     `mydb8`.`emp`.`COMM` AS `COMM`,
     `mydb8`.`emp`.`DEPTNO` AS `DEPTNO`,
     `mydb8`.`d`.`DEPTNO` AS `DEPTNO`,
     `mydb8`.`d`.`DNAME` AS `DNAME`,
     `mydb8`.`d`.`LOC` AS `LOC`
  from
    `mydb8`.`emp`
  join
    `mydb8`.`dept` `d`
  where
    ((`mydb8`.`emp`.`DEPTNO` = `mydb8`.`d`.`DEPTNO`)
  and
    (`mydb8`.`emp`.`SAL` > 200))
  order by
    `mydb8`.`emp`.`SAL`
*/

# --- 3:查看日志 --- #

# 1.查看是否开启了错误日志
show variables like 'log_bin';

# 2.查看所有的日志
show binlog events;

# 3.查看binlog日志的格式
show variables like 'binlog_format';

# 4.查询指定的日志
show binlog events in 'binlog.000385';

# 4.查看最新的日志
show master status ;

# 6.查看错误日志
show variables like 'log_error%';

# 7.查看是否开启了查询日志
show variables like 'general_log';

# 8.开启查询日志
set global  general_log=1;
# 验证是否开启了查询日志
show variables like 'general_log';

# 9.查看慢日志配置信息
show variables like '%slow_query_log%';

# 10.开启慢日志
set global slow_query_log = 1;
# 验证是否开启了慢日志
show variables like '%slow_query_log%';

# 11.查看慢日志记录SQL的最低阈值时间
show variables like '%long_query_time%';

# 12.设置慢日志的最低阈值时间
set global long_query_time = 5;

# 13.查看当前客户端连接服务器的线程执行状态信息
show processlist;

# --- 4:索引失效问题 --- #
drop database if exists mydb9;
create database if not exists mydb9;
use mydb9;

drop table if exists product;
#--- 创建商品表 ---
create table if not exists product(
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

# 创建联合索引
create index idx_pn_pr_catid on product(pname, price, category_id);
# 验证创建了索引
show index from product;

# 1.单独使用pname字段-Using index
explain select pname, price, category_id from product where pname = '劲霸休闲裤';

# 2.使用pname和price字段做等值查询-Using index
explain select pname, price, category_id from product where pname = '劲霸休闲裤' and price = 266;

# 3.使用pname、price和category-id字段做等值查询-Using index(execution: 4 ms, fetching: 91 ms)
explain select pname, price, category_id from product where pname = '劲霸休闲裤' and price = 266 and category_id = 'c002';

# 4.条件不按索引顺序-Using index(execution: 4 ms, fetching: 40 ms)
explain select pname, price, category_id from product where category_id = 'c002' and price = 266 and pname = '劲霸休闲裤';

# 5.不使用pname字段-Using where; Using index
explain select  price, category_id from product where price = 266 and category_id = 'c002';

# 6.使用pname和category_id两个字段-Using where; Using index
explain select pname, price, category_id from product where pname = '劲霸休闲裤' and category_id = 'c002';

# 7.使用所有三个字段，pname和category_id做等值查询，price做范围查询-Using where; Using index
explain select pname, price, category_id from product where pname = '劲霸休闲裤' and price > 266 and category_id = 'c002';

# 8.使用所有三个字段，pname做模糊查询，price和category_id做等值查询-Using where; Using index
explain select pname, price, category_id from product where pname like '劲%' and price = 266 and category_id = 'c002';

# 9.提供大数据自己进行测试
drop table if exists test_order;
create table if not exists test_order
(
    id int auto_increment primary key,
    user_id int,
    order_id int,
    order_status tinyint,
    create_date datetime
);

drop table if exists test_orderdetail;
create table if not exists test_orderdetail
(
    id int auto_increment primary key,
    order_id int,
    product_name varchar(100),
    cnt int,
    create_date datetime
);

# 创建user_id,order_id,create_date联合索引
create index idx_userid_order_id_createdate on test_order(user_id,order_id,create_date);
# 创建order_id,product_name联合索引
create index idx_orderid_productname on test_orderdetail(order_id,product_name);

# 添加数据
CREATE DEFINER=`root`@`%` PROCEDURE `test_insertdata`(IN `loopcount` INT)
    LANGUAGE SQL
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    declare v_uuid  varchar(50);
    while loopcount>0 do
        set v_uuid = uuid();
        insert into test_order (user_id,order_id,order_status,create_date) values (rand()*1000,id,rand()*10,DATE_ADD(NOW(), INTERVAL - RAND()*20000 HOUR));
        insert into test_orderdetail(order_id,product_name,cnt,create_date) values (rand()*100000,v_uuid,rand()*10,DATE_ADD(NOW(), INTERVAL - RAND()*20000 HOUR));
        set loopcount = loopcount -1;
    end while;
END
CALL test_insertdata(500000);   -- 启动添加程序

# 查看数据
select * from test_orderdetail;
select * from test_order;


/*
    综合25道练习题
 */
drop database if exists mydb10;
create database if not exists mydb10;
use mydb10;

drop table if exists dept;  -- 删除dept表
drop table  if exists emp;  -- 删除emp表
drop table if exists salgrade;  -- 删除salgrade表

# 创建DEPT表
CREATE TABLE  if not exists DEPT
       (DEPTNO int(2) not null ,
	DNAME VARCHAR(14) ,
	LOC VARCHAR(13),
	primary key (DEPTNO)
	);

# 创建EMP表
CREATE TABLE if not exists EMP
       (EMPNO int(4)  not null ,
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	MGR INT(4),
	HIREDATE DATE  DEFAULT NULL,
	SAL DOUBLE(7,2),
	COMM DOUBLE(7,2),
	primary key (EMPNO),
	DEPTNO INT(2)
	)
	;

# 创建SALGRADE表
CREATE TABLE if not exists SALGRADE
      ( GRADE INT,
	LOSAL INT,
	HISAL INT );

# 添加DEPT表相关数据
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
30, 'SALES', 'CHICAGO');
INSERT INTO DEPT ( DEPTNO, DNAME, LOC ) VALUES (
40, 'OPERATIONS', 'BOSTON');

# 添加EMP表相关数据
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7369, 'SMITH', 'CLERK', 7902,  '1980-12-17'
, 800, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7499, 'ALLEN', 'SALESMAN', 7698,  '1981-02-20'
, 1600, 300, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7521, 'WARD', 'SALESMAN', 7698,  '1981-02-22'
, 1250, 500, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7566, 'JONES', 'MANAGER', 7839,  '1981-04-02'
, 2975, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7654, 'MARTIN', 'SALESMAN', 7698,  '1981-09-28'
, 1250, 1400, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7698, 'BLAKE', 'MANAGER', 7839,  '1981-05-01'
, 2850, NULL, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7782, 'CLARK', 'MANAGER', 7839,  '1981-06-09'
, 2450, NULL, 10);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7788, 'SCOTT', 'ANALYST', 7566,  '1987-04-19'
, 3000, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7839, 'KING', 'PRESIDENT', NULL,  '1981-11-17'
, 5000, NULL, 10);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7844, 'TURNER', 'SALESMAN', 7698,  '1981-09-08'
, 1500, 0, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7876, 'ADAMS', 'CLERK', 7788,  '1987-05-23'
, 1100, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7900, 'JAMES', 'CLERK', 7698,  '1981-12-03'
, 950, NULL, 30);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7902, 'FORD', 'ANALYST', 7566,  '1981-12-03'
, 3000, NULL, 20);
INSERT INTO EMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM,
DEPTNO ) VALUES (
7934, 'MILLER', 'CLERK', 7782,  '1982-01-23'
, 1300, NULL, 10);

# 添加SALGRADE表数据
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
1, 700, 1200);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
2, 1201, 1400);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
3, 1401, 2000);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
4, 2001, 3000);
INSERT INTO SALGRADE ( GRADE, LOSAL, HISAL ) VALUES (
5, 3001, 9999);

# 1.取得每个部门最高薪水的人员名称,将以上的查询结果当做一张临时表t,t和emp表连接，条件：t.deptno = e.deptno and t.maxsal = e.sal
select
        e.ENAME, e.EMPNO, e.JOB, e.SAL, e.COMM, e.DEPTNO
from
        emp e
join
        (select deptno, max(sal) as maxsal from emp group by deptno) temp
on
        temp.deptno = e.deptno and temp.maxsal = e.sal
order by
        e.DEPTNO;

# 2.哪些人的薪水在部门的平均薪水之上?
select
        e.ENAME, e.EMPNO, e.JOB, e.SAL, e.COMM, e.DEPTNO, round(t.avgsal, 2) as avg
from
        emp e
join
        (select e.deptno,avg(e.sal) as avgsal from emp e group by e.deptno) t
on
        t.deptno = e.deptno
where
        sal > t.avgsal
order by
        DEPTNO;

# 3.取得部门中（所有人的）平均的薪水等级?
select
        e.deptno, avg(s.grade) as avg_grade
from
        emp e
join
        salgrade s
on
        e.sal
between
        s.losal and s.hisal
group by
        e.deptno
order by
        DEPTNO;

# 4.不准用函数（Max），取得最高薪水?
# 解1
select
        e.ENAME, e.EMPNO, e.JOB, e.SAL, e.COMM, e.DEPTNO as max_sal
from
        emp e
where
        sal
not in
        (select distinct a.sal from emp a join emp b on a.sal < b.sal);
# 解2
select
        e.ENAME, e.EMPNO, e.JOB, e.SAL, e.COMM, e.DEPTNO as max_sal
from
        emp e
order by sal desc limit 1;

# 5.取得平均薪水最高的部门的部门编号?
select
        DEPTNO, avg(SAL) avg_sal
from
        emp e
group by
        e.DEPTNO
order by
        avg_sal DESC
limit 1;


# 6.取得平均薪水最高的部门的部门名称?
select d.DNAME, t.avg_sal from dept d join (select
        DEPTNO, round(avg(SAL), 2) avg_sal
from
        emp e
group by
        e.DEPTNO
order by
        avg_sal DESC
limit 1) as t
ON d.DEPTNO = t.DEPTNO;

# 7.求平均薪水的等级最低的部门的部门名称？
 select d.DNAME, t.avg_sal from dept d join (select
        DEPTNO, round(avg(SAL), 2) avg_sal
from
        emp e
group by
        e.DEPTNO
order by
        avg_sal
limit 1) as t
ON d.DEPTNO = t.DEPTNO;

# 8.取得薪水最高的前五名员工？
select
	e.ENAME, e.EMPNO, e.JOB, e.SAL, e.COMM, e.DEPTNO
from
	emp e
order by
	e.sal desc
limit
	5;

# 9.取得薪水最高的第六到第十名员工?
select
	e.ENAME, e.EMPNO, e.JOB, e.SAL, e.COMM, e.DEPTNO
from
	emp e
order by
	e.sal desc
limit
	6, 5;

# 10.取得最后入职的 5 名员工?
select
	e.ename,e.hiredate
from
	emp e
order by
	e.HIREDATE desc
limit
	5;

# 11.取得每个薪水等级有多少员工
select
	t.grade, count(t.grade) as count
from
	(select s.grade from emp e join salgrade s on e.sal between s.losal and s.hisal) t
group by
	t.grade;

# 12.出受雇日期早于其直接上级的所有员工的编号,姓名,部门名称?
select
	a.empno,
	a.ename,
	a.hiredate,
	a.mgr,
	b.hiredate,
	d.dname
from
	emp a
join
	emp b
on
	a.mgr = b.empno
join
	dept d
on
	d.DEPTNO = a.deptno
where
	a.hiredate <b.hiredate;

# 13.列出部门名称和这些部门的员工信息, 同时列出那些没有员工的部门?
select
	e.*,d.dname
from
	emp e
right join
	dept d
on
	e.deptno = d.deptno;

# 14.列出至少有 5 个员工的所有部门？
select
	d.dname,
	count(e.ename) count
from
	emp e
join
	dept d
on
	e.deptno = d.deptno
group by
	d.deptno
having
	count(e.ename) >= 5;

# 15.列出薪金比"SMITH" 多的所有员工信息?
select
	e.*
from
	emp e
where
	e.sal > (select e.sal from emp e where ename = 'SMITH')
order by
    SAL;

# 16.列出所有"CLERK"(办事员) 的姓名及其部门名称, 部门的人数?
select
    tb1.*, tb2.count
from
    (select e.ename, e.mgr, e.JOB, e.hiredate, d.dname
    from emp e join dept d on e.DEPTNO = d.DEPTNO where e.JOB = 'CLERK') tb1
join
    (select d.DNAME, count(1) count from emp e join dept d on e.DEPTNO = d.DEPTNO group by d.DNAME) tb2
on
    tb1.DNAME = tb2.DNAME;

# 17.列出最低薪金大于 1500 的各种工作及从事此工作的全部雇员人数
select
	e.job,
	count(*) count
from
	emp e
group by
	e.job
having
	min(e.sal) > 1500;

# 18.列出所有部门的详细信息和人数
select
    d.deptno,
    d.dname,
    d.loc,
    count(e.ename) as count
from
	emp e
right join
	dept d
on
	d.deptno = e.deptno
group by
	d.deptno,d.dname,d.loc
order by count;

# 19.列出各个部门的 MANAGER(领导)的最低薪金
select
     e.ename, e.mgr, e.JOB, d.DNAME, e.SAL
from
     emp e
join
     dept d
on
     e.DEPTNO = d.DEPTNO where JOB='MANAGER'
order by
     SAL
limit 1;

# 20.求出员工领导的薪水超过 3000 的员工名称与领导名称
select tb1.sal, tb1.ename, tb2.ename MANAGER from
(select e.SAL, e.ENAME, e.DEPTNO from emp e where SAL >= 3000) tb1 join
(select e.ENAME, e.DEPTNO from emp e  where e.JOB = 'manager') tb2 on
tb1.DEPTNO = tb2.DEPTNO;

# 21.列出在每个部门工作的员工数量,平均工资和平均服务期限?
select
     count(1) count, round(avg(e.SAL), 2) sal, avg(datediff(NOW(), e.HIREDATE)) hiredate
from
     emp e
group by
     e.DEPTNO;

# 22.列出与"SCOTT"从事相同工作的所有员工及部门名称?
select
     e.ename, e.mgr, e.JOB, e.hiredate, d.dname
from
     emp e
join
     dept d
on
     e.DEPTNO = d.DEPTNO
where
     e.job = (select job from emp where ENAME = 'SCOTT');

# 23.列出在部门"SALES"<销售部>工作的员工的姓名,假定不知道销售部的部门编号
select
     e.ENAME, d.DEPTNO, DNAME
from
     emp e
join
     dept d
on
     e.DEPTNO = d.DEPTNO
where
     d.DNAME = 'SALES';

# 24.列出所有员工的年工资,按年薪从低到高排序
select
     empno, ename, job, mgr, hiredate, sal * 12 as sal, comm, deptno
from
     emp e
order by
     sal;

# 25.给任职日期超过 40 年的员工加薪 10%
select
     empno, ename, job, mgr, hiredate, sal * 1.1 as sal, comm, deptno
from
     emp e
where
     datediff(NOW(), e.HIREDATE) / 365 >= 40
order by
     sal;