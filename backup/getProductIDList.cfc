<cfcomponent>
<cffunction name="decrementProduct" returnType="void" access="public" output="false">
<cfset var arrayOfIDList=arrayNew(2)>
<cfset var i=1>
<cfquery name="retriveInfo">
select detailProductID , quantity  from OrderDetails
where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
AND
status=<cfqueryparam value="ordered" cfsqlType="cf_sql_varchar">
  AND
  orderID=<cfqueryparam value=#session.identityID# cfsqltype="cf_sql_int" >
</cfquery>

<cfloop query="retriveInfo">
<cfset arrayOfIDList[i][1]=#retriveInfo.detailProductID#>
<cfset arrayAppend(arrayOfIDList[i],#retriveInfo.quantity#)>
<cfset i=#i#+1>
</cfloop>



<cfset arrayOfItems=ArrayNew(2)>
<cfset arrayOfItems=#arrayOfIDList#>



<cfloop from=1 to=#ArrayLen(arrayOfItems)# index="i">
<cfset name1="updatequantityquery"&i>
<cfquery name=#name1#>
update Products
set unitInStock=unitInStock-#arrayOfItems[i][2]#
where productID=#arrayOfItems[i][1]#
</cfquery>
</cfloop>

</cffunction>

</cfcomponent>
