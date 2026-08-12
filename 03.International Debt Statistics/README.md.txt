International Debt Analysis

Project Overview:
	This project analyzes international debt data collected by the World Bank.
	The dataset contains information on the amount of debt owed by developing countries across
	different debt categories.
	
Questions:
	1. How many distinct countries are included in the dataset?
	2. Which country has the highest amount of debt?
	3. Which country has the lowest principal repayment?

SQL Skills:
	1. COUNT(DISTINCT()) : counting unique countries
	2. SUM() : calculating total debt amount
	3. ORDER BY and LIMIT : ranking and selecting results
	4. WHERE : filtering by indicator codes
	5. AS : Aliasing

Key Findings:
	1. How many distinct countries are included in the dataset? 124
	2. Which country has the highest amount of debt? 
		country name: China 
		total debt : $285,793,494,734.2
	3. Which country has the lowest principal repayment?
		country name : Timor_leste
		indicator name : Principal repayments on external debt, long-term (AMT, current US$)
		lowest repayment : $825,000