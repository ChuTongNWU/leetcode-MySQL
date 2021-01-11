内容：
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id 是这个表的主键
该表包含特定日期的温度信息

思路：
	进行全连接，on的条件日期相差一天，where 条件是后者的温度大于前者的温度

select w2.id
from Weather w1 join Weather w2
    on datediff(w2.recordDate, w1.recordDate) = 1
where w2.Temperature > w1.Temperature

select w2.id
from Weather w1 join Weather w2
    on datediff(w2.recordDate, w1.recordDate) = 1 and w2.Temperature > w1.Temperature

方法2：
	外层循环是天气表，对于外层循环的每一个日期，找内层循环天气表内日期为外层循环的第二天，并且要外层温度要小于内层温度
	这样做是做的，会报错

方法3：
	使用lead函数将每个id和日期后一天的信息和前一天信息拼接到一起，这样直接对两个表进行判断
select Id
from (select temperature,
             recordDate,
             lead(id, 1) over (order by recordDate)          as 'Id',
             lead(recordDate, 1) over (order by recordDate)  as 'nextDate',
             lead(temperature, 1) over (order by recordDate) as 'nextTemp'
      from weather
     ) as t
where nextTemp > temperature and datediff(nextDate, recordDate) = 1;

使用timestampdiff(unit, begin, end) 返回begin和end之间相差多少个unit。unit为day时，则为相差的天
select w2.id
from Weather w1 join Weather w2
    on timestampdiff(day, w1.recordDate, w2.recordDate) = 1
where w2.Temperature > w1.Temperature