create schema "sql queries hometask"

create table transaction(
	transaction_id smallint
	,product_id smallint
	,customer_id smallint
	,transaction_date date
	,online_order bool
	,order_status varchar(10)
	,brand varchar(30)
	,product_line varchar(20)
	,product_class varchar(20)
	,product_size varchar(20)
	,list_price real
	,standard_cost real
);


create table customer(
	customer_id smallint
	,first_name varchar(15)
	,last_name varchar(35)
	,gender varchar(8)
	,DOB date
	,job_title varchar(40)
	,job_industry_category varchar(40)
	,wealth_segment varchar(40)
	,deceased_indicator varchar(1)
	,owns_car varchar(3)
	,address varchar(40)
	,postcode smallint
	,state varchar(40)
	,country varchar(15)
	,property_valuation smallint
);


select distinct brand
from transaction
where standard_cost > 1500;


select * 
from transaction
where
	order_status = 'Approved'
	and transaction_date between '2017-04-01' and '2017-04-09';


select distinct job_title
from customer
where 
	job_industry_category in('IT', 'Financial Services')
	and job_title like 'Senior%';


select distinct t.brand
from "transaction" t 
inner join customer c
	on t.customer_id = c.customer_id 
where
	c.job_industry_category = 'Financial Services';


select c.customer_id, c.first_name, c.last_name, t.brand
from customer c 
inner join "transaction" t
	on t.customer_id = c.customer_id 
where
	t.online_order = true 
	and t.brand in('Giant Bicycles', 'Norco Bicycles', 'Trek Bicycles')
limit 10;


select c.customer_id, c.first_name, c.last_name
from customer c 
left join "transaction" t
	on t.customer_id = c.customer_id
where t.customer_id is null;


select c.customer_id, c.first_name, c.last_name, c.job_industry_category
from customer c 
left join "transaction" t
	on t.customer_id = c.customer_id
where 
	c.job_industry_category = 'IT'
	and t.standard_cost = (select max(standard_cost) from "transaction");
	

select distinct c.customer_id, c.first_name, c.last_name, c.job_industry_category, t.order_status
from customer c
inner join "transaction" t
	on t.customer_id = c.customer_id
where 
	c.job_industry_category in('IT', 'Health')
	and t.order_status = 'Approved'
	and t.transaction_date between '2017-07-07' and '2017-07-17';
	