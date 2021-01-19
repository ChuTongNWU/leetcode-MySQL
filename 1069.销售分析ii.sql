https://zhuanlan.zhihu.com/p/259937061

查询每个产品ID的总销售量。
思路：有的产品有销量，有的产品没有销量

对所有产品id，左连接，如果有，那么sum，如果没有则为0
select s.product_id, if(p.price is null, 0, sum(p.price))
from sales s left join product p
	on s.product_id = p.product_id
group by p.product_id;

尴尬我理解错了，就是卖出去的求总和；

SELECT product_id, SUM(quantity) AS total_quantity
FROM Sales
GROUP BY product_id;