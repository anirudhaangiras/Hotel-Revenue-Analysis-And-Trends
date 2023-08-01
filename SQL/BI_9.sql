-- How does the meal cost vary with the customer type?
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