<cfcomponent>
<cfset variables.userInfo=createObject("component","db.userLoginComponent.isUserOnline")>
<cfset variables.productDetail=createObject("component","db.productComponent.productInfo")>

<cffunction name="decrementProduct" returnType="void" access="public" output="false">
<cfset var arrayOfIDList=arrayNew(2)>
<cfset var i=1>

<cfset LOCAL.retriveInfo=variables.productDetail.getDetailProductID("ordered")>
<cfloop query="LOCAL.retriveInfo">
<cfset arrayOfIDList[i][1]=#LOCAL.retriveInfo.detailProductID#>
<cfset arrayAppend(arrayOfIDList[i],#LOCAL.retriveInfo.quantity#)>
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
