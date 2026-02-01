--ques1.
select count(*) as total_rows from prod_cat_info
select count(*) as total_rows from Transactions
select count(*)as total_rows from Customer
--ques2
select count(*) as total_transaction from Transactions 
where Qty<0 or total_amt <0
--ques3
select transaction_id, tran_date,convert(date,tran_date,103) as valid_tran_date 
from Transactions
--ques4
select
min(try_convert(date,tran_date,103)) as start_date,
MAX(try_convert(date,tran_date,103)) as end_date,
DATEDIFF(day,min(try_convert(date,tran_date,103)),MAX(try_convert(date,tran_date,103))) as total_days,
DATEDIFF(month,min(try_convert(date,tran_date,103)),max(try_convert(date,tran_date,103))) as total_month,
DATEDIFF(year,min(try_convert(date,tran_date,103)),max(try_convert(date,tran_date,103))) as total_year
from Transactions
--ques5
select prod_cat , prod_subcat from prod_cat_info
where prod_subcat = 'DIY'
--data analysis
--ques1
select top 1 store_type , count(*) as cnt from Transactions
group by Store_type
order by cnt desc
--ques2
select gender , count(*) as cnt from customer 
where gender is not null
group by Gender
--ques3
select top 1  city_code , count(customer_id) as cnt from customer 
group by city_code
order by cnt desc
--ques4
select prod_cat , prod_subcat from prod_cat_info
where prod_cat = 'books'
--ques5
select prod_cat_code , max(qty)  as max_qt from Transactions
group by prod_cat_code
--ques6
select sum(cast(total_amt as float) ) as total_rev from prod_cat_info as t1
join Transactions as t2
on t1.prod_cat_code = t2.prod_cat_code and t1.prod_sub_cat_code = t2.prod_subcat_code
where prod_cat in ('Books' ,'Electronics')
--ques7
select count(*) as cnt from (
select cust_id , count(distinct(transaction_id)) as cnt_transaction from Transactions
where qty > 0
group by cust_id
having count(distinct(transaction_id)) > 10
) as t5
--ques8
select sum(cast(total_amt as float)) as total_rev from prod_cat_info as t1 
join Transactions as t2 
on t1.prod_cat_code = t2.prod_cat_code and t1.prod_sub_cat_code = t2.prod_subcat_code
where prod_cat in ('clothing' , 'electronics') and Store_type = 'flagship store' and Qty >0
--ques9
 select prod_subcat, sum(cast(total_amt as float )) as total_rev from prod_cat_info as t1
join Transactions as t2
on t1.prod_cat_code = t2.prod_cat_code and t1.prod_sub_cat_code = t2.prod_subcat_code
join Customer as t3
on t2.cust_id = t3.customer_Id
where gender = 'm' and prod_cat = 'electronics'
group by prod_subcat
--ques10
select  t5.prod_subcat,percentage_sales,percentage_return from (
select top 5  prod_subcat ,( sum(cast(total_amt as float))/(select sum(cast(total_amt as float))  from Transactions where qty >0 )) as percentage_sales from prod_cat_info as t1
join Transactions as t2 
on t1.prod_cat_code = t2.prod_cat_code and t1.prod_sub_cat_code = t2.prod_subcat_code
where qty > 0
group by prod_subcat
order by percentage_sales desc
 ) as  t5
full outer join
(select top 5  prod_subcat ,( sum(cast(total_amt as float)) /(select sum(cast(total_amt as float))  from Transactions where qty < 0 )) as percentage_return from prod_cat_info as t1
join Transactions as t2 
on t1.prod_cat_code = t2.prod_cat_code and t1.prod_sub_cat_code = t2.prod_subcat_code
where qty < 0
group by prod_subcat
order by percentage_return desc) as  t6
on t5.prod_subcat = t6.prod_subcat
where t5.prod_subcat is not null
or t6.prod_subcat is not null
--ques11
select * from (
SELECT * FROM (
select cust_id,DATEDIFF(year,DOB,max_date) AS AGE ,total_rev FROM (
select cust_id, DOB, max(convert(date,tran_date,105)) as max_date , sum(cast(total_amt as float)) as total_rev from Transactions as t1
join customer as t2
on t1.cust_id = t2.customer_Id
where qty>0
group by cust_id,DOB
) AS A
      ) AS B
WHERE AGE BETWEEN 25 AND 35
                             ) AS C
JOIN (
SELECT CUST_ID , CONVERT(DATE,TRAN_DATE,105) AS TRAN_DATE FROM Transactions
GROUP BY cust_id,CONVERT(DATE,TRAN_DATE,105)
HAVING CONVERT(DATE,TRAN_DATE,105)>=(SELECT DATEADD (DAY,-30,MAX(CONVERT(date,tran_date,105)))AS CUTOFF_DATE FROM Transactions)
) AS D
ON C.CUST_ID =D.CUST_Id
--ques12
select top 1 prod_cat_code, sum(returns) as total_returns from (
select prod_cat_code,convert(date, tran_date,105) as tran_date,sum(cast(qty as float)) as returns from Transactions
where qty<0
group by prod_cat_code, convert(date,tran_date,105) 
having convert(date,tran_date,105)>=(select DATEADD (month, -3 ,MAX(convert(date,tran_date,105))) as cutoff_date from Transactions)
) as a
group by prod_cat_code
order by total_returns
--ques13
select   store_type , sum(cast(qty as float)) as max_qty , sum(cast(total_amt as float)) as max_amt from Transactions
group by Store_type
order by max_amt desc , max_qty desc
--ques14
select prod_cat_code, AVG(cast(total_amt as float)) as rev from Transactions
where qty > 0
group by prod_cat_code
having AVG(cast(total_amt as float)) >= (select avg(cast(total_amt as float)) from Transactions) 
--ques15
select prod_subcat_code,sum(cast(total_amt as float)) as sum_amt , avg(cast(total_amt as float)) as avg_amt from Transactions
where qty > 0 and prod_cat_code in (select top 5 prod_cat_code from Transactions
                                     where qty> 0
                                     group by prod_cat_code
                                     order by sum(cast(qty as float))desc)
group by prod_subcat_code