表一：Students Table

student_id是此表的主键。 该表的每一行都包含一名学生的 ID 和名称。

subject_name 是该表的主键。 该表的每一行都包含一个学科的名称。

表三：Examinations Table

该表没有主键。它可能包含重复项。“Students”表中的每个学生都从“Subjects”表中选课。

该表的每一行表示ID为Student_id的学生参加了subject_name的考试


查询以每个学生参加每项考试的次数，结果按 student_id 和 subject_name 升序排列。

方法1：
	左连接，不仅学生id要相同，选课名称也要相同
	按照学生，学生名字和选课分组，并计算课程的总数
	按照学生id和选课名称排序
select s3.student_id, s3.student_name, s3.subject_name, count(exam.subject_name) as attended_exams
from (select s1.*, s2.*
    from students s1, subjects s2) s3 left join exam
    on s3.student_id = exam.student_id and s3.subject_name = exam.subject_name
group by s3.student_id, s3.student_name, s3.subject_name
order by s3.student_id, s3.subject_name


方法2：
	定义临时表
	cross join 返回两个表的笛卡尔乘积;
with tmp as(
	select a.student_id, b.subject_name
	from students a, subjects b
),
 tmp1 as (
 	select student_id, subject_name, count(*) as attended_exams
 	from exam
 	group by student_id, subject_name
 	)

 select a.student_id, b.student_name, a.subject_name, ifnull(c.attended_exams, 0) as attended_exams
 from tmp a left join students b on a.student_id = b.student_id
 			left join tmp1 c on a.student_id = c.student_id
 				and a.subject_name = c.subject_name
 order by a.student_id, a.subject_name;
