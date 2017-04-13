<cfcomponent>
<cfset variables.userInfo=createObject("component","db.userLoginComponent.isUserOnline")>
<cfset variables.productDetail=createObject("component","db.productComponent.productInfo")>

  <!---
  function     :decrementProduct
  returnType   :void
  hint         :It is used to decrement product in databases on user action
  --->
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
              UPDATE Products
              SET unitInStock=unitInStock-#arrayOfItems[i][2]#
              WHERE productID=#arrayOfItems[i][1]#
              </cfquery>
              </cfloop>
</cffunction>


<!---
function     :getOnlyCategory
returnType   :query
hint         :It is used to retrive only category
--->
<cffunction name="getOnlyCategory" output="false" returntype="query" access="public">
  <cfset LOCAL.categoryOption=variables.productDetail.retriveOnlyCategory()>
  <cfreturn LOCAL.categoryOption/>
</cffunction>


<!---
function     :getOnlyBrand
returnType   :query
hint         :It is used to return brands
--->
<cffunction name="getOnlyBrand" output="false" returntype="query" access="public">
  <cfset LOCAL.brandOption=variables.productDetail.retriveOnlyBrand()>
  <cfreturn LOCAL.brandOption/>
</cffunction>


<!---
function     :getOnlyShipping
returnType   :query
hint         :It is used to return only shipping details
--->
<cffunction name="getOnlyShipping" output="false" returntype="query" access="public">
  <cfset LOCAL.shippingOption=variables.productDetail.retriveOnlyShipping()>
  <cfreturn LOCAL.shippingOption/>
</cffunction>

<!---
function     :getOnlyCategory
returnType   :query
hint         :It is used to return only supplier details
--->
<cffunction name="getOnlySupplier" output="false" returntype="query" access="public">
  <cfset LOCAL.supplierOption=variables.productDetail.retriveOnlySupplier()>
  <cfreturn LOCAL.supplierOption/>
</cffunction>

</cfcomponent>
