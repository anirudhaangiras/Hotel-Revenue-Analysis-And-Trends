-- How does the revenue vary between the two hotel types?
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