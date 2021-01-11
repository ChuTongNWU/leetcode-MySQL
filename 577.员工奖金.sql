Employee表中，empId 是主键。
+-----------+-----------+------------+--------------+
| empId	| name | supervisor | salary |
+-----------+-----------+------------+--------------+
| 1	    | john  | 3         | 1000   |
| 2     | dan   | 3         | 2000   |
| 3     | brad  | null      | 4000   |
| 4     | thomas| 3         | 4000   |
+-----------+-----------+------------+--------------+

Table: Employee
表二：Bonus
+-----------+-----------+
|empId | bonus |
+-----------+-----------+
| 2    | 500   |
| 4    | 2000  |
+-----------+-----------+
Bonus 表中 empId 是主键。


Table: Bonus

二、题目信息
选出奖金小于1000元的员工姓名及其获得的奖金数。

方法1：
	选出来的要包括没有奖金的以及有但是小于1000 的
	子查询查找奖金大于1000的id，外层查询找没在这些id里的
select e.empid, b.bonus
from employee e left join bonus b
    on e.empid = b.empid
where e.empid not in (select b.empid from bonus where b.bonus >= 1000);

方法2：
	和奖金表做左连接，筛选条件是当奖金为空或者奖金小于1000
select e.empid, bonus
from employee e left join bonus b
    on e.empid = b.empid
where b.bonus is null or b.bonus < 1000;