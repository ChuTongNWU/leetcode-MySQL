表一：Countries Table

country_id 是此表的主键，该表的每一行都包含一个国家的 ID 和名称。
表二：Weather Table

（country_id，day）是此表的主键，该表的每一行都指示一个国家一天的天气状况。

查询每个国家/地区在2019年11月的天气类型。
如果平均weather_state小于或等于15，则天气类型为“冷”，
如果平均weather_state大于或等于25，则天气类型为“暖”。
以任何顺序返回结果表。

方法1：
	先计算11月的各个国家的平均温度，然后使用case when做判断
select countries.country_name, case when avg <= 15 then 'cold' when avg >= 25 then 'hot' else 'warm' end as weather_type
from
    (select c.country_id, sum(weather_state)/count(c.country_id) as avg
from countries c join weather w on c.country_id = w.country_id
where w.day between '2019-11-01' and '2019-11-30'
group by c.country_id) tmp join countries on tmp.country_id = countries.country_id


方法2：

select country_name, (case when avg(weather_state) <= 15 then 'cold'
						when avg(weather_state) >= 25 then 'hot'
						else 'warm'
						end) as weather_type
from countries c join weather w 
	on c.country_id = w.country_id
where left(w.day, 7) = '2019-11'
group by country_name

知识点：
1.left（）字符串函数，返回指定长度的字符串的左边部分，在这个题中就是裁取日期的
前7个字符串，以此寻找2019-11月；