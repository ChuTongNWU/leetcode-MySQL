编写一个 SQL 查询，获取 Employee 表中第二高的薪水（Salary） 。

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
例如上述 Employee 表，SQL查询应该返回 200 作为第二高的薪水。如果不存在第二高的薪水，那么查询应返回 null。

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+


代码

# Write your MySQL query statement below
select Salary as SecondHighestSalary
from Employee
order by Salary DESC
limit 1, 1

然后这样写是错误的，当没有第二高的薪资的时候，答案会错误；
因此可以将其作为临时表,因为
select null 会返回null值

方法一：
select
	(select distinct Salary
	from Employee
	order by Salary DESC
	limit 1, 1
		) as SecondHighestSalary

方法二：
select ifnull((select distinct Salary
				from Employee
				order by Salary DESC
				limit 1, 1), null) as SecondHighestSalary

方法三：首先获得薪资最大的数，使用where将小于最大的数都挑选出来，然后使用max在其他数字中选择最大的
select max(distinct Salary) as SecondHighestSalary
from Employee
where Salary < (select max(Salary) from Employee)


知识点：
1.limit n 表示查询结果返回前n条数据
  limit m offset n 表示查询结果跳过n条数据，读取前m条数据
  limit m,n 表示查询结果从第m个开始，获取n条数据

2.ifnull(a, b)：表示如果值不是空，则返回a；是空，则返回b

3.distinct：过滤重复的关键字