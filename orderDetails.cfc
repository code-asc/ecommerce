<cfcomponent>

<cffunction name="showDetails" output="false" access="public" returnType="query">


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


<cfreturn detailquery>
</cffunction>

</cfcomponent>
