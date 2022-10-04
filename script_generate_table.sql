CREATE TABLE orders (
    ORDER_REFERENCE VARCHAR2(255) NOT NULL PRIMARY KEY,
    ORDER_DATE DATE NOT NULL, 
    SUPPLIER_NAME VARCHAR2(2000), 
    SUPPLIER_CONTACT_NAME VARCHAR2(255), 
    SUPPLIER_ADDRESS VARCHAR2(2000),
    SUPP_CONTACT_NUMBER VARCHAR2(2000),
    SUPPLIER_EMAIL VARCHAR2(255)); 


CREATE TABLE order_details(
    ORDER_DETAILS_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ORDER_TOTAL_AMOUNT VARCHAR2(255), 
    ORDER_DESCRIPTION VARCHAR2(2000), 
    ORDER_STATUS VARCHAR2(10) not null, 
    ORDER_LINE_AMOUNT VARCHAR2(255), 
    ORDER_REFERENCE VARCHAR2(255),
    FOREIGN KEY (ORDER_REFERENCE) REFERENCES orders(ORDER_REFERENCE));


CREATE TABLE invoices(
    INVOICE_ID NUMBER GENERATED ALWAYS AS IDENTITY,
    INVOICE_REFERENCE VARCHAR2(255),
    INVOICE_DATE DATE, 
	INVOICE_STATUS VARCHAR2(7) ,
	INVOICE_HOLD_REASON VARCHAR2(2000 BYTE), 
	INVOICE_AMOUNT VARCHAR2(255), 
	INVOICE_DESCRIPTION VARCHAR2(2000 BYTE), 
    ORDER_REFERENCE VARCHAR2(255) not NULL,
    PRIMARY KEY(INVOICE_ID),
    FOREIGN KEY (ORDER_REFERENCE) REFERENCES orders(ORDER_REFERENCE));