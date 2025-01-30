Exploring Renewable Energy Trends: A Data-Driven Investigation

🚗 The Spark: How a Daily Commute Led to a Data-Driven Discovery
As I drove through my neighborhood, I couldn't help but notice an increasing number of solar panels on rooftops. This made me wonder—has renewable energy consumption truly increased over time, or is this just an isolated trend?

With this question in mind, I turned to data. Using publicly available datasets from the U.S. Energy Information Administration (EIA), I set out to analyze trends in renewable energy production and consumption from 2015 to 2021.

📊 Data-Driven Approach: SQL, Python & Power BI
To uncover key insights, I used:

SQL to extract, filter, and clean data on renewable energy consumption and production.
Python (pandas, matplotlib, seaborn, scikit-learn) for linear regression modeling to analyze growth trends.
Power BI to create interactive dashboards showcasing state-wise energy trends.
I focused on answering:
✔️ Which states consume the most renewable energy?
✔️ Which states produce the most renewable energy?
✔️ How has renewable energy production and consumption changed over time?
✔️ Are there patterns indicating future growth or decline?

📣 How This Ties into Federal Sustainability Goals
The federal government is aggressively pushing for a clean energy future, backed by major legislative initiatives:
✅ The Bipartisan Infrastructure Law – Investing in modernizing energy infrastructure.
✅ The Build Back Better Act – Funding renewable energy projects.
✅ The Inflation Reduction Act – Driving $80 billion in private investment in clean energy manufacturing.

With 600,000 federal vehicles transitioning to electric and 300,000 federal buildings adopting clean energy, analyzing these trends is critical for understanding the impact of sustainability efforts.


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
I consolidated the datasets into a single sheet, ensuring data consistency by cleaning and formatting the entries. To provide a clearer analysis, I excluded years where relevant technology had not yet emerged, allowing for a more accurate representation of the U.S.'s renewable energy trends. Finally, I uploaded the cleaned dataset into Power BI, where I began the visual analysis to uncover key insights.

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
2. Extracting Data from DataFrames

```python
xc = dc.iloc[:,1].values
yc = dc.iloc[:,2].values
xp = dp.iloc[:,1].values
yp = dp.iloc[:,2].values
```
3. Plotting the Data

```python
plt.scatter(xc,yc)
plt.scatter(xp,yp)
plt.xlabel("Time")
plt.ylabel("Quadrillion Btu")
```
![download](https://github.com/user-attachments/assets/6efe4ca8-c63b-46a2-b783-3fba06375fb8)

4. Create Visualization of production

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

🔍 Key Findings & Insights
📈 Renewable energy consumption has steadily increased, particularly in states with high solar adoption (e.g., California, Texas).
📉 Some states still rely heavily on fossil fuels, highlighting gaps in adoption.
🔄 Production is growing but not at the same rate as consumption, indicating possible future supply chain bottlenecks.

💡 What I Learned
This project deepened my understanding of:
✅ SQL for large-scale data extraction and transformation
✅ Python for trend analysis & predictive modeling
✅ Power BI for dynamic, interactive visual storytelling

This hands-on experience strengthened my ability to turn raw data into actionable insights—a key skill in the field of data analytics and business intelligence.

Would love to hear your thoughts! 🚀
I downloaded the data from the years 2015 to 2021 on the website
This research was built on using data retrieved from the [U.S. Energy Information Administration (EIA)](https://www.eia.gov/opendata/).
