如下 Activity 表记录的是某社交平台网站上用户活动的情况。
该表中没有主键，因此可能有重复行。
activity_type 列可能的值有 'open_session', 'end_session', 'scroll_down', 
及'send_message'。注意，每一个 session 仅属于一个用户。

请写SQL查询出截至 2019-07-27（包含2019-07-27），
近 30天的每日活跃用户数（当天只要有一条活动记录，即为活跃用户）。

查询结果示例如下：

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

Result table:
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
非活跃用户的记录不需要展示。

方法1：
	要去重，按照日期往前推，统计日期在2019-06-27和2019-07-27之间的
	datediff('2019-07-27', activity_date)，前者减后者的值
	select acticity_date day, count(distinct user_id) active_users
	from Activity
	where datediff('2019-07-27', activity_date) < 30
	group by activity_date


方法2：date_sub('2019-07-27', interval 30 day)，前者减去30天
	date_sub:函数从日期减去指定的时间间隔
	date_sub(date, interval expr type)
	select activity_date day, count(distinct user_id) active_users
	from Activity
	where activity_date > date_sub('2019-07-27', interval 30 day)
	group by activity_date

方法3：
	按照日期和用户id分组，并去重；筛选那些近30天的活动，作为临时表；
	然后按照日期分组，计算所有的；
select activity_date as day, count(distinct user_id) as active_users
from (select distinct activity_date, user_id
	from Activity
	where activity_date > date_sub("2019-07-27", interval 30 day)
	group by activity_date, user_id
	having count(distinct activity_type) >= 1) as tmp
group by activity_date;