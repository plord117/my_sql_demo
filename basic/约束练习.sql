/*
    约束
    1.主键约束
    2.自增长约束
    3.零填充约束
    4.外键约束
    5.非空约束
    6.唯一约束
    7.默认值约束 */
drop database if exists mydb5;  -- 删除旧的数据库
create database if not exists mydb5;    -- 创建数据库mydb5
use mydb5;  -- 使用数据库


# --- 1:添加主键约束 ---#

drop table if exists t_user1;
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