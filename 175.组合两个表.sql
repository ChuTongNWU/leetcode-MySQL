表1: Person

+-------------+---------+
| 列名         | 类型     |
+-------------+---------+
| PersonId    | int     |
| FirstName   | varchar |
| LastName    | varchar |
+-------------+---------+
PersonId 是上表主键
表2: Address

+-------------+---------+
| 列名         | 类型    |
+-------------+---------+
| AddressId   | int     |
| PersonId    | int     |
| City        | varchar |
| State       | varchar |
+-------------+---------+
AddressId 是上表主键


代码：

# Write your MySQL query statement below
select FirstName, LastName, City, State
from Person p left join Address ad
    on p.PersonID = ad.PersonID


知识点：
1.使用left join时，on和where条件的区别：
	on：条件用于生成临时表，不管on的条件是否为真，都会返回左边表中的记录
	where：在临时表生成之后，再对临时表进行过滤的条件
2.如果字段名是唯一的，那么可以不加表名；