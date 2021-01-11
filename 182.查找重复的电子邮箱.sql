编写一个 SQL 查询，查找 Person 表中所有重复的电子邮箱。

示例：

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
根据以上输入，你的查询应返回以下结果：

+---------+
| Email   |
+---------+
| a@b.com |
+---------+



方法1：按照电子邮箱分组，判断次数超过2，则为重复的
# Write your MySQL query statement below
select Email
from Person
group by Email
having count(Email) > 1

方法2：进行笛卡尔乘积，选择id不想等且email相等
SELECT DISTINCT P1.EMAIL
FROM PERSON AS P1
INNER JOIN PERSON AS P2
ON P1.ID > P2.ID
AND P1.EMAIL = P2.EMAIL

知识点：
where > group by > having > order by

