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
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+
查询每个用户首次登陆的日期所使用的设备。

方法一：
		先查找用户首次登录，再根据首次登录的日期匹配设备

select a1.playerId, a1.deviceId
from activity a1, (select playerID, min(eventDate) as beginlogin
    from activity
    group by playerId) a2
where a1.eventDate = a2.beginlogin and a1.playerId = a2.playerId;

方法2：
		类似于511，按玩家id分组，按找日期排序，寻找1的玩家id和设备id

select playerId, deviceId as device_id
from (select playerId, deviceId, dense_rank() over(partition by playerId order by eventDate) as first from activity) as tmp
where tmp.first = 1;

方法3:
		对于每个玩家，内层循环根据玩家id获取最早登录的日期，判断外层循环的信息是否是最早的，如果是的话，则找到

select a1.playerId, a1.deviceId
from activity a1
where a1.eventDate = (select eventDate
                    from activity a2
                    where a1.playerId = a2.playerId
                    order by eventDate
                    limit 1)；

方法4：
		用in实现
select a1.player_id,a1.device_id
from activity as a1
where (a1.player_id,a2.event_date) in
	(
	    select player_id,min(event_date) as beginlogin
	    from activity
	    group by player_id
	);