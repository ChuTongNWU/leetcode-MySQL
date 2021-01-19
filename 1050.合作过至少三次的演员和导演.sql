找出一起至少合作过3次的演员和导演。
找出actor与director合作至少3次的情况，并返回（actor_id，director_id）值。
对二元组(演员,导演)分组，计算每组个数，选出每组个数>=3的行。

select actor_id, director_id
from ActorDirector
group by actor_id, director_id
having count(timestamp) >= 3;