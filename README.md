# Hotel Revenue Analysis and Booking Trends: Unveiling Insights with SQL and Power BI
This data-driven project explores a comprehensive hotel revenue dataset spanning three years (2018, 2019, and 2020). We dive into various business questions by leveraging SQL and Power BI to uncover valuable insights and booking trends. We analyze the overall hotel revenue, cancellation rates, ADR, and booking lead time through SQL queries. We investigate how hotel type, customer type, and the total number of special requests influence these metrics.

Combining data from multiple tables, we delve into market segments and meal costs, examining their impact on hotel revenue and booking patterns. The SQL analyses led us to design a dynamic Power BI dashboard, showcasing intuitive visualizations and interactive elements. The dashboard visually presents our findings, enabling stakeholders to easily explore hotel performance, customer preferences, and revenue drivers.

## Business Questions
The project addresses the following key business questions:

1. What is the overall hotel revenue for the given period?
2. How does the revenue vary between the two hotels?
3. What is the cancellation rate, and does it vary based on factors like hotel type, customer type, or booking lead time?
4. What is the average daily rate (ADR) for each hotel, and how does it change over the months of the year?
5. Which market segments and distribution channels contribute the most to the hotel's revenue?
6. Is there any correlation between the number of booking changes and the cancellation rate?
7. How does the total number of special requests affect the ADR and lead time?
8. How does the meal cost vary with the customer type?

## Data Source
The dataset used in this analysis is sourced from [Kaggle](https://www.kaggle.com/datasets/govindkrishnadas/hotel-revenue). It consists of hotel booking, and room rate cost data from 2018, 2019, and 2020, along with additional tables containing market segment information and meal costs.

## SQL Analysis

### Business Problem 1
`
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT arrival_date_year AS year,
round(sum((stays_in_week_nights + stays_in_weekend_nights)*adr*discount),2) AS total_revenue
FROM hotels h
left join market_segment ms
on h.market_segment = ms.market_segment
GROUP BY arrival_date_year;
`

