<cfcomponent>

<!---
Function     :searchUserAddressQuery
returnType   :query
hint         :get the addressID using userID
--->
<cffunction name="searchUserAddressQuery" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="searchquery">
    SELECT addressID FROM Address
    WHERE
    userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
  </cfquery>
  <cfcatch type="Database">
    <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in searchUserAddressQuery function" application="true" >
      <cfset emptyQuery=queryNew("addressID")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn searchquery/>
</cffunction>


<!---
Function     :getAddressQuery
returnType   :query
hint         :get address field using userID and addressTye
--->
<cffunction name="getAddressQuery" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="addressquery">
    SELECT Address.addressID,Address.customerAddress1,Address.customerAddress2,Address.customerCity,Address.customerState,Address.customerCountry,Address.addressType FROM Address
    WHERE
    userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqlType="cf_sql_int">
    AND
    addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
  </cfquery>
  <cfcatch type="Database">
    <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in getAddressQuery function" application="true" >
      <cfset emptyQuery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn addressquery/>
</cffunction>


<!---
Function     :customerAddressDetail
returnType   :query
hint         :get all the details for customers purchaseOrder
--->
<cffunction name="customerAddressDetail" returntype="query" output="false" access="public">
  <cftry>
    <cfquery name="detailquery">
    SELECT Address.customerAddress1,Address.customerAddress2,Address.customerCity,Address.customerState,Address.customerCountry,Orders.orderID,Orders.orderAmount,format(Orders.orderDate,'dd/MM/yyyy') as orderDate,Brands.brandName ,Products.productName,Products.afterDiscount , ProductPhoto.thumbNailPhoto , OrderDetails.status , OrderDetails.quantity FROM Products
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
    WHERE (Orders.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int"> AND  Address.addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar"> AND Orders.addressID=Address.addressID) OR (Orders.addressID=Address.addressID AND Orders.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">)
    order by Orders.orderID DESC
    </cfquery>
    <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in customerAddressDetail function" application="true" >
        <cfset emptyQuery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry,orderID,orderAmount,orderDate,brandName,productName,afterDiscount ,thumbNailPhoto ,status ,quantity")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn detailquery/>
</cffunction>
</cfcomponent>
