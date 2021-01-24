该表没有主键，它可能有重复的行。
 每行可以是一个帖子或对该帖子的评论。 
 如果是帖子，则 parent_id 为 null，否则为评论。 
 表中的 parent_id 是 被 sub_id 评论的帖子

 查询每个帖子的评论数。 
 结果表应包含 post_id 及其相应的评论数，
 且按 post_id 升序排列。 
 提交的内容可能包含重复的评论，应该计算每个帖子的唯一评论数。 
 提交的内容可能包含重复的帖子，应将它们视为一个帖子。

方法1：
	现将帖子提出来，然后将帖子和评论表左连接，然后计算总数
	因为有的可能为null，因此使用ifnull换成0
 with tmp as (select sub_id
from submissions
where parent_id is null)

select tmp.sub_id as post_id, ifnull(count(distinct s.sub_id), 0) as number_of_comments
from tmp left join submissions s
    on tmp.sub_id = s.parent_id
group by post_id
order by post_id;


方法2：

select t1.sub_id as post_id, count(t2.parent_id) as number_of_comments
from (select distinct sub_id
		from submissions s1
		where parent_id is null) t1 left join
	(select distinct sub_id, parent_id
		from submissions s2
		) t2
	on t1.sub_id = t2.parent_id
group by post_id
order by post_id;