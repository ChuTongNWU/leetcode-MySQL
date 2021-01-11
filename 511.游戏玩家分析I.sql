Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+

找出每个玩家第一次登录的日期；

方法1：
		按照玩家id分组，找出每一组最小的值
select playerID, min(eventDate) as 'first_login'
from activity
group by playerId;

方法2：
		使用窗口函数对每个分组进行排序，最后找排序序号为1的玩家id；

select playerId, eventDate as first_login
from (select playerId, eventDate, 
	dense_rank() over(partition by playerId order by eventDate) as first 
	from activity) as tmp
where tmp.first = 1;