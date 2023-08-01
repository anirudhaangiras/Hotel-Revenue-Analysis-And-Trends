-- How does the overall revenue vary for the given period between the two hotels?
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