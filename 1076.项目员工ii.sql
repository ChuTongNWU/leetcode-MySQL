Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
主键为 (project_id, employee_id)。
employee_id 是员工表 Employee 表的外键。

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
主键是 employee_id。

编写一个SQL查询，报告所有雇员最多的项目。

查询结果格式如下所示：

Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+

Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

Result table:
+-------------+
| project_id  |
+-------------+
| 1           |
+-------------+
第一个项目有3名员工，第二个项目有2名员工。

查询员工最多的项目

方法1：
	按照项目id分组，项目id中所有的数大于等于所有的，all后面可以写子查询，
SELECT p.project_id FROM project p
GROUP BY p.project_id
HAVING COUNT(p.employee_id) >=
ALL(SELECT COUNT(p.employee_id) OVER(PARTITION BY p.project_id) FROM project p);

方法2：
	生成一个临时表，再对临时表进行计算
with
t as(
    select count(*) as c, p.project_id
    from leetcode.project p
    group by project_id
)

select project_id
from t
where t.c = (select max(c) from t);

方法3：
	对计算的每个项目的人数排序，并取最大的人数；
select project_id
from (select project_id,
            rank() over(order by count(employee_id) DESC) as r
        from leetcode.project
        group by project_id) as a
where r = 1;

知识点：
1.all：对于子查询返回的列中的所有值，如果比较结果为true，则返回true
2.any：对于子查询返回的列中的任一数值，如果比较结果为true，则返回true
3.with...as ：生成一个临时表

