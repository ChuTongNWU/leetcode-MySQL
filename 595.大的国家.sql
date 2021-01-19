这里有张 World 表

+-----------------+------------+------------+--------------+---------------+
| name            | continent  | area       | population   | gdp           |
+-----------------+------------+------------+--------------+---------------+
| Afghanistan     | Asia       | 652230     | 25500100     | 20343000      |
| Albania         | Europe     | 28748      | 2831741      | 12960000      |
| Algeria         | Africa     | 2381741    | 37100000     | 188681000     |
| Andorra         | Europe     | 468        | 78115        | 3712000       |
| Angola          | Africa     | 1246700    | 20609294     | 100990000     |
+-----------------+------------+------------+--------------+---------------+
如果一个国家的面积超过 300 万平方公里，或者人口超过 2500 万，那么这个国家就是大国家。

编写一个 SQL 查询，输出表中所有大国家的名称、人口和面积。

例如，根据上表，我们应该输出:

+--------------+-------------+--------------+
| name         | population  | area         |
+--------------+-------------+--------------+
| Afghanistan  | 25500100    | 652230       |
| Algeria      | 37100000    | 2381741      |
+--------------+-------------+--------------+

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/big-countries
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。


# Write your MySQL query statement below
select name, population, area
from World
where area > 3000000 or population > 25000000

使用union连接子查询:用于连接两个以上的select语句的结果组合到一个结果集合里，多个select语句会删除重复的数据。
select name, population, area
from World
where area > 3000000
union
select name, population, area
from World
where population > 25000000