题目描述
Table: Project

Column Name	Type
project_id	int
employee_id	int
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.

Table: Employee

Column Name	Type
employee_id	int
name	varchar
experience_years	int
employee_id is the primary key of this table.

Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

The query result format is in the following example:

Project table:

project_id	employee_id
1	1
1	2
1	3
2	1
2	4
Employee table:

employee_id	name	experience_years
1	Khaled	3
2	Ali	2
3	John	1
4	Doe	2
Result table:

project_id	average_years
1	2.00
2	2.50
The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 and for the second project is (3 + 2) / 2 = 2.50
查询每个项目的所有员工的平均工作年限，四舍五入到2位数字。

思路：
	项目表和员工表左连接，按照项目分组，将项目后面的年限加起来，然后除以count

select p.project_id, round(sum(e.experience_years)/count(e.employee_id), 2) as average_years
from project p left join employee e
    on p.employee_id = e.employee_id
group by p.project_id


方法2：使用avg函数求平均
SELECT a.project_id, round(avg(b.experience_years),2) AS average_years FROM Project AS a
JOIN Employee AS b
ON a.employee_id = b.employee_id
GROUP BY a.project_id;