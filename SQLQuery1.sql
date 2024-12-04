--select * 
--from [Portfolio_Project_1 (Covid)].dbo.coviddeaths
--where continent is not null
--order by 3, 4 

--select * 
--from [Portfolio_Project_1 (Covid)].dbo.covidvaccinations
--order by 3, 4 

	
 -- Total cases v/s Total deaths
 
 select iso_code, location, DATE, total_cases, total_deaths, (total_deaths/total_cases) * 100 as death_percentage
from [Portfolio_Project_1 (Covid)].dbo.coviddeaths
 where iso_code like '%ind%'
 where continent is not null
 order by location, date;

 -- Total cases v/s population

  select iso_code, location, DATE, total_cases, population, (total_cases/population) * 100 as effected_population
from [Portfolio_Project_1 (Covid)].dbo.coviddeaths
 where iso_code like '%ind%'
 where continent is not null
 order by location, date;

 -- Highest infection rate among countries
 select location, population, Max(total_cases) as highest_infection, Max((total_cases/population)) * 100 as effected_population
from [Portfolio_Project_1 (Covid)].dbo.coviddeaths
 --where iso_code like '%ind%'
 group by location, population
where continent is not null
order by effected_population desc;

 -- fatality among countries
  select location,  population, Max(cast(total_deaths as int)) as fatality
from [Portfolio_Project_1 (Covid)].dbo.coviddeaths
 where continent is not null
 group by location, population
  order by fatality desc;

   --continents with highest death per capita

  select continent,  Max(cast(total_deaths as int)) as fatality
from [Portfolio_Project_1 (Covid)].dbo.coviddeaths
 where continent is not null
 group by continent
 order by fatality desc;

 --Global figures per day
 
 select date, Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths,  Sum(cast(new_deaths as int))/
 sum(new_cases) * 100 AS global_death_percentage
 from [Portfolio_Project_1 (Covid)].dbo.coviddeaths
 where continent is not null
 group by date
 order by 1, 2;
  
  --Global figures

  select Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths,  Sum(cast(new_deaths as int))/
 sum(new_cases) * 100 AS global_death_percentage
 from [Portfolio_Project_1 (Covid)].dbo.coviddeaths
 where continent is not null
 --group by date
 order by 1, 2;

 --matching both the tables

 select * 
 from [Portfolio_Project_1 (Covid)].dbo.covidvaccinations Vacc
 join [Portfolio_Project_1 (Covid)].dbo.coviddeaths Dea
 on dea.iso_code = vacc.iso_code
 and dea.date = vacc.date 

 --No. of total vacinnated individuals 

 select dea.continent, dea. location, dea. date, dea.population, vacc.people_vaccinated
 from [Portfolio_Project_1 (Covid)].dbo.covidvaccinations Vacc
 join [Portfolio_Project_1 (Covid)].dbo.coviddeaths Dea
 on dea.iso_code = vacc.iso_code
 and dea.date = vacc.date 
 where dea.location like 'india'
 --where dea.continent is not null
 order by dea. location, dea. date;

 --new vaccination per day

 select dea.continent, dea. location, dea. date, dea.population, vacc.new_vaccinations,
 SUM (convert(int, vacc.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as vaccination_per_day
 from [Portfolio_Project_1 (Covid)].dbo.covidvaccinations Vacc
 join [Portfolio_Project_1 (Covid)].dbo.coviddeaths Dea
 on dea.iso_code = vacc.iso_code
 and dea.date = vacc.date 
where dea.location like 'india'
--where dea.continent is not null
 order by dea. location, dea. date;

 --new vaccination per day

 select dea.continent, dea. location, dea. date, dea.population, vacc.new_vaccinations,
 SUM (convert(int, vacc.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
 as vaccination_per_day 
 from [Portfolio_Project_1 (Covid)].dbo.covidvaccinations Vacc
 join [Portfolio_Project_1 (Covid)].dbo.coviddeaths Dea
 on dea.iso_code = vacc.iso_code
 and dea.date = vacc.date 
where dea.location like 'india'
--where dea.continent is not null
 order by dea. location, dea. date;

 --creating CTE

 with POPVSVACC (continent, location, date, population, new_vaccinations, vaccination_per_day)
 as
 (
 select dea.continent, dea. location, dea. date, dea.population, vacc.new_vaccinations,
 SUM (convert(int, vacc.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
 as vaccination_per_day 
 from [Portfolio_Project_1 (Covid)].dbo.covidvaccinations Vacc
 join [Portfolio_Project_1 (Covid)].dbo.coviddeaths Dea
 on dea.iso_code = vacc.iso_code
 and dea.date = vacc.date 
where dea.continent is not null
  )
  select*, (vaccination_per_day / population)*100
  from POPVSVACC
  where location like 'india'


  -- data visulation creating view
  USE [Portfolio_Project_1 (Covid)];
  go
  create view percentage_vaccinated as
  select dea.continent, dea. location, dea. date, dea.population, vacc.new_vaccinations,
 SUM (convert(int, vacc.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
 as vaccination_per_day 
 from [Portfolio_Project_1 (Covid)].dbo.covidvaccinations Vacc
 join [Portfolio_Project_1 (Covid)].dbo.coviddeaths Dea
 on dea.iso_code = vacc.iso_code
 and dea.date = vacc.date 
where dea.continent is not null
 --order by dea. location, dea. date;
 