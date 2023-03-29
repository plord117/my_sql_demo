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