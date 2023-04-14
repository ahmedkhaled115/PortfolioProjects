-- join table in poduction schema and creating view
alter view product
	as 
		SELECT p.product_id,p.product_name,B.brand_name,c.category_name,p.model_year,p.list_price
		FROM production.brands B
		join production.products p
		on p.brand_id=B.brand_id
		join production.categories c
		on c.category_id=p.category_id
-----------------------------

select * from product

----------------------------------------------------------------------------------
--what is the most sold brand?
select p.category_name,sum(o.quantity) as total_quantity  ----excel
from product p
join sales.order_items O
on p.product_id = O.product_id
group by p.category_name
order by 2 desc

---------------------------------------------------------------------------------
--what is the most sold type?
select p.brand_name,sum(o.quantity) as total_quantity  ----excel
from product p
join sales.order_items O
on p.product_id = O.product_id
group by p.brand_name
order by 2 desc

---------------------------------------------------------------------------------

create view order_date
as
	select o.order_id,
		   oi.product_id,
		   datepart(year,o.order_date) as order_date_years,
		   datepart(MONTH,o.order_date) as order_date_months,
		   datepart(DAY,o.order_date) as order_date_days_bymonths,
		   datepart(WEEKDAY,o.order_date) as order_date_days_byweek,
		   OI.quantity,
		   OI.list_price,
		   case 
				when DATEDIFF(day,o.shipped_date,o.required_date) = 0 then 'In_date'
				when DATEDIFF(day,o.shipped_date,o.required_date) > 0 then 'Early'
				when DATEDIFF(day,o.shipped_date,o.required_date) < 0 then 'Late'
				when DATEDIFF(day,o.shipped_date,o.required_date) is null then 'canceld'
		   end as delivary_time
	from sales.orders O
	join sales.order_items OI
	on OI.order_id=o.order_id

select * from order_date
--what is the most year revenue?

select order_date_years,sum(quantity*list_price) as revenue 
from order_date
group by order_date_years
order by 2 desc

--what is the most month revenue?
select order_date_months,sum(quantity*list_price) as revenue
from order_date
where order_date_years = 2017 -- change the month to see the change
group by order_date_months
order by 2 desc

select order_date_years,order_date_months,sum(quantity*list_price) as revenue  ----excel
from order_date
group by order_date_years,order_date_months
order by 1 ,3 desc


--what is the most day in week revenue?
select order_date_days_byweek,sum(quantity) as total_orders ----excel
from order_date
group by order_date_days_byweek
order by 2 desc

--combare shiped and required date? ---dashboard
select delivary_time,count(delivary_time) as arrive ----excel
from order_date
group by delivary_time
order by 2 desc 

--------------------------------------------------------------------------------
--what is the most state revenue?
create view state
as
	select c.customer_id,
		   concat(c.first_name,' ',c.last_name) as Full_Name,
		   c.state,
		   oi.quantity,
		   oi.list_price

	FROM SALES.customers c
	join sales.orders O
	on c.customer_id=o.customer_id
	join sales.order_items OI
	on OI.order_id = o.order_id


select state,  ----excel
	   sum(quantity*list_price) as revenue,
	   count(quantity) as total_order
from state
group by state
order by 2 desc

-------------------------------------------------------
--what is the best staff sold product?
create view staff
as
	select concat(s.first_name,' ',s.last_name) as full_name,
		   oi.quantity,
		   oi.list_price
	from sales.staffs S
	join sales.orders o
	on s.staff_id=o.staff_id
	join sales.order_items OI
	on oi.order_id = o.order_id

select full_name,  ----excel
	   count(quantity) as total_orders,
	   sum(list_price) as total_revenue_price
from staff
group by full_name
order by 2 desc


----------------------------------------------------
--THE BEST CUSTOMER?
create view coustomer
as
	select  concat(c.first_name,' ',c.last_name) as Full_Name,
			COUNT(oi.quantity) FEQUANCEY,
			SUM(oi.list_price) MONATERY_VALUE,
			DATEDIFF(DD,MAX(O.order_date),(SELECT MAX(order_date) FROM sales.orders)) RECENCY
	FROM SALES.customers c
	join sales.orders O
	on c.customer_id=o.customer_id
	join sales.order_items OI
	on OI.order_id = o.order_id
	GROUP BY concat(c.first_name,' ',c.last_name)

create view rfm
as
	select *,
		   NTILE(4) over(order by recency desc) as rfm_recency,
		   NTILE(4) over(order by FEQUANCEY) as rfm_FEQUANCEY,
		   NTILE(4) over(order by MONATERY_VALUE ) as rfm_MONATERY_VALUE
		   
	from coustomer


create view final
as
	select Full_Name,
		   rfm_recency,
		   rfm_FEQUANCEY,
		   rfm_MONATERY_VALUE ,
		   CAST(RFM_RECENCY AS varchar(2))+CAST(rfm_FEQUANCEY AS varchar(2))+CAST(rfm_MONATERY_VALUE AS varchar(2)) rfm_cell_string
	from rfm 


create view segment
as
	select * ,
		case 
				when rfm_cell_string in (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141,221,113,124,142) then 'lost_customers'  --lost customers
				when rfm_cell_string in (133, 134, 143, 244, 334, 343, 344, 144,442,243) then 'slipping away, cannot lose' -- (Big spenders who haven’t purchased lately) slipping away
				when rfm_cell_string in (311, 411, 331,412,313,414,413,431) then 'new customers'
				when rfm_cell_string in (222, 223, 233, 322,232,234,312,314) then 'potential churners'
				when rfm_cell_string in (323, 333,321, 422, 332, 432,421,423,213,224,242,324,342) then 'active' --(Customers who buy often & recently, but at low price points)
				when rfm_cell_string in (433, 434, 443, 444) then 'loyal'
		end rfm_segment
	from final

create view rfm_segment ----excel
as
	select  rfm_segment,
			count(rfm_segment) as total_number
	from segment
	group by rfm_segment

select * from segment where rfm_segment='loyal' and rfm_cell_string='444' ----excel
