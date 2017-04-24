<cfcomponent>

<!---
Function     :searchUserAddressQuery
returnType   :query
hint         :get the addressID using userID
--->
<cffunction name="searchUserAddressQuery" output="false" returntype="query" access="public">
    <cftry>
      <cfset LOCAL.searchquery=queryNew("addressID")>
        <cfquery name="LOCAL.searchquery">
            SELECT addressID FROM Address
            WHERE
            userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        </cfquery>
      <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in searchUserAddressQuery function . The SQL state : #cfcatch.queryError#" application="true" >
          <!---<cfset emptyQuery=queryNew("addressID")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.searchquery/>
      </cfcatch>
    </cftry>
<cfreturn LOCAL.searchquery/>
</cffunction>


<!---
Function     :getAddressQuery
returnType   :query
hint         :get address field using userID and addressTye
--->
<cffunction name="getAddressQuery" output="false" returntype="query" access="public">
        <cftry>
          <cfset LOCAL.addressquery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry")>
          <cfquery name="LOCAL.addressquery">
            SELECT Address.addressID,Address.customerAddress1,Address.customerAddress2,Address.customerCity,Address.customerState,Address.customerCountry,Address.addressType FROM Address
            WHERE
            userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqlType="cf_sql_int">
            AND
            addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
          </cfquery>
          <cfcatch type="Database">
              <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in getAddressQuery function .The SQL state : #cfcatch.queryError#" application="true" >
            <!---  <cfset emptyQuery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry")>
              <cfreturn emptyQuery>--->
            <cfreturn LOCAL.addressquery/>
          </cfcatch>
        </cftry>
<cfreturn LOCAL.addressquery/>
</cffunction>


<!---
Function     :customerAddressDetail
returnType   :query
hint         :get all the details for customers purchaseOrder
--->
<cffunction name="customerAddressDetail" returntype="query" output="false" access="public">
  <cftry>
    <cfset LOCAL.detailquery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry,orderID,orderAmount,orderDate,brandName,productName,afterDiscount ,thumbNailPhoto ,status ,quantity")>
    <cfquery name="LOCAL.detailquery">
    SELECT Address.customerAddress1,Address.customerAddress2,Address.customerCity,Address.customerState,Address.customerCountry,Orders.orderID,Orders.orderAmount,format(Orders.orderDate,'dd/MM/yyyy') as orderDate,OrderDetails.detailPrice,Brands.brandName ,Products.productName,Products.afterDiscount , ProductPhoto.thumbNailPhoto , OrderDetails.status , OrderDetails.quantity FROM Products
    INNER JOIN ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    INNER JOIN OrderDetails
    on
    OrderDetails.detailProductID=Products.productID
    INNER JOIN Orders
    on
    Orders.orderID=OrderDetails.orderID
    INNER JOIN Brands
    on
    Products.brandID=Brands.brandID
    INNER JOIN Address
    on
    Address.userID=Orders.userID
    WHERE
    (
    Orders.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      AND
      Address.addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
        AND
        Orders.addressID=Address.addressID
         AND
         OrderDetails.displayStatus=<cfqueryparam value="available" cfsqltype="cf_sql_type">
           )
           OR
           (
           Orders.addressID=Address.addressID
           AND
           OrderDetails.displayStatus=<cfqueryparam value="available" cfsqltype="cf_sql_type">
             AND
           Orders.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
             )
    order by Orders.orderID DESC
    </cfquery>
    <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in customerAddressDetail function .The SQL state : #cfcatch.queryError#" application="true" >
      <!---  <cfset emptyQuery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry,orderID,orderAmount,orderDate,brandName,productName,afterDiscount ,thumbNailPhoto ,status ,quantity")>
        <cfreturn emptyQuery>--->
        <cfreturn LOCAL.detailquery/>
    </cfcatch>
  </cftry>
  <cfreturn LOCAL.detailquery/>
</cffunction>


<!---
Function     :customerAddressDetailForPagenation
returnType   :query
hint         :get all the details for customers purchaseOrder
--->
<cffunction name="customerAddressDetailForPagenation" returntype="query" output="false" access="public">
<cfargument name="start" required="true" type="numeric">
<cfargument name="limitTo" required="true" type="numeric">
  <cftry>
    <cfset LOCAL.detailquery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry,orderID,orderAmount,orderDate,brandName,productName,afterDiscount ,thumbNailPhoto ,status ,quantity")>
    <cfquery name="LOCAL.detailquery">
      WITH Result_CTE AS
      (
      SELECT Address.customerAddress1,Address.customerAddress2,Address.customerCity,orderDetails.detailID,Address.customerState,Address.customerCountry,Orders.orderID,Orders.orderAmount,format(Orders.orderDate,'dd/MM/yyyy') as orderDate,OrderDetails.detailPrice,Brands.brandName ,Products.productName,Products.afterDiscount , ProductPhoto.thumbNailPhoto , OrderDetails.status , OrderDetails.quantity,ROW_NUMBER()
      OVER
        (order by Orders.orderID DESC)
        AS
        RowNum FROM Products
      INNER JOIN ProductPhoto
      on
      Products.photoID=ProductPhoto.photoID
      INNER JOIN OrderDetails
      on
      OrderDetails.detailProductID=Products.productID
      INNER JOIN Orders
      on
      Orders.orderID=OrderDetails.orderID
      INNER JOIN Brands
      on
      Products.brandID=Brands.brandID
      INNER JOIN Address
      on
      Address.userID=Orders.userID
      WHERE (Orders.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
     Address.addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
        AND
    Orders.addressID=Address.addressID
        AND
    OrderDetails.displayStatus=<cfqueryparam value="available" cfsqltype="cf_sql_type">
     )
       OR
    (
   Orders.addressID=Address.addressID
       AND
  Orders.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
       AND
  OrderDetails.displayStatus=<cfqueryparam value="available" cfsqltype="cf_sql_type">
          )

      )
      SELECT * FROM Result_CTE
      WHERE
      RowNum > <cfqueryparam value=#ARGUMENTS.start# cfsqltype="cf_sql_int"/>
      AND
      RowNum<= <cfqueryparam value=#ARGUMENTS.limitTo# cfsqltype="cf_sql_int"/>

    </cfquery>
    <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in customerAddressDetail function .The SQL state : #cfcatch.queryError#" application="true" >
      <!---  <cfset emptyQuery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry,orderID,orderAmount,orderDate,brandName,productName,afterDiscount ,thumbNailPhoto ,status ,quantity")>
        <cfreturn emptyQuery>--->
        <cfreturn LOCAL.detailquery/>
    </cfcatch>
  </cftry>
  <cfreturn LOCAL.detailquery/>
</cffunction>

<cffunction name="customerAddressDetailForPage" returntype="query" access="public" output="false">
<cfargument name="start" required="true" type="numeric">
<cfargument name="limitTo" required="true" type="numeric">
  <cftry>
    <cfset LOCAL.detailquery=queryNew("customerAddress1 , customerAddress2, customerCity, detailID, customerState, customerCountry, orderID, orderAmount , orderDate, detailPrice, brandName , productName, afterDiscount , thumbNailPhoto , status , quantity")>
      <cfset arrayOfID=arrayNew(1)>
    <cfquery name="listquery">
      WITH Result_CTE AS
      (
      SELECT Orders.orderID , ROW_NUMBER()
      OVER
        (order by Orders.orderID DESC)
        AS
        RowNum FROM Products
        INNER JOIN OrderDetails
        on
        OrderDetails.detailProductID=Products.productID
        INNER JOIN Orders
        on
        Orders.orderID=OrderDetails.orderID
        WHERE Orders.userID = <cfqueryparam value="#SESSION.stLoggedInUser.userID#" cfsqltype="cf_sql_int"/>
        AND
        OrderDetails.displayStatus=<cfqueryparam value="available" cfsqltype="cf_sql_varchar">
        )
      SELECT * FROM Result_CTE
      WHERE
      RowNum > <cfqueryparam value=#ARGUMENTS.start# cfsqltype="cf_sql_int"/>
      AND
      RowNum<= <cfqueryparam value=#ARGUMENTS.limitTo# cfsqltype="cf_sql_int"/>

    </cfquery>
    <cfloop query="listquery">
      <cfset ArrayAppend(arrayOfID,listquery.orderID)>
    </cfloop>

    <cfquery name="LOCAL.detailquery">
    SELECT Address.customerAddress1,Address.customerAddress2,Address.customerCity,orderDetails.detailID,Address.customerState,Address.customerCountry,Orders.orderID,Orders.orderAmount,format(Orders.orderDate,'dd/MM/yyyy') as orderDate,OrderDetails.detailPrice,Brands.brandName ,Products.productName,Products.afterDiscount , ProductPhoto.thumbNailPhoto , OrderDetails.status , OrderDetails.quantity FROM Products
    INNER JOIN ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    INNER JOIN OrderDetails
    on
    OrderDetails.detailProductID=Products.productID
    INNER JOIN Orders
    on
    Orders.orderID=OrderDetails.orderID
    INNER JOIN Brands
    on
    Products.brandID=Brands.brandID
    INNER JOIN Address
    on
    Address.userID=Orders.userID
    WHERE
    (Orders.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
       AND
       Address.addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
      AND
      Orders.addressID=Address.addressID
      AND
      Orders.orderID IN (<cfqueryparam value=#arrayToList(arrayOfID)# cfsqltype="cf_sql_int" list="true">)
        AND
        Orders.orderID IN (<cfqueryparam value=#arrayToList(arrayOfID)# cfsqltype="cf_sql_int" list="true" >)
      )
      OR
      (Orders.addressID=Address.addressID
      AND
      Orders.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">)
        AND
        Orders.orderID IN (<cfqueryparam value=#arrayToList(arrayOfID)# cfsqltype="cf_sql_int" list="true" >)
    order by Orders.orderID DESC

    </cfquery>
    <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in customerAddressDetailForPage function .The SQL state : #cfcatch.queryError#" application="true" >
      <!---  <cfset emptyQuery=queryNew("customerAddress1 , customerAddress2, customerCity, detailID, customerState, customerCountry, orderID, orderAmount , orderDate, detailPrice, brandName , productName, afterDiscount , thumbNailPhoto , status , quantity")>
        <cfreturn emptyQuery>--->
        <cfreturn LOCAL.detailquery/>
    </cfcatch>
  </cftry>
  <cfreturn LOCAL.detailquery/>
</cffunction>

</cfcomponent>
