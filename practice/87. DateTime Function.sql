WITH dt AS (SELECT transaction_id,
        customer_id,
        order_id,
        STR_TO_DATE(order_date, '%m/%d/%Y') AS order_date,
        QUARTER(STR_TO_DATE(order_date, '%m/%d/%Y')) AS qr
        FROM orders)
SELECT order_id,
        order_date,DATE_ADD(order_date, INTERVAL 2 day) AS ship_date 
FROM dt
WHERE YEAR(order_date) = 2024 AND qr = 2;
