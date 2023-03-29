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