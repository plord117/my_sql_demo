/*
    窗口函数
    1. 开窗序号函数
    2. 开窗聚合函数
    3. 分布函数
    4. 前后函数
    5. 头尾函数
    6. 其他函数
 */
use mydb4;  -- 使用mydb4数据库

# --- 1:开窗序号函数 --- #

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

# 1.按着部门进行分区金额累加
select *, sum(SAL) over (partition by DEPTNO order by SAL DESC) from emp;

# 2.按着部门进行分区金额累加（从开头加到当前行）
select *, sum(SAL) over (partition by DEPTNO order by SAL DESC rows between unbounded preceding and current row) from emp;

# 3.按着部门进行分区金额累加（从当前行加到最后）
select *, sum(SAL) over (partition by DEPTNO order by SAL DESC rows between current row and unbounded following) from emp;

# --- 3:分布函数 --- #
# 1.分组内查询工资小于、等于当前工资值的比例
select ENAME, DEPTNO, SAL, cume_dist()  over (partition by DEPTNO order by SAL ) as percent from emp;

# 2.不常用
select ENAME, DEPTNO, SAL, PERCENT_RANK()  over (partition by DEPTNO order by SAL ) as percent from emp;

# --- 4:前后函数 --- #

# 1.分组内排序查询与前一个人的工资差值
select ENAME, DEPTNO, SAL, SAL - lag(SAL, 1) over (partition by DEPTNO order by SAL) as sub from emp;
# 2.分组内排序查询与后一个人的工资差值
select ENAME, DEPTNO, SAL, SAL - lead(SAL, 1) over (partition by DEPTNO order by SAL) as sub from emp;

# --- 5:头尾函数 --- #

# 1.分组内排序查询当前为止本组内最后一个员工的工资
select ENAME, DEPTNO, SAL, last_value(sal) over (partition by DEPTNO order by SAL) as last from emp;
# 2.分组内排序查询当前为止本组内第一个员工的工资
select ENAME, DEPTNO, SAL, first_value(sal) over (partition by DEPTNO order by SAL) as last from emp;

# --- 6:其他函数 --- #

# 1.到目前为止，查询分组中员工工资最低的
select ENAME, DEPTNO, SAL, NTH_VALUE(sal, 1) over (partition by DEPTNO order by SAL) as tar_sal from emp;
# 2.分组内排序查询均分成三组。
select ENAME, DEPTNO, SAL, NTILE(3) over (partition by DEPTNO order by SAL) as classgroup from emp;