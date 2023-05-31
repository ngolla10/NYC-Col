-- select * from CRASH_0NF


-- First Graph - People Killed in Each BOROUGH
-- select BOROUGH, SUM(NUMBEROFPERSONSKILLED) AS number_of_people_killed from CRASH_0NF
-- where BOROUGH in ('BRONX', 'BROOKLYN', 'MANHATTAN', 'QUEENS', 'STATEN ISLAND')
-- GROUP BY BOROUGH


-- Second Graph - People Killed at Each Time
-- select CRASHTIME as Crash_Times, SUM(NUMBEROFPERSONSKILLED) AS number_of_people_killed from CRASH_0NF 
-- group by CRASHTIME


-- Third Graph - Number of Injuries Per CONTRIBUTING FACTOR
-- select CONTRIBUTINGFACTORVEHICLE1 as Contributing_Factor, SUM(NUMBEROFPERSONSINJURED) AS number_of_people_injured from CRASH_0NF 
-- where CONTRIBUTINGFACTORVEHICLE1 is not null and CONTRIBUTINGFACTORVEHICLE1 != 1 and CONTRIBUTINGFACTORVEHICLE1 != 80
-- group by CONTRIBUTINGFACTORVEHICLE1

-- Fourth Graph - Number of People Injured in Each Zip Code
-- select ZIPCODE as Zipcodes, SUM(NUMBEROFPERSONSINJURED) as number_people_injured from CRASH_0NF
-- Where ZIPCODE is not Null
-- group by ZIPCODE
