select * from Bikeshare.dbo.Bike
select distinct weather from bike
select * from bike


-------------------------------------------------------


-- rename columuns

sp_rename 'Bike.Number','index'
sp_rename 'Bike.dteday','date'
sp_rename 'Bike.yr','year'
sp_rename 'Bike.mnth','months'
sp_rename 'Bike.hr','hours'
sp_rename 'Bike.weathersit','weather'
sp_rename 'Bike.temp','temperature'
sp_rename 'Bike.hum','humidity'
sp_rename 'Bike.count of casual users','count_of_casual_users'
sp_rename 'Bike.count of registered users','count_of_registered_users'
sp_rename 'Bike.total rental bikes','total_rental_bikes'


--cleninng data
alter table dbo.hour
alter column season nvarchar(10)

update Bikeshare.dbo.bike
SET season = 
    CASE 
        WHEN season = '1' THEN 'Winter' 
        WHEN season = '2' THEN 'Spring'
		WHEN season = '3' THEN 'Summer' 
        WHEN season = '4' THEN 'Fall' 
    END


update Bikeshare.dbo.Bike
SET year = 
    CASE 
        WHEN year = 0 THEN 2011 
        WHEN year = 1 THEN 2012 
    END

alter table dbo.Bike
alter column mnth nvarchar(10)

update Bikeshare.dbo.Bike
SET months = 
    CASE 
        WHEN months = 1 THEN 'January' 
        WHEN months = 2 THEN 'February'
		WHEN months = 3 THEN 'March' 
        WHEN months = 4 THEN 'April' 
		WHEN months = 5 THEN 'May' 
        WHEN months = 6 THEN 'June'
		WHEN months = 7 THEN 'July' 
        WHEN months = 8 THEN 'August'
		WHEN months = 9 THEN 'September' 
        WHEN months = 10 THEN 'October'
		WHEN months = 11 THEN 'November' 
        WHEN months = 12 THEN 'December'
    END



alter table dbo.Bike
alter column holiday nvarchar(10)

update Bikeshare.dbo.Bike
SET holiday = 
    CASE 
        WHEN holiday = 0 THEN 'NO' 
        WHEN holiday = 1 THEN 'YES' 
    END



alter table dbo.Bike
alter column weekday nvarchar(10)

update Bikeshare.dbo.Bike
SET weekday = 
    CASE 
        WHEN weekday = 0 THEN 'Sunday' 
        WHEN weekday = 1 THEN 'Monday'
		WHEN weekday = 2 THEN 'Tuesday' 
        WHEN weekday = 3 THEN 'Wednesday' 
		WHEN weekday = 4 THEN 'Thursday' 
        WHEN weekday = 5 THEN 'Friday'
		WHEN weekday = 6 THEN 'Saturday'
	END



alter table dbo.Bike
alter column workingday nvarchar(20)

update Bikeshare.dbo.Bike
SET workingday = 
    CASE 
        WHEN workingday = 0 THEN 'Weekend or Holiday' 
        WHEN workingday = 1 THEN 'Work day' 
    END


alter table dbo.Bike
alter column weathersit nvarchar(15)

update Bikeshare.dbo.Bike
SET weather = 
    CASE 
        WHEN weather = '1' THEN 'Clear' 
        WHEN weather = '2' THEN 'cloudy'
		WHEN weather = '3' THEN 'light_rain_snow' 
        WHEN weather = '4' THEN 'heavy_rain_snow'
    END


update Bikeshare.dbo.Bike 
set humidity = humidity * 100


update Bikeshare.dbo.Bike 
set windspeed = windspeed *67


select 
	case 
			when total_rental_bikes = count_of_casual_users + count_of_registered_users then 'True'
			else 'false'
		end as equal,
		count(
		case 
			when total_rental_bikes = count_of_casual_users + count_of_registered_users then 'True'
			else 'false'
		end )
from Bike
group by case 
			when total_rental_bikes = count_of_casual_users + count_of_registered_users then 'True'
			else 'false'
		end



------------------------------------------------------------------------------
--Q1 what is the most year have rental bikes?
select  year,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by year





-- Q2 what is the most month have rental bikes?
select  months,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by months
order by 4



-- Q3 what is the most season have rental bikes?

select  season ,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered
from bike 
group by season

--Q4 what is the most working day?
select  weekday,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by weekday
order by weekday





--Q5 combare the catogry of customer by weather and season?
select  season,weather,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by season,weather
order by 4



--Q6 combare months with registered ?



--Q7 combare weather with humidity?

select  weather,avg(humidity) avg_humidity,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by weather
order by 1



--Q8 combare weather with windspeed?

select  weather,avg(windspeed) avg_widspeed,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by weather
order by 1


--Q9 combare weather with temp?
select  weather,avg(temperature) avg_temperature,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by weather
order by 1

--Q10 what is the most hour in day by months have a total rental bikes?

select  months,hours,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by months,hours
order by 1,2


select  months,weekday,
		sum(count_of_casual_users) casual,
		sum(count_of_registered_users) registered,
		sum(total_rental_bikes) total_rental_bikes
from Bike
group by months,weekday
order by 1,2
