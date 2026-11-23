-- view the current factory names and product IDs
SELECT factory, product_id
FROM products;

-- Remove apostrophe and replace space with hypens
SELECT factory, product_id,
		REPLACE(replace(factory,"'","")," ","-") AS factory_product_id
FROM products
ORDER BY factory, product_id;

-- Create new ID column called factory_product_id
SELECT factory, product_id,
		concat(factory,'-',product_id) AS factory_product_id
FROM products
ORDER BY factory, product_id;
