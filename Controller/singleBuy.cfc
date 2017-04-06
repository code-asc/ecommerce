<cfcomponent>
<cffunction name="buyNow" output="false" access="remote" returnType="void">
  <cfargument name="addressID" required="false" type="numeric" default=0 >
<cfquery name="retriveproductquery">
select productID,supplierID,afterDiscount from Products
where
productID=<cfqueryparam value=#session.productID# cfsqlType="cf_sql_int">
</cfquery>

<cfquery name="insertdetailquery">
insert into OrderDetails(detailProductID,detailPrice,supplierID,status,userID,quantity)
values(<cfqueryparam value=#retriveproductquery.productID# cfsqlType="cf_sql_int">,
<cfqueryparam value=#retriveproductquery.afterDiscount# cfsqlType="cf_sql_decimal">,
<cfqueryparam value=#retriveproductquery.supplierID# cfsqlType="cf_sql_int">,
<cfqueryparam value="progress" cfsqlType="cf_sql_varchar">,
<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">,
<cfqueryparam value=1 cfsqlType="cf_sql_int">
)
</cfquery>

<cfif arguments.addressID GT 0>
  <cfquery name="insertquery">
    insert into Orders(userID,addressID)
    values(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
      <cfqueryparam value=#arguments.addressID# cfsqltype="cf_sql_int">)
  </cfquery>

<cfelse>
  <cfquery name="selectquery">
    select addressID from Address
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
      AND
      addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
  </cfquery>
  <cfquery name="insertquery">
    insert into Orders(userID,addressID)
    values(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
      <cfqueryparam value=#selectquery.addressID# cfsqltype="cf_sql_int">)
  </cfquery>

</cfif>

<cfquery name="updateproductquery">
update Products
set unitInStock=unitInStock-1
where
productID=<cfqueryparam value=#retriveproductquery.productID# cfsqltype="cf_sql_int">
</cfquery>
</cffunction>
</cfcomponent>
