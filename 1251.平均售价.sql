表一：Prices Table

该表的每一行代表从 start_date 到end_date 期间 product_id 的价格。
其中（product_id，start_date，end_date）是此表的主键。 
对于每个product_id，没有两个重叠的时间段，
即同一product_id 不会有两个相交的时间段。


表二：UnitsSold Table

该表没有主键，它可能包含重复项。
该表的每一行代表每种已售产品的日期，数量和 product_id。

查询以找到每种产品的平均售价，average_price 应该四舍五入到小数点后两位。

方法1：
	将两个表连接，条件为售出日期在定价日期之间，
	按照产品id分组，计算组内的单价乘数量的总和，以及比上数量的总和即为平均售价
select p.product_id, round(sum(units*price) / sum(units), 2) as average_price
from prices p join unitssold u
    on p.product_id = u.product_id and purchase_date >= start_date and purchase_date <= end_date
group by p.product_id;
