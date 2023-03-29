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