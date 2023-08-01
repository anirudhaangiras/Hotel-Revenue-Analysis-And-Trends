-- How does the total number of special requests affect the ADR and lead time?
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

