Employee 表包含所有员工，他们的经理也属于员工。每个员工都有一个 Id，此外还有一列对应员工的经理的 Id。

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
给定 Employee 表，编写一个 SQL 查询，该查询可以获取收入超过他们经理的员工的姓名。在上面的表格中，Joe 是唯一一个收入超过他的经理的员工。

+----------+
| Employee |
+----------+
| Joe      |
+----------+


代码
方法一：用join，是做n*n的笛卡尔乘积，然后再筛选，
select e1.Name as Employee
from Employee e1 join Employee e2
    on e1.ManagerID = e2.Id
where e1.Salary > e2.Salary

方法二：使用笛卡尔乘积获得信息后，进行两次判断筛选
select e1.Name as Employee
from Employee e1, Employee e2
where  e1.ManagerID = e2.Id and e1.Salary > e2.Salary

方法三：对于每一个外层的表格信息，查找内部的Id和外部ManagerId相等的员工的薪水，并使用where筛选薪资大于经理的
select Name as Employee
from Employee e
where　Salary > (select Salary from Employee where Id = e.ManagerID)