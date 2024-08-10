CREATE OR REPLACE FORCE EDITIONABLE VIEW "INVENTORY_PER_CATEGORY" ("CATEGORY_NAME", "TOTAL_INVENTORY") AS 
  SELECT 
    pc.category_name,
    SUM(i.quantity) AS total_inventory
FROM 
    product_categories pc
INNER JOIN 
    products p ON pc.category_id = p.category_id
LEFT JOIN 
    inventories i ON p.product_id = i.product_id
GROUP BY 
    pc.category_name;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "MANAGER_SALES_STATS_VIEW" ("MANAGER_ID", "MANAGER_NAME", "NUM_SALES") AS 
  SELECT 
    m.employee_id AS manager_id,
    m.first_name || ' ' || m.last_name AS manager_name,
    COUNT(o.order_id) AS num_sales
FROM 
    employees m -- m represents managers
JOIN 
    employees e ON m.employee_id = e.manager_id -- e represents employees managed by m
JOIN 
    orders o ON e.employee_id = o.salesman_id
GROUP BY 
    m.employee_id, m.first_name, m.last_name;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "PRODUCT_CATEGORY" ("CATEGORY_NAME", "PRODUCT_COUNT") AS 
  SELECT 
    pc.category_name,
    COUNT(p.product_id) AS product_count
FROM 
    product_categories pc
LEFT JOIN 
    products p ON pc.category_id = p.category_id
GROUP BY 
    pc.category_name;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "SALES_REPORT" ("SALESMAN_ID", "SALESMAN_NAME", "NUM_OF_SALES") AS 
  SELECT 
    o.salesman_id,
    e.last_name AS salesman_name,
    COUNT(*) AS num_of_sales
FROM 
    orders o
JOIN 
    employees e ON o.salesman_id = e.employee_id
WHERE 
    o.status = 'Completed'
GROUP BY 
    o.salesman_id, e.last_name;
