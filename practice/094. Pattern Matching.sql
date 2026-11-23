SELECT product_name,
	replace(product_name,'Wonka Bar - ','') AS  new_product_name
FROM products;
