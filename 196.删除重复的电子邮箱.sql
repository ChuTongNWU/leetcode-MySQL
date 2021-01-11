编写一个 SQL 查询，来删除 Person 表中所有重复的电子邮箱，重复的邮箱里只保留 Id 最小 的那个。

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id 是这个表的主键。
例如，在运行你的查询语句之后，上面的 Person 表应返回以下几行:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+


思路：
要使用delete
delete 使用别名时要在delete 和from 之间加上删除表的别名
不能对同一张表进行delete 和 select 操作，所以会报错
可以参考https://blog.csdn.net/qq_29672495/article/details/72668008

方法1：
delete p1 from person p1, person p2
where p1.email = p2.email and p1.id > p2.id

方法2：
delete p
	from Person p 
	where p.Id in (
		select a.Id 
		from (
			select p1.Id 
			from Person p1, Person p2 
			where p1.Email = p2.Email and p1.id > p2.id) as a);