--1.1 What is the cancellation rate, and does it vary based on the year?
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

--1.2 What is the cancellation rate, and does it vary based on the hotel type?
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

--1.3 What is the cancellation rate, and does it vary based on the market segment?
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

--1.4 What is the cancellation rate, and does it vary based on the lead time?
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
	ELSE 'More than 30 Days'
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
	ELSE 'More than 30 Days'
	END
ORDER BY cancellation_rate DESC;

--2. What is the average daily rate (ADR) for each hotel, and how does it change over the months of the year?
WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT arrival_date_year AS year, arrival_date_month AS month_city_hotel, AVG(adr) AS Average_Daily_Rate
FROM hotels
WHERE hotel = 'City Hotel'
GROUP BY arrival_date_year, arrival_date_month
ORDER BY arrival_date_year;

WITH hotels AS (
SELECT * FROM hotel_2018
UNION ALL
SELECT * FROM hotel_2019
UNION ALL
SELECT * FROM hotel_2020
)

SELECT arrival_date_year AS year, arrival_date_month AS month_resort, AVG(adr) AS Average_Daily_Rate
FROM hotels
WHERE hotel = 'Resort Hotel'
GROUP BY arrival_date_year, arrival_date_month
ORDER BY arrival_date_year;

--3. Is there any correlation between the number of booking changes and the cancellation rate?
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

--4. How does the total number of special requests affect the ADR and lead time?
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
ORDER BY total_of_special_requests;

--5. How does the meal cost vary with the customer type?
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