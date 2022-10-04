CREATE or replace PROCEDURE split_and_insert
IS
   y    VARCHAR2(255);
   CURSOR myCursor IS
SELECT ORDER_REF,
    ORDER_DATE,
	SUPPLIER_NAME,
	SUPP_CONTACT_NAME,
	SUPP_ADDRESS,
	SUPP_CONTACT_NUMBER,
	SUPP_EMAIL,
	ORDER_TOTAL_AMOUNT,
	ORDER_DESCRIPTION,
	ORDER_STATUS,
	ORDER_LINE_AMOUNT,
	INVOICE_REFERENCE,
	INVOICE_DATE,
	INVOICE_STATUS,
	INVOICE_HOLD_REASON,
	INVOICE_AMOUNT,
	INVOICE_DESCRIPTION FROM xxbcm_order_mgt;

    orderRef VARCHAR2(255);
    orderDate VARCHAR2(255);
    supplierName VARCHAR2(2000);
    supplierContactName VARCHAR2(255);
    supplierAddress VARCHAR2(255);
    supplierContactNumber VARCHAR2(255);
    supplierEmail VARCHAR2(255);
    orderTotalAmount VARCHAR2(255);
    orderDescription VARCHAR2(2000);
    orderStatus VARCHAR2(10);
    orderLineAmount VARCHAR2(255);
    invoiceRef VARCHAR2(255);
    invoiceDate VARCHAR2(255);
    invoiceStatus VARCHAR2(7);
    invoiceHoldReason VARCHAR2(2000);
    invoiceAmountNumber VARCHAR2(255);
    invoiceDescription VARCHAR2(2000);
    BEGIN
    OPEN myCursor;
    LOOP
    FETCH myCursor INTO orderRef ,orderDate ,supplierName ,supplierContactName ,supplierAddress,supplierContactNumber , supplierEmail , orderTotalAmount , orderDescription, orderStatus,
    orderLineAmount,invoiceRef , invoiceDate ,invoiceStatus , invoiceHoldReason ,invoiceAmountNumber, invoiceDescription ;
    
     exit when myCursor%notfound;
     
     BEGIN
            SELECT ORDER_REFERENCE INTO y FROM orders  WHERE ORDER_REFERENCE=orderRef;
            EXCEPTION WHEN NO_DATA_FOUND THEN
            INSERT INTO orders(ORDER_REFERENCE, ORDER_DATE, SUPPLIER_NAME, SUPPLIER_CONTACT_NAME, SUPPLIER_ADDRESS, SUPP_CONTACT_NUMBER, SUPPLIER_EMAIL)
       VALUES( orderRef , to_date(to_char( to_date(orderDate,'DD-MM-YY','NLS_DATE_LANGUAGE=ENGLISH')),'DD-MM-YYYY','NLS_DATE_LANGUAGE=ENGLISH'), supplierName,supplierContactName,supplierAddress,supplierContactNumber,supplierEmail );
       
        END;
        
       INSERT INTO ORDER_DETAILS( ORDER_TOTAL_AMOUNT, ORDER_DESCRIPTION, ORDER_STATUS, ORDER_LINE_AMOUNT, ORDER_REFERENCE)
       VALUES( orderTotalAmount , orderDescription, orderStatus,orderLineAmount,orderRef );
       
       INSERT INTO invoices( INVOICE_REFERENCE, INVOICE_DATE, INVOICE_STATUS, INVOICE_HOLD_REASON,
            INVOICE_AMOUNT, INVOICE_DESCRIPTION, ORDER_REFERENCE)
     VALUES(invoiceRef, to_date(to_char( to_date(invoiceDate,'DD-MM-YY','NLS_DATE_LANGUAGE=ENGLISH')),'DD-MM-YYYY','NLS_DATE_LANGUAGE=ENGLISH'),invoiceStatus,invoiceHoldReason,invoiceAmountNumber,invoiceDescription,orderRef);
        
  END LOOP;

  CLOSE myCursor;
END;
