https://zhuanlan.zhihu.com/p/260721471

下表记录了顾客网上下单食物派送的信息，
其中包括订单日期以及首选送货日期。
其中，delivery_id 为该表主键。

如果客户的首选送货日期与订单日期相同，则该订单称为即时订单，否则称为计划订单。

查询表中即时订单的百分比，四舍五入到小数点后两位。

方法1：
	分别计算分子和分母；
select round(100*(select count(*)
    from delivery
    where order_date = customer_pref_delivery_date) / (select count(*) from delivery), 2)
    as immediate_percentage;


方法2：
	子查询计算分子，在计算时计算分母；
select ifnull(round(100*tmp.immediate/(select count(*) from delivery), 2), 0) as immediate_percentage
from (select count(delivery_id) as immediate
            from delivery
            where order_date = customer_pref_delivery_date) as tmp;