-- CYCLE TIME

-- Write a query to return the average cycle time across each month. 
-- Cycle time is the time elapsed between one user joining and their invitees joining. 
-- Users who joined without an invitation have a zero in the “invited by” column.

create database if not exists practicedb;
use practicedb;

create table if not exists users_c (
user_id integer not null, 
join_date date, 
invited_by integer);

/*
insert into users_c (user_id, join_date, invited_by) 
VALUES 
(1, CAST('20-01-01' AS date), 0), 
(2, CAST('20-01-10' AS date), 1), 
(3, CAST('20-02-05' AS date), 2), 
(4, CAST('20-02-12' AS date), 3), 
(5, CAST('20-02-25' AS date), 2), 
(6, CAST('20-03-01' AS date), 0), 
(7, CAST('20-03-01' AS date), 4),
(8, CAST('20-03-04' AS date), 7);
*/

select * from users_c;

with t1 as (
select month(a.join_date) as month, datediff(b.join_date,a.join_date) as cycle_time 
from users_c a 
join users_c b 
on a.user_id = b.invited_by 
order by a.join_date
)
select month, format(avg(cycle_time),1) as avg_cycle_time 
from t1 
group by month;
