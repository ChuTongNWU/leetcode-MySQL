题目信息：https://zhuanlan.zhihu.com/p/259935444

select product_name, year, price
from Sales s left join Product p
	on s.product_id = p.product_id