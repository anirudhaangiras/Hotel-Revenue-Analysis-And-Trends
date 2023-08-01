-- Is there any correlation between the number of booking changes and the cancellation rate?
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