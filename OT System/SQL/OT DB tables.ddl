  -- Products table
  CREATE TABLE "PRODUCTS" 
   (	"PRODUCT_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 289 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"PRODUCT_NAME" VARCHAR2(255) NOT NULL ENABLE, 
	"DESCRIPTION" VARCHAR2(2000), 
	"STANDARD_COST" NUMBER(9,2), 
	"LIST_PRICE" NUMBER(9,2), 
	"CATEGORY_ID" NUMBER NOT NULL ENABLE, 
	 PRIMARY KEY ("PRODUCT_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "PRODUCTS" ADD CONSTRAINT "FK_PRODUCTS_CATEGORIES" FOREIGN KEY ("CATEGORY_ID")
	  REFERENCES "PRODUCT_CATEGORIES" ("CATEGORY_ID") ON DELETE CASCADE ENABLE;

--Product Categories table
  CREATE TABLE "PRODUCT_CATEGORIES" 
   (	"CATEGORY_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 6 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"CATEGORY_NAME" VARCHAR2(255) NOT NULL ENABLE, 
	 PRIMARY KEY ("CATEGORY_ID")
  USING INDEX  ENABLE
   ) ;

-- Region table
  CREATE TABLE "REGIONS" 
   (	"REGION_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 5 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"REGION_NAME" VARCHAR2(50) NOT NULL ENABLE, 
	 PRIMARY KEY ("REGION_ID")
  USING INDEX  ENABLE
   ) ;

-- Contacts table
  CREATE TABLE "CONTACTS" 
   (	"CONTACT_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 320 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"FIRST_NAME" VARCHAR2(255) NOT NULL ENABLE, 
	"LAST_NAME" VARCHAR2(255) NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(255) NOT NULL ENABLE, 
	"PHONE" VARCHAR2(20), 
	"CUSTOMER_ID" NUMBER, 
	 PRIMARY KEY ("CONTACT_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "CONTACTS" ADD CONSTRAINT "FK_CONTACTS_CUSTOMERS" FOREIGN KEY ("CUSTOMER_ID")
	  REFERENCES "CUSTOMERS" ("CUSTOMER_ID") ON DELETE CASCADE ENABLE;

-- Countries table
  CREATE TABLE "COUNTRIES" 
   (	"COUNTRY_ID" CHAR(2), 
	"COUNTRY_NAME" VARCHAR2(40) NOT NULL ENABLE, 
	"REGION_ID" NUMBER, 
	 PRIMARY KEY ("COUNTRY_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "COUNTRIES" ADD CONSTRAINT "FK_COUNTRIES_REGIONS" FOREIGN KEY ("REGION_ID")
	  REFERENCES "REGIONS" ("REGION_ID") ON DELETE CASCADE ENABLE;

-- Customers table
  CREATE TABLE "CUSTOMERS" 
   (	"CUSTOMER_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 320 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"NAME" VARCHAR2(255) NOT NULL ENABLE, 
	"ADDRESS" VARCHAR2(255), 
	"WEBSITE" VARCHAR2(255), 
	"CREDIT_LIMIT" NUMBER(8,2), 
	 PRIMARY KEY ("CUSTOMER_ID")
  USING INDEX  ENABLE
   ) ;

--Employees table
  CREATE TABLE "EMPLOYEES" 
   (	"EMPLOYEE_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 108 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"FIRST_NAME" VARCHAR2(255) NOT NULL ENABLE, 
	"LAST_NAME" VARCHAR2(255) NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(255) NOT NULL ENABLE, 
	"PHONE" VARCHAR2(50) NOT NULL ENABLE, 
	"HIRE_DATE" DATE NOT NULL ENABLE, 
	"MANAGER_ID" NUMBER(12,0), 
	"JOB_TITLE" VARCHAR2(255) NOT NULL ENABLE, 
	 PRIMARY KEY ("EMPLOYEE_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "FK_EMPLOYEES_MANAGER" FOREIGN KEY ("MANAGER_ID")
	  REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ON DELETE CASCADE ENABLE;

--Inventory table
  CREATE TABLE "INVENTORIES" 
   (	"PRODUCT_ID" NUMBER(12,0), 
	"WAREHOUSE_ID" NUMBER(12,0), 
	"QUANTITY" NUMBER(8,0) NOT NULL ENABLE, 
	 CONSTRAINT "PK_INVENTORIES" PRIMARY KEY ("PRODUCT_ID", "WAREHOUSE_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "INVENTORIES" ADD CONSTRAINT "FK_INVENTORIES_PRODUCTS" FOREIGN KEY ("PRODUCT_ID")
	  REFERENCES "PRODUCTS" ("PRODUCT_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "INVENTORIES" ADD CONSTRAINT "FK_INVENTORIES_WAREHOUSES" FOREIGN KEY ("WAREHOUSE_ID")
	  REFERENCES "WAREHOUSES" ("WAREHOUSE_ID") ON DELETE CASCADE ENABLE;

-- Locations table
  CREATE TABLE "LOCATIONS" 
   (	"LOCATION_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 24 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"ADDRESS" VARCHAR2(255) NOT NULL ENABLE, 
	"POSTAL_CODE" VARCHAR2(20), 
	"CITY" VARCHAR2(50), 
	"STATE" VARCHAR2(50), 
	"COUNTRY_ID" CHAR(2), 
	 PRIMARY KEY ("LOCATION_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "LOCATIONS" ADD CONSTRAINT "FK_LOCATIONS_COUNTRIES" FOREIGN KEY ("COUNTRY_ID")
	  REFERENCES "COUNTRIES" ("COUNTRY_ID") ON DELETE CASCADE ENABLE;

-- Orders table
  CREATE TABLE "ORDERS" 
   (	"ORDER_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 106 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"CUSTOMER_ID" NUMBER(6,0) NOT NULL ENABLE, 
	"STATUS" VARCHAR2(20) NOT NULL ENABLE, 
	"SALESMAN_ID" NUMBER(6,0), 
	"ORDER_DATE" DATE NOT NULL ENABLE, 
	 PRIMARY KEY ("ORDER_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "ORDERS" ADD CONSTRAINT "FK_ORDERS_CUSTOMERS" FOREIGN KEY ("CUSTOMER_ID")
	  REFERENCES "CUSTOMERS" ("CUSTOMER_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "ORDERS" ADD CONSTRAINT "FK_ORDERS_EMPLOYEES" FOREIGN KEY ("SALESMAN_ID")
	  REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ON DELETE SET NULL ENABLE;

-- Orders_items table
  CREATE TABLE "ORDER_ITEMS" 
   (	"ORDER_ID" NUMBER(12,0), 
	"ITEM_ID" NUMBER(12,0), 
	"PRODUCT_ID" NUMBER(12,0) NOT NULL ENABLE, 
	"QUANTITY" NUMBER(8,2) NOT NULL ENABLE, 
	"UNIT_PRICE" NUMBER(8,2) NOT NULL ENABLE, 
	 CONSTRAINT "PK_ORDER_ITEMS" PRIMARY KEY ("ORDER_ID", "ITEM_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "ORDER_ITEMS" ADD CONSTRAINT "FK_ORDER_ITEMS_ORDERS" FOREIGN KEY ("ORDER_ID")
	  REFERENCES "ORDERS" ("ORDER_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "ORDER_ITEMS" ADD CONSTRAINT "FK_ORDER_ITEMS_PRODUCTS" FOREIGN KEY ("PRODUCT_ID")
	  REFERENCES "PRODUCTS" ("PRODUCT_ID") ON DELETE CASCADE ENABLE;

--Warehouses table
  CREATE TABLE "WAREHOUSES" 
   (	"WAREHOUSE_ID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 10 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"WAREHOUSE_NAME" VARCHAR2(255), 
	"LOCATION_ID" NUMBER(12,0), 
	 PRIMARY KEY ("WAREHOUSE_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "WAREHOUSES" ADD CONSTRAINT "FK_WAREHOUSES_LOCATIONS" FOREIGN KEY ("LOCATION_ID")
	  REFERENCES "LOCATIONS" ("LOCATION_ID") ON DELETE CASCADE ENABLE;
