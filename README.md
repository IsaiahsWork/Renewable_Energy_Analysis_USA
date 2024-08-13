Introduction

Due to the rise of renewable energy, I was wondering if consumption of this energy, depending on the varieties increased over time.
I downloaded the data from the years 2015 to 2021 on the website
This research was built on using data retrieved from the [U.S. Energy Information Administration (EIA)](https://www.eia.gov/opendata/).

```sql
SELECT
	Description,
	YYYYMM,
	Unit,
	Value
FROM
	PROD
WHERE
	Description = 'Total Renewable Energy Production' and YYYYMM >= 200901 AND
	value < 1;
ORER BY
	YYYYMM DESC
```
```sql
SELECT
	Description,
	YYYYMM,
	Unit,
	Value
FROM
	PROD
WHERE
	Description = 'Total Renewable Energy Consumption' and YYYYMM >= 200901 AND
	value < 1;
ORER BY
	YYYYMM DESC
```
I then compiled them in one single sheet and cleaned the data, formatted the cells, and cleaned the region data. i excluded yearrs due to technology having not yet existed yet, to generalize how the US specifically has been interacting with renewable energy so I put all that in one single style. I then uploaded the dataset in Power BI and started the visual analysis

🔍 

Background

The questions I wanted to answer through my queries were:
What states consume the most energy, specifically  renewable? (SQL, Power BI)
What states produce the most energy, specifically  renewable? (SQL, Power BI)
Rate of Regression of the production of Renewable Energy in America? (SQL, Python)
Rate of Regression of the consumption of Renewable Energy in America? (SQL, Python)

Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

SQL: The backbone of my analysis, allowing me to query the database and unearth critical insights.
MySQL: The chosen database management system, ideal for handling the job posting data.
Visual Studio Code: My go-to for database management and executing python.
Git & GitHub: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

The Python Linear Regression Analysis

1. Importing libraries and cleaned tables to Jupyter Notebook for Regression Analysis.

```python
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

urlp = 'https://raw.githubusercontent.com/IsaiahsWork/Research-Work/main/EDITP.csv'
urlc = 'https://raw.githubusercontent.com/IsaiahsWork/Research-Work/main/EDITC.csv'

dc = pd.read_csv(urlc)
dp = pd.read_csv(urlp)
```
1. Importing libraries and cleaned tables to Jupyter Notebook for Regression Analysis.

```python
xc = dc.iloc[:,1].values
yc = dc.iloc[:,2].values
xp = dp.iloc[:,1].values
yp = dp.iloc[:,2].values
```
```python
plt.scatter(xc,yc)
plt.scatter(xp,yp)
plt.xlabel("Time")
plt.ylabel("Quadrillion Btu")
```
![download](https://github.com/user-attachments/assets/6efe4ca8-c63b-46a2-b783-3fba06375fb8)

2. create Visualization of production

```python
from sklearn.model_selection import train_test_split
xc_train, xc_test, yc_train, yc_test = train_test_split(xc, yc, test_size=0.2, random_state=0)
xp_train, xp_test, yp_train, yp_test = train_test_split(xp, yp, test_size=0.2, random_state=0)
xp_train
```
```python
xp_train = np.array(xp_train).reshape(-1,1)
xc_train = np.array(xc_train).reshape(-1,1)
xp_test = np.array(xp_test).reshape(-1,1)
xc_test = np.array(xc_test).reshape(-1,1)
xp_train
```
```python
from sklearn.linear_model import LinearRegression
plr = LinearRegression()
clr = LinearRegression()
```
```python
cc = clr.intercept_
pc = plr.intercept_
```
```python
cm = clr.coef_
pm = plr.coef_
```
```python
YP_pred_train = pm*xp_train+pc
YC_pred_train = cm*xc_train+cc
YP_pred_train.flatten()
YC_pred_train.flatten()
```
```python
plt.scatter(xc_train,yc_train)
plt.scatter(xp_train,yp_train)
plt.plot(xp_train, YP_pred_train, color='red')
plt.plot(xc_train, YC_pred_train, color='green')
plt.xlabel("Time")
plt.ylabel("Quadrillion Btu")
```
![download](https://github.com/user-attachments/assets/851f38b9-7fdb-490c-8a29-020cc285fb23)

What I Learned
Throughout this adventure, I've increased my Power BI toolkit with some serious firepower:
Query Crafting: Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
 Analytical Wizardry: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

Conclusions


This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a 
