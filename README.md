# PopulationProject
Project for EGME 202. Use existing population data of a certain group of people to create a function to estimate future populations. 

Our groups project is looking at US state populations over the last 5 years. 
Our dataset is from the data.census.gov website and has provided an estimate 
for the population of every individual state from 2010 to 2025. Our data came in 2 files, 
one from 2010-2020 and another from 2020-2025. We first clean them up to only useful information,
we then concade them into 1 large dataset. We then merge individual states into east vs west
and use a seperate function called growth_simulation with a logistic growht model to estimate
futrue east vs west populations for the next 10 years.
