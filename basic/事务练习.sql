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