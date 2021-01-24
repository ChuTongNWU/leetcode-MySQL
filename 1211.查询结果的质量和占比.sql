https://zhuanlan.zhihu.com/p/260937964




该表没有主键，它可能有重复的行。 
该表包含从数据库中的某些查询收集的信息。 
位置 (position) 列的值是1到500。 
评分 (rating) 列的值是1到5。
评分小于3的查询是较差的查询。


我们将 查询质量 定义为：查询评级与其排名之间的比率的平均值。
我们还定义了 poor_query_percentage 为：评分小于3的所有查询所占的百分比。
查询每个查询的名称，质量和poor_query_percentage。
quality 和 poor_query_percentage 都应四舍五入到小数点后两位。


select query_name,
    round(avg(rating/position), 2) as quality,
    round(sum(100*case when rating < 3 then 1 else 0 end)/count(distinct result), 2) as poor_query_percentage
from queries
group by query_name;