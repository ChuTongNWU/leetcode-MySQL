表Point
下表记录了x轴上的一些点的信息，全部都是整数
找出两点之间最短的距离。

| x   |
|-----|
| -1  |
| 0   |
| 2   |
表自连接，构造偏序关系。

方法1：将a表和b表连接在一起，笛卡尔乘积，条件是x不想等，计算每条信息的差值，然后取最小
	select min(abs(a.x-b.x)) as shortest
	from point as a join point as b 
		on a.x <> b.x

