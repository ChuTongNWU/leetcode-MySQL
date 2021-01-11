id,name, referee_id
2,jane,
3,alex,2
4,bill,
5,zack,1
6,mark,2

题目 找出不是被2号顾客推荐来的顾客姓名

方法1：
	寻找referee_id为空或者不是2的顾客

select name
from customer584
where referee_id is null or referee_id <> 2;

方法2：
	先把2号顾客推荐的id找出来，然后再找不在这个里面的
select name
from customer584
where id not in (select id from customer584 where referee_id = 2);

方法3：
	使用Ifnull为推荐id为空的置为0，则可以判断所有的不等于2的信息

select name
from customer584
where ifnull(referee_id, 0) <> 2;

方法4：
	coalesce（）函数，返回参数中的第一个非空表达式，从左多右
select name
from customer584
where coalesce(referee_id, 0) <> 2;