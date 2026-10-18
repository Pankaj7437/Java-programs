UPDATE products SET price = 14999.00, discount = 15.00 WHERE product_id = 1;
UPDATE products SET price = 89999.00, discount = 10.00 WHERE product_id = 2;
UPDATE products SET price = 4999.00, discount = 20.00 WHERE product_id = 3;
UPDATE products SET price = 2499.00, discount = 10.00 WHERE product_id = 4;
UPDATE products SET price = 1899.00, discount = 15.00 WHERE product_id = 5;
UPDATE products SET price = 2799.00, discount = 10.00 WHERE product_id = 6;
UPDATE products SET price = 2299.00, discount = 15.00 WHERE product_id = 7;
UPDATE products SET price = 4499.00, discount = 15.00 WHERE product_id = 8;
UPDATE products SET price = 6999.00, discount = 10.00 WHERE product_id = 9;
UPDATE products SET price = 1650.00, discount = 10.00 WHERE product_id = 10;
UPDATE products SET price = 1490.00, discount = 10.00 WHERE product_id = 11;
UPDATE products SET price = 1299.00, discount = 10.00 WHERE product_id = 12;
UPDATE products SET price = 18999.00, discount = 15.00 WHERE product_id = 13;
UPDATE products SET price = 5499.00, discount = 20.00 WHERE product_id = 14;
UPDATE products SET price = 2999.00, discount = 15.00 WHERE product_id = 15;
UPDATE products SET price = 6799.00, discount = 15.00 WHERE product_id = 16;
UPDATE products SET price = 28500.00, discount = 20.00 WHERE product_id = 17;
UPDATE products SET price = 8999.00, discount = 10.00 WHERE product_id = 18;
UPDATE products SET price = 1250.00, discount = 10.00 WHERE product_id = 19;
UPDATE products SET price = 4999.00, discount = 25.00 WHERE product_id = 20;
UPDATE products SET price = 11999.00, discount = 15.00 WHERE product_id = 21;
UPDATE products SET price = 6499.00, discount = 15.00 WHERE product_id = 22;
UPDATE products SET price = 3499.00, discount = 15.00 WHERE product_id = 23;
UPDATE products SET price = 78999.00, discount = 10.00 WHERE product_id = 24;
UPDATE products SET price = 14499.00, discount = 15.00 WHERE product_id = 25;
UPDATE products SET price = 2199.00, discount = 10.00 WHERE product_id = 26;

UPDATE coupons SET discount_value = 10.00, minimum_order = 999.00, maximum_discount = 500.00 WHERE code = 'WELCOME10';
UPDATE coupons SET discount_type = 'FIXED', discount_value = 250.00, minimum_order = 1999.00, maximum_discount = 250.00 WHERE code = 'FLAT20';
MERGE INTO coupons (coupon_id, code, discount_type, discount_value, minimum_order, maximum_discount, expiry_date, status) KEY(code)
VALUES (3, 'FESTIVE50', 'FIXED', 500.00, 4999.00, 500.00, TIMESTAMP '2028-12-31 23:59:59', TRUE);

UPDATE orders SET total_amount = 14999.00, discount = 1500.00, shipping_fee = 0.00, final_amount = 13499.00 WHERE order_id = 1001;
UPDATE order_items SET price = 14999.00 WHERE order_id = 1001 AND product_id = 1;
UPDATE payments SET amount = 13499.00 WHERE order_id = 1001;

UPDATE orders SET total_amount = 4999.00, discount = 0.00, shipping_fee = 0.00, final_amount = 4999.00 WHERE order_id = 1002;
UPDATE order_items SET price = 4999.00 WHERE order_id = 1002 AND product_id = 3;
UPDATE payments SET amount = 4999.00 WHERE order_id = 1002;
