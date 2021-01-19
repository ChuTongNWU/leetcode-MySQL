假设表 table 保存了所有三条线段的三元组 x, y, z ，你能帮 Tim 写一个查询语句，来判断每个三元组是否可以组成一个三角形吗？

 

| x  | y  | z  |
|----|----|----|
| 13 | 15 | 30 |
| 10 | 20 | 15 |
对于如上样例数据，你的查询语句应该返回如下结果：

| x  | y  | z  | triangle |
|----|----|----|----------|
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
 

方法1：
	case when
 select x, y, z, 
 	case when x+y > z and x+z > y and z+y > x
 		then 'Yes'
 		else 'No'
 	end as triangle
 from triangle
方法2：
	if 
select x, y, z, if(x+y > z and x+z > y and y+z > x, 'Yes', 'No') as triangle
from triangle

 知识点：
简单函数 
CASE [col_name] WHEN [value1] THEN [result1]…ELSE [default] END

SELECT
    NAME '英雄',
    CASE NAME
        WHEN '德莱文' THEN
            '斧子'
        WHEN '德玛西亚-盖伦' THEN
            '大宝剑'
        WHEN '暗夜猎手-VN' THEN
            '弩'
        ELSE
            '无'
    END '装备'
FROM
    user_info;

搜索函数 
CASE WHEN [expr] THEN [result1]…ELSE [default] END
	搜索函数可以写判断，并且只会返回第一个符合条件的值
# when 表达式中可以使用 and 连接条件
SELECT
    NAME '英雄',
    age '年龄',
    CASE
        WHEN age < 18 THEN
            '少年'
        WHEN age < 30 THEN
            '青年'
        WHEN age >= 30
        AND age < 50 THEN
            '中年'
        ELSE
            '老年'
    END '状态'
FROM
    user_info;



#聚合函数 sum 配合 case when 的简单函数实现行转列
SELECT
    st.stu_id '学号',
    st.stu_name '姓名',
    sum(
        CASE co.course_name
        WHEN '大学语文' THEN
            sc.scores
        ELSE
            0
        END
    ) '大学语文',
    sum(
        CASE co.course_name
        WHEN '新视野英语' THEN
            sc.scores
        ELSE
            0
        END
    ) '新视野英语',
    sum(
        CASE co.course_name
        WHEN '离散数学' THEN
            sc.scores
        ELSE
            0
        END
    ) '离散数学',
    sum(
        CASE co.course_name
        WHEN '概率论与数理统计' THEN
            sc.scores
        ELSE
            0
        END
    ) '概率论与数理统计',
    sum(
        CASE co.course_name
        WHEN '线性代数' THEN
            sc.scores
        ELSE
            0
        END
    ) '线性代数',
    sum(
        CASE co.course_name
        WHEN '高等数学' THEN
            sc.scores
        ELSE
            0
        END
    ) '高等数学'
FROM
    edu_student st
LEFT JOIN edu_score sc ON st.stu_id = sc.stu_id
LEFT JOIN edu_courses co ON co.course_no = sc.course_no
GROUP BY
    st.stu_id
ORDER BY
    NULL;