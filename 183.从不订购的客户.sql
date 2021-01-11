两张表，寻找order表里没有的客户

某网站包含两个表，Customers 表和 Orders 表。编写一个 SQL 查询，找出所有从不订购任何东西的客户。

Customers 表：

+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders 表：

+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
例如给定上述表格，你的查询应返回：

+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/customers-who-never-order
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

方法1：获得order表里有订单的客户id，再找客户表里不在这个临时表的客户名
select Name as Customers
from Customers
where Id not in (select distinct CustomerId
                from Orders)


方法2：将两个表进行左连接,如果订单里没有那么就是空，用where筛选出为空的名字就可以
但是切忌，不能在on 里面进行空的判断，因为是因为左连接之后才有的空，才会连接的结果进行筛选；
select Name as Customers
from Customers c left join Orders d
    on c.Id = d.CustomerId
where d.CustomerId is NULL