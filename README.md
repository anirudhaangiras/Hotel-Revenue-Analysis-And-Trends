# Hotel Revenue Analysis and Booking Trends: Unveiling Insights with SQL and Power BI
This data-driven project explores a comprehensive hotel revenue dataset spanning three years (2018, 2019, and 2020). We dive into various business questions by leveraging SQL and Power BI to uncover valuable insights and booking trends. We analyze the overall hotel revenue, cancellation rates, ADR, and booking lead time through SQL queries. We investigate how hotel type, customer type, and the total number of special requests influence these metrics.

Combining data from multiple tables, we delve into market segments and meal costs, examining their impact on hotel revenue and booking patterns. The SQL analyses led us to design a dynamic Power BI dashboard, showcasing intuitive visualizations and interactive elements. The dashboard visually presents our findings, enabling stakeholders to easily explore hotel performance, customer preferences, and revenue drivers.

## Data Source
The dataset used in this analysis is sourced from [Kaggle](https://www.kaggle.com/datasets/govindkrishnadas/hotel-revenue). It consists of hotel booking, and room rate cost data from 2018, 2019, and 2020, along with additional tables containing market segment information and meal costs.

## SQL Analysis
The project addresses the following key business questions:

8. How does the meal cost vary with the customer type?

### Business Problem 1
1. What is the overall hotel revenue for the given period?
```
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
```
[](link)

2. How does the overall revenue vary between the two hotels?
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT hotel,
round(sum((stays_in_week_nights + stays_in_weekend_nights)*adr*discount),2) AS total_revenue
FROM hotels h
left join market_segment ms
on h.market_segment = ms.market_segment
GROUP BY hotel;
```
[](link)

3. How does the overall revenue vary for the given period between the two hotels?
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT arrival_date_year AS year, hotel,
round(sum((stays_in_week_nights + stays_in_weekend_nights)*adr*discount),2) AS total_revenue
FROM hotels h
LEFT JOIN market_segment ms
on h.market_segment = ms.market_segment
GROUP BY arrival_date_year, hotel
ORDER BY arrival_date_year;
```
[](link)

4. What is the cancellation rate, and does it vary based on factors like hotel type, customer type, or booking lead time?
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT arrival_date_year AS year,
SUM(CASE 
	WHEN is_canceled = 1 THEN 1 
	ELSE 0 
	END) AS canceled_bookings,
COUNT(*) AS total_bookings,
CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS cancellation_rate
FROM hotels
GROUP BY arrival_date_year
ORDER BY cancellation_rate DESC;
```
[](link)
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT hotel,
SUM(CASE 
	WHEN is_canceled = 1 THEN 1 
	ELSE 0 
	END) AS canceled_bookings,
COUNT(*) AS total_bookings,
CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS cancellation_rate
FROM hotels
GROUP BY hotel
ORDER BY cancellation_rate DESC;
```
[](link)
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT market_segment,
SUM(CASE 
	WHEN is_canceled = 1 THEN 1 
	ELSE 0 
	END) AS canceled_bookings,
COUNT(*) AS total_bookings,
CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS cancellation_rate
FROM hotels
GROUP BY market_segment
ORDER BY cancellation_rate DESC;
```
[](link)
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT 
CASE 
	WHEN lead_time <= 7 THEN '0-7 Days'
	WHEN lead_time > 7 AND lead_time <= 14 THEN '8-14 Days'
	WHEN lead_time > 14 AND lead_time <= 30 THEN '15-30 Days'
	ELSE 'More then 30 Days'
END AS lead_time_range,
SUM(CASE 
	WHEN is_canceled = 1 THEN 1 
	ELSE 0 
	END) AS canceled_bookings,
COUNT(*) AS total_bookings,
CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS cancellation_rate
FROM hotels
GROUP BY 
CASE 
	WHEN lead_time <= 7 THEN '0-7 Days'
	WHEN lead_time > 7 AND lead_time <= 14 THEN '8-14 Days'
	WHEN lead_time > 14 AND lead_time <= 30 THEN '15-30 Days'
	ELSE 'More then 30 Days'
	END
ORDER BY cancellation_rate DESC;
```
[](link)

5. What is the average daily rate (ADR) for each hotel, and how does it change over the months of the year?
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT arrival_date_month AS month_city_hotel, AVG(adr) AS Average_Daily_Rate
FROM hotels
WHERE hotel = 'City Hotel'
GROUP BY arrival_date_month
ORDER BY Average_Daily_Rate DESC;
```
[](link)
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT arrival_date_month AS month_resort, AVG(adr) AS Average_Daily_Rate
FROM hotels
WHERE hotel = 'Resort Hotel'
GROUP BY arrival_date_month
ORDER BY Average_Daily_Rate DESC;
```
[](link)

6. Which market segments and distribution channels contribute the most to the hotel's revenue?
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT h.market_segment, h.distribution_channel,
round(sum((stays_in_week_nights + stays_in_weekend_nights)*adr*discount),2) AS total_revenue
FROM hotels h
left join market_segment ms
on h.market_segment = ms.market_segment
left join meal_cost mc
on h.meal = mc.meal
GROUP BY h.market_segment, h.distribution_channel
ORDER BY total_revenue DESC;
```
[](link)

7. Is there any correlation between the number of booking changes and the cancellation rate?
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT 
CASE
	WHEN booking_changes >= 0 AND booking_changes <= 3 THEN '0-3 Changes'
	WHEN booking_changes >3 AND booking_changes <= 7 THEN '4-7 Changes'
	ELSE '7+ Changes'
END AS Booking_Changes_Range, 
COUNT(CASE
		WHEN booking_changes >= 0 AND booking_changes <= 3 THEN '0-3 Changes'
		WHEN booking_changes >3 AND booking_changes <= 7 THEN '4-7 Changes'
		ELSE '7+ Changes'
	  END) AS no_of_booking_changes,
CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS cancellation_rate
FROM hotels
GROUP BY 
CASE
	WHEN booking_changes >= 0 AND booking_changes <= 3 THEN '0-3 Changes'
	WHEN booking_changes >3 AND booking_changes <= 7 THEN '4-7 Changes'
	ELSE '7+ Changes'
END
ORDER BY cancellation_rate DESC;
```

8. How does the total number of special requests affect the ADR and lead time?
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT total_of_special_requests, AVG(adr) AS average_daily_rate, AVG(lead_time) AS average_lead_time
FROM hotels
WHERE total_of_special_requests <> 0
GROUP BY total_of_special_requests
ORDER BY total_of_special_requests ;
```
[](link)

9. How does the meal cost vary with the customer type?
```
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT h.customer_type, AVG(mc.Cost) AS average_meal_cost
FROM hotels AS h
LEFT JOIN meal_cost mc
on h.meal = mc.meal
GROUP BY h.customer_type
ORDER BY average_meal_cost DESC;
```
[](link)
