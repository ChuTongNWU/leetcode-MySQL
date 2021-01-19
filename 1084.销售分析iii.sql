Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+

Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+

Result table:
+-------------+--------------+
| product_id  | product_name |
+-------------+--------------+
| 1           | S8           |
+-------------+--------------+
id为1的产品仅在2019年春季销售，其他两个产品在之后销售。
查询只在 2019 年春季销售的产品编号及产品名称。

方法1：春季时间在2019-1-1至2019-03-31
	提取出产品id和销售日期，并按照productid分组，
	对于组内最大日期要小于2019-03-31，最小的日期要大于2019-01-01；

select p.product_id, p.product_name
from sales1082 s join product1082 p
on s.product_id = p.project_id
group by s.product_id
having max(sale_date) <= '2019-03-31' and min(sale_date) >= '2019-01-01';
#having(sum(sale_date between '2019-01-01' and '2019.03-31') = count(*));
#having sum(s.sale_date > '2019-03-31')=0 and sum(s.sale_date < '2019-01-01') = 0



方法1：春季时间在2019-1-1至2019-03-31

	子查询查询日期小于2019-01-01的产品id，以及查询大于2019-03-31的产品id
	再找都不在这两个区间的
select distinct s.product_id, p.product_name
from sales1082 s join product1082 p
on s.product_id = p.project_id
where s.product_id not in (select product_id
                            from sales1082
                            where s.sale_date < '2019-01-01')
    and s.product_id not in (select p.project_id
                            from sales1082
                            where s.sale_date > '2019-03-31');