# COVID-19 Data Analysis Using SQL

This project leverages SQL to analyze and visualize trends in COVID-19 data. It involves data exploration, calculations, and transformations across datasets such as deaths, vaccinations, and population statistics.

## Project Features
- **Total Cases vs Total Deaths**:
  - Calculates the death percentage relative to total cases.
  - Filters data by specific regions or countries.
  
- **Vaccination Analysis**:
  - Tracks daily vaccinations and computes cumulative values.
  - Joins vaccination and death datasets for a comprehensive view.

- **Continent-Level Analysis**:
  - Focuses on data from valid continents to ensure accurate aggregation.
  
- **Custom Views**:
  - Creates SQL views for reusable insights like percentage vaccinated.

## Tools and Technologies
- **SQL Server Management Studio (SSMS)**: Used for executing queries and managing the database.
- **SQL**: Primary language for querying and managing the data.

## How to Use
1. Clone or download the project repository.
2. Set up the database using the provided SQL schema and data.
3. Execute the queries in the SQL file to explore the data and insights.

## Data Sources
- The project assumes data is stored in a database called `[Portfolio_Project_1 (Covid)]`.
- Tables include:
  - `coviddeaths`
  - `covidvaccinations`

## Key SQL Concepts Used
- Window Functions (`SUM` with `OVER` for cumulative calculations).
- Joins (to combine related datasets).
- Views (for reusable data transformations).
- Sorting and filtering with `ORDER BY` and `WHERE`.

## Future Enhancements
- Extend analysis to include recovery rates.
- Add support for visualizing trends using external tools like Python or Tableau.

## Author
Aman P. Kapoor  
Aerospace Engineer passionate about data-driven problem-solving and innovative solutions.
