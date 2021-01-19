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

product_id	product_name
1	S8
The product with id 1 was only sold in spring 2019 while the other two were sold after.

查询买了 S8 但是没有买 iPhone 的顾客的 buyer_id。

方法1：
	按照买家分组，寻找买家购买的产品中有s8的产品，但是没有iphone
#定义临时表，提取出买家及其购买的产品；
with tmp as (
select s.buyer_id, p.product_name
from sales1082 s join product1082 p
on s.product_id = p.project_id
)
#选择买家id，不在购买iPhone的中，但是在购买s8的中
select distinct buyer_id
from tmp
where buyer_id not in (select buyer_id from tmp where product_name = 'iphone')
    and buyer_id in (select buyer_id from tmp where product_name = 's8')