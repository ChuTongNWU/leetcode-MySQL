
题目详见：
https://zhuanlan.zhihu.com/p/258700620

要求：找出下单数最多的顾客。

方法1:
	按照顾客id分组，排序，找最大
select customerid  as customer_number
from (select count(*) as number, customerid from order586 group by customerid) as a
order by number DESC
limit 1;

方法2：
	
select customerid from order586
group by customerid
order by count(*) DESC
limit 1;

方法3：
	按照顾客id分组，寻找订单总数比所有都大于等于的id

select customerid
from order586
group by customerid
having count(*) >= all(select COUNT(*) from order586 group by customerid);