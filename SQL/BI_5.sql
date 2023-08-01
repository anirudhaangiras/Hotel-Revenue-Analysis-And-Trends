-- What is the average daily rate (ADR) for each hotel, and how does it change over the months of the year?
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