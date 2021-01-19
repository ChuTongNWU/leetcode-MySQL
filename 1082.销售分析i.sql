Product table:

product_id	product_name	unit_price
1	S8	1000
2	G4	800
3	iPhone	1400
Sales table:

seller_id	product_id	buyer_id	sale_date	quantity	price
1	1	1	2019-01-21	2	2000
1	2	2	2019-02-17	1	800
2	2	3	2019-06-02	1	800
3	3	4	2019-05-13	2	2800
Result table:

seller_id
1
3
Both sellers with id 1 and 3 sold products with the most total price of 2800.

查询全部总销售价格最高的销售员，返回其 seller_id。

方法1：
	直接使用sales表，按照员工分组，将price加起来，排序
select seller_id
from sales1082
group by seller_id
having sum(price) >= all(select sum(price) from sales1082 group by seller_id)

方法2：
	定义一个临时表，按照员工id分组，排序，取排序为1的员工id；
with tmp as(
select seller_id, rank() over(order by sum(price) DESC) as rnk from sales1082
group by seller_id
)

select seller_id from tmp where rnk = 1;

知识点：
1.row_number:同值不同号，为每一行生成一个序号，依次排序且不会重复
2.rank：同值同号，依次排序，值相同序号相同，但会跳级，比如1 2 2 4
3.dense_rank：同值同号，依次排序，值相同序号相同，不会跳级，比如1 2 2 3 4
4.ntile:分桶排名，首先按照桶的个数分出第一二三桶，然后各桶内从1排名。