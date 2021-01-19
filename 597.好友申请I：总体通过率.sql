Table: friend_request

| sender_id | send_to_id |request_date|
|-----------|------------|------------|
| 1         | 2          | 2016_06-01 |
| 1         | 3          | 2016_06-01 |
| 1         | 4          | 2016_06-01 |
| 2         | 3          | 2016_06-02 |
| 3         | 4          | 2016-06-09 |
 

Table: request_accepted

| requester_id | accepter_id |accept_date |
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
| 3            | 4           | 2016-06-10 |
Write a query to find the overall acceptance rate of requests rounded to 2 decimals, which is the number of acceptance divide the number of requests.

For the sample data above, your query should return the following result.

|accept_rate|
|-----------|
|       0.80|
Note:

The accepted requests are not necessarily from the table friend_request. In this case, you just need to simply count the total accepted requests (no matter whether they are in the original requests), and divide it by the number of requests to get the acceptance rate.
It is possible that a sender sends multiple requests to the same receiver, and a request could be accepted more than once. In this case, the ‘duplicated’ requests or acceptances are only counted once.
If there is no requests at all, you should return 0.00 as the accept_rate. 
Explanation: There are 4 unique accepted requests, and there are 5 requests in total. So the rate is 0.80.

Follow-up:

Can you write a query to return the accept rate but for every month?
How about the cumulative accept rate for every day?

好友申请，题目见链接：https://zhuanlan.zhihu.com/p/258790804

找出申请通过率，结果保留两位小数：
注意：

接受的申请不单来源于 friend_request 表。因此，只需对两张表分别进行计数，然后求出通过率即可。
邀请人对同一个人可能不止发送过一次邀请；接受人也可以多次接受同一个邀请。因此要移除重复记录。
如果完全没有邀请记录，则结果返回0.00。

方法1：
	要注意使用子查询
select round(accept/request, 2)
from (select count(*) as accept
    from (select distinct requester_id, accepter_id from request_accepted) as a1) a2, (select count(*) as request from (select distinct sender_id, send_to_id from frient_request) as a3) a4;

方法2：
	