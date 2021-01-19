表 my_numbers 在 num 列中包含许多数字，包括重复的数字。
| num  |
|-----|
| 8  |
| 8   |
| 3   |
| 3  |
| 1   |
| 4   |
| 5  |
| 6   |

查找最大的数字，该数字只出现一次。 注意：如果没有这样的数字，则仅输出 null。
| num  |
|-----|
| 6  |

方法1：
	将数字先计数，
	8 2
	3 2
	1 1
	4 1
	5 1
	6 1
	类似于上述的结果，然后删除count不等于1的，再将剩下的降序排序
select max(t.num)
from (select num, count(num) as count
	from my_numbers
	group by num
	having count(num) = 1) as t


select max(A.num) as `num`
from 
(
    select M.num as `num`
    from my_numbers as M
    group by M.num
    having count(M.num)=1
    order by M.num desc
    limit 0,1
) as A


应用IFNULL。当第一个参数不为NULL时，返回第一个参数，否则返回第二个参数。

SELECT IFNULL(
	(
		select M.num
		from my_numbers as M
		group by M.num
		having count(M.num)=1
		order by M.num desc
		limit 0,1
	)
, NULL
) AS `num`

由于本例中表只有一列。

上述代码还可简化为：

SELECT IFNULL(
	(
		SELECT *
		from my_numbers as M
		group by M.num
		having COUNT(*)=1
		order by M.num desc
		limit 0,1
	)
, NULL
) AS `num`
