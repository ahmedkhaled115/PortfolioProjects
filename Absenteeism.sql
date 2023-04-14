
--clear data Remove dublicated...
with CTE as(
select  *,ROW_NUMBER() over (partition by id 
							,[Reason for absence] 
							,[month of absence] 
							,[day of the week]
							,[absenteeism time in hours]
							,seasons
							,[work load average/day]
							order by id) as row_number
from Absenteeism_at_work
)
DELETE
from CTE
where  ROW_NUMBER > 1


-- update data 
select distinct *
from Absenteeism_at_work

alter table Absenteeism_at_work
add Disease nvarchar(100)

update Absenteeism_at_work
set Disease = 
			 case 
				when [Reason for absence] >=1 and [Reason for absence] < = 21 then 'yes'
				else 'no'
			 end

alter table Absenteeism_at_work
alter column [Reason for absence] nvarchar(100)

update Absenteeism_at_work
set [Reason for absence] = 
			 case 
				when [Reason for absence] = 0 then 'Unknown'
				when [Reason for absence] = 1 then 'Certain infectious and parasitic diseases'
				when [Reason for absence] = 2 then 'Neoplasms'
				when [Reason for absence] = 3 then 'Diseases of the blood and blood-forming organs and certain disorders involving the immune mechanism'
				when [Reason for absence] = 4 then 'Endocrine, nutritional and metabolic diseases'
				when [Reason for absence] = 5 then 'Mental and behavioural disorders'
				when [Reason for absence] = 6 then 'Diseases of the nervous system'
				when [Reason for absence] = 7 then 'Diseases of the eye and adnexa'
				when [Reason for absence] = 8 then 'Diseases of the ear and mastoid process'
				when [Reason for absence] = 9 then 'Diseases of the circulatory system'
				when [Reason for absence] = 10 then 'Diseases of the respiratory system'
				when [Reason for absence] = 11 then 'Diseases of the digestive system'
				when [Reason for absence] = 12 then 'Diseases of the skin and subcutaneous tissue'
				when [Reason for absence] = 13 then 'Diseases of the musculoskeletal system and connective tissue'
				when [Reason for absence] = 14 then 'Diseases of the genitourinary system'
				when [Reason for absence] = 15 then 'Pregnancy, childbirth and the puerperium'
				when [Reason for absence] = 16 then 'Certain conditions originating in the perinatal period'
				when [Reason for absence] = 17 then 'Congenital malformations, deformations and chromosomal abnormalities'
				when [Reason for absence] = 18 then 'Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified'
				when [Reason for absence] = 19 then 'Injury, poisoning and certain other consequences of external causes'
				when [Reason for absence] = 20 then 'External causes of morbidity and mortality'
				when [Reason for absence] = 21 then 'Factors influencing health status and contact with health services'
				when [Reason for absence] = 22 then 'patient follow-up'
				when [Reason for absence] = 23 then 'medical consultation'
				when [Reason for absence] = 24 then 'blood donation '
				when [Reason for absence] = 25 then 'laboratory examination'
				when [Reason for absence] = 26 then 'unjustified absence'
				when [Reason for absence] = 27 then 'physiotherapy'
				when [Reason for absence] = 28 then 'dental consultation'
			 end


alter table Absenteeism_at_work
alter column [Month of absence] nvarchar(10)

update Absenteeism_at_work 
set [Month of absence] = 
			case
				when [Reason for absence] = '0' then 'Unknown'
				when [Month of absence] = '1' then 'January'
				when [Month of absence] = '2' then 'February'
				when [Month of absence] = '3' then 'March'
				when [Month of absence] = '4' then 'April'
				when [Month of absence] = '5' then 'May'
				when [Month of absence] = '6' then 'June'
				when [Month of absence] = '7' then 'July'
				when [Month of absence] = '8' then 'August'
				when [Month of absence] = '9' then 'September'
				when [Month of absence] = '10' then 'October'
				when [Month of absence] = '11' then 'November'
				when [Month of absence] = '12' then 'December'
			end



alter table Absenteeism_at_work
alter column [Day of the week] nvarchar(10)

update Absenteeism_at_work 
set [Day of the week] = 
			case
				when [Day of the week] = '2' then 'Monday'
				when [Day of the week] = '3' then 'Tuesday'
				when [Day of the week] = '4' then 'Wednesday'
				when [Day of the week] = '5' then 'Thursday'
				when [Day of the week] = '6' then 'Friday'
			end

alter table Absenteeism_at_work
alter column seasons nvarchar(10)

update Absenteeism_at_work 
set seasons = 
			case
				when seasons = '2' then 'Summer'
				when seasons = '3' then 'Fall'
				when seasons = '4' then 'Winter'
				when seasons = '1' then 'Spring'
			end


alter table Absenteeism_at_work
alter column education nvarchar(14)

update Absenteeism_at_work 
set Education = 
			case
				when Education= '2' then 'graduate'
				when Education= '3' then 'postgraduate'
				when Education= '4' then 'master_phd'
				when Education= '1' then 'high_school'
			end

alter table Absenteeism_at_work
alter column [Social drinker] nvarchar(5)

update Absenteeism_at_work 
set [Social drinker] = 
			case
				when [Social drinker]= '0' then 'NO'
				when [Social drinker]= '1' then 'YES'
			end

alter table Absenteeism_at_work
alter column [Disciplinary failure] nvarchar(5)

update Absenteeism_at_work 
set [Disciplinary failure] = 
			case
				when [Disciplinary failure]= '0' then 'NO'
				when [Disciplinary failure]= '1' then 'YES'
			end

alter table Absenteeism_at_work
alter column [Social smoker] nvarchar(5)

update Absenteeism_at_work 
set [Social smoker] = 
			case
				when [Social smoker]= '0' then 'NO'
				when [Social smoker]= '1' then 'YES'
			end


alter table Absenteeism_at_work
add absenteeism_time_in_days nvarchar(25)

update Absenteeism_at_work
set absenteeism_time_in_days = 
			case 
				when [Absenteeism time in hours] < 24 then 'Less than 1 day'
				when [Absenteeism time in hours] = 24 then '1 day'
				when [Absenteeism time in hours] > 24 and [Absenteeism time in hours] < 48 then 'Between 1 and 2 days'
				when [Absenteeism time in hours] = 48 then '2 days'
				when [Absenteeism time in hours] > 48 and [Absenteeism time in hours] < 72 then 'between 2 and 3 days'
				when [Absenteeism time in hours] = 72 then '3 days'
				when [Absenteeism time in hours] > 72 and [Absenteeism time in hours] < 96 then 'between 3 and 4 days'
				when [Absenteeism time in hours] = 96 then '4 days'
				when [Absenteeism time in hours] > 96 and [Absenteeism time in hours] < 120 then 'between 4 and 5 days'
				when [Absenteeism time in hours] = 120 then '5 days'
				when [Absenteeism time in hours] > 120 then 'more than 5 days'
			end



alter table Absenteeism_at_work
add category nvarchar(25)

update Absenteeism_at_work
set category=
			case 
				when [Body mass index] < 18.5 then 'underweight'
				when [Body mass index] between 18.5 and 25 then 'healthy weight'
				when [Body mass index] between 25 and 30 then 'overweight'
				else 'obese'
			end


------------------------------------------------------------------------------------------

select disease,count(*) as total
from Absenteeism_at_work
group by disease
order by 2 desc

--Most of the absentees are not satisfactory

select [Reason for absence],count(*) as total_absence
from Absenteeism_at_work
where disease = 'no'
group by [Reason for absence]
order by 2 desc

--medical consultation is the most reason of absence of no disease

select [Reason for absence] , count(*) as total_absence
from Absenteeism_at_work
group by [Reason for absence]
order by 2 desc

----------------------
--Distribution of diseases over social drinkers
select [Reason for absence] , [Social drinker] , count(*) as total_absence
from Absenteeism_at_work
group by [Reason for absence],[Social drinker]
order by 1 desc
 --------------------------
 --Distribution of diseases over social smoker
select [Reason for absence] , [Social smoker] , count(*) as total_absence
from Absenteeism_at_work
group by [Reason for absence],[Social smoker]
order by 1 desc
 --------------------------
 --Identifying Reasons of Absence with Higher Probability Among Drinkers and Smokers
create view drinker_prob 
as
WITH drinker_prob AS (
  SELECT CAST(CAST((
    SELECT COUNT([Social drinker])
    FROM Absenteeism_at_work
    WHERE [Social drinker] = 'YES') AS DECIMAL(10,2)) / COUNT(*) AS DECIMAL(10,4)) AS drinker_prob
  FROM Absenteeism_at_work
), 
absence_drinker_prob AS (
	select [Reason for absence],count(*) as total_social_drinker from Absenteeism_at_work
   where [Social drinker] = 'Yes' group by [Reason for absence]
)
select *
from drinker_prob , absence_drinker_prob


select [Reason for absence] , cast((total_social_drinker/
cast((select count(*) from Absenteeism_at_work) as decimal(10,2))) / drinker_prob as decimal (10,4))
as [P(Absence | social drinker)] from drinker_prob





create view smoker_prop
as
WITH smoker_prob AS (
  SELECT CAST(CAST((
    SELECT COUNT([Social smoker])
    FROM Absenteeism_at_work
    WHERE [Social smoker] = 'YES') AS DECIMAL(10,2)) / COUNT(*) AS DECIMAL(10,4)) AS smoker_prob
  FROM Absenteeism_at_work
), 
absence_smoker_prob AS (
	select [Reason for absence],count(*) as total_social_smoker from Absenteeism_at_work
   where [Social smoker] = 'Yes' group by [Reason for absence]
)
select *
from smoker_prob , absence_smoker_prob


select 
[Reason for absence] , cast((total_social_smoker/
cast((select count(*) from Absenteeism_at_work) as decimal(10,2))) / smoker_prob as decimal (10,4))
as [P(Absence | social smoker)]
from smoker_prop



------------------------------------------------------------------------------------------
--Identifying the Probability of Being a Drinker/Smoker, Conditioned to Absence Reason
create view reason_of_absence
as
select [Reason for absence] , cast(count(*) 
	/ cast((select COUNT(*) from Absenteeism_at_work) as decimal(10,4)) as decimal(10,4)) as prop_reason
from Absenteeism_at_work
group by  [Reason for absence]


with cte as (
select  d.[Reason for absence] 
		,cast(d.total_social_drinker / cast((select count(*) from Absenteeism_at_work) as decimal(10,4)) as decimal(10,4)) as absence_drinker_prob
		,r.prop_reason 
from reason_of_absence r
join drinker_prob d
on d.[Reason for absence] =r.[Reason for absence]
)
select [Reason for absence]  , absence_drinker_prob / prop_reason as  [P(social drinker | Absence)] from cte


with cte as (
select  s.[Reason for absence] 
		,cast(s.total_social_smoker / cast((select count(*) from Absenteeism_at_work) as decimal(10,4)) as decimal(10,4)) as absence_smoker_prob
		,r.prop_reason 
from reason_of_absence r
join smoker_prop s
on s.[Reason for absence] =r.[Reason for absence]
)
select [Reason for absence]  , absence_smoker_prob / prop_reason as  [P(social smoker | Absence)] from cte


--------------------------------------------------------------------------------------------------
select absenteeism_time_in_days , count([Social drinker]) as num_of_social_drinker
from Absenteeism_at_work
where [Social drinker] = 'Yes' --change the value of social drinker
group by absenteeism_time_in_days 


select absenteeism_time_in_days , count([Social smoker]) as num_of_social_drinker
from Absenteeism_at_work
where [Social smoker] = 'No' --change the value of social smoker
group by absenteeism_time_in_days 


----------------------------------------------------------------------------
select category , count(category) as total_category
from Absenteeism_at_work
group by category

select [Reason for absence] , category , count(*) as total_category
from Absenteeism_at_work
group by [Reason for absence] , category
order by 1,2

select [Absenteeism_time_in_days],category,count(category) as total_category
from Absenteeism_at_work
group by [Absenteeism_time_in_days],category

--------------------------------------------------------------------------
select [Absenteeism_time_in_days],Education,count(*) as total
from Absenteeism_at_work
group by [Absenteeism_time_in_days],Education

select [Reason for absence],Education,count(*) as total
from Absenteeism_at_work
group by [Reason for absence] , Education

---------------------------------------------------------------------

select [Day of the week] , count(*) as total
from Absenteeism_at_work
group by [Day of the week]


select [Reason for absence],[Day of the week] , count(*) as total
from Absenteeism_at_work
group by [Reason for absence],[Day of the week]

select [Reason for absence],[Month of absence] , count(*) as total
from Absenteeism_at_work
group by [Reason for absence],[Month of absence]



