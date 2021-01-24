
https://zhuanlan.zhihu.com/p/260564257
如下 Views 表记录了在特定日期里，某些作者文章被阅读的情况。
该表中没有主键，因此可能存在重复行。
注意：author_id 和 viewer_id 相同代表同一个人。

查询所有查看了至少一篇自己的文章的作者，并按ID升序排列

方法1：
	可以看出表内最后两行是重复的，因为在最后查询的时候要去重
	选择查看文章的作者和查看id相同为筛选条件
	然后按照id排序；
select distinct author_id as id
from views
where author_id = viewer_id
order by id;