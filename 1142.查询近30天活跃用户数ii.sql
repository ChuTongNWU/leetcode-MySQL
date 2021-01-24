Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+

查询截至2019年7月27日（含）的30天期间每个用户的平均 session 数，
四舍五入到小数点后两位。我们要为用户计算的 
session 是在该时间段内至少进行了一项活动的会话。

方法1：
	如果计算的小数没有的话，就是0
	分母是用户去重后的总数，分子是session去重后的总数
	select ifnull(round(count(distinct session_id) / count(distinct user_id), 2), 0) as average_sessions_per_user
	from Activity
	where datediff('2019-07-27', activity_date) < 30



方法2：
	按照用户id分组，日期是在2019-07-27减去30天大的，子查询用户id，每个用户的所有
	session的总数。
select round(coalese(avg(session), 0) ,2) as average_sessions_per_user
from (
	select distinct user_id, count(distinct session_id) as session
	from Activity
	where activity_date > date_sub("2019-07-27", interval 30 day)
	group by user_id
	having session >= 1
	) as tmp;