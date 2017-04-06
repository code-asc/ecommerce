<cfcomponent>
<cffunction name="searchUserAddressQuery" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="searchquery">
    select addressID from Address
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in searchUserAddressQuery function" application="true" >
      <cfset emptyQuery=queryNew("addressID")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn searchquery/>
</cffunction>

<cffunction name="getAddressQuery" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="addressquery">
    select Address.addressID,Address.customerAddress1,Address.customerAddress2,Address.customerCity,Address.customerState,Address.customerCountry from Address
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
    AND
    addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in getAddressQuery function" application="true" >
      <cfset emptyQuery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn addressquery/>
</cffunction>

<cffunction name="customerAddressDetail" returntype="query" output="false" access="public">
  <cftry>
    <cfquery name="detailquery">
    select Address.customerAddress1,Address.customerAddress2,Address.customerCity,Address.customerState,Address.customerCountry,Orders.orderID,Orders.orderAmount,format(Orders.orderDate,'dd/MM/yyyy') as orderDate,Brands.brandName ,Products.productName,Products.afterDiscount , ProductPhoto.thumbNailPhoto , OrderDetails.status , OrderDetails.quantity from Products
    inner join ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    inner join OrderDetails
    on
    OrderDetails.detailProductID=Products.productID
    inner join Orders
    on
    Orders.orderID=OrderDetails.orderID
    inner join Brands
    on
    Products.brandID=Brands.brandID
    inner join Address
    on
    Address.userID=Orders.userID
    where (Orders.userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int"> AND  Address.addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar"> AND Orders.addressID=Address.addressID) OR (Orders.addressID=Address.addressID AND Orders.userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">)
    order by Orders.orderID DESC
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in searchAndGetAddress.cfc in customerAddressDetail function" application="true" >
        <cfset emptyQuery=queryNew("customerAddress1,customerAddress2,customerCity,customerState,customerCountry,orderID,orderAmount,orderDate,brandName,productName,afterDiscount ,thumbNailPhoto ,status ,quantity")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn detailquery/>
</cffunction>
</cfcomponent>
