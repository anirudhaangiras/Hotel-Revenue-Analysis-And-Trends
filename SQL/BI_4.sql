-- What is the cancellation rate, and does it vary based on the year?
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

-- What is the cancellation rate, and does it vary based on the hotel type?
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

-- What is the cancellation rate, and does it vary based on the market segment?
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

-- What is the cancellation rate, and does it vary based on the lead time?
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