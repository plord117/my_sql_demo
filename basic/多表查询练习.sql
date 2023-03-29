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