<cfcomponent>
<cfset variables.userInfo=createObject("component","db.userLoginComponent.isUserOnline")>
<cfset variables.productInfo=createObject("component","db.productComponent.productInfo")>
<cfset variables.addressInfo=createObject("component","db.addressComponent.searchAndGetAddress")>

<cffunction name="addNewUser" output="false" access="public" returnType="array">

<cfset var errorArray=arrayNew(1)>
  <cfif IsValid("email", form.email)>
<cfset var registerEmail=#form.email#>
<cfquery name="myquery">
select userEmail from Customer where userEmail=<cfqueryparam value=#registerEmail#  cfsqltype="cf_sql_varchar">
</cfquery>


<cfif myquery.recordCount EQ 0>

<cfstoredproc procedure="hash_userDetails">
  <cfprocparam value="#form.firstName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.middleName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.lastName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.email#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.password#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.mobile#" cfsqltype="cf_sql_varchar"/>

</cfstoredproc>

<cfreturn errorArray>
<cfelse>
  <cfset arrayAppend(errorArray, "This email is already registered")>
<cfreturn errorArray>
</cfif>


<cfelse>
  <cfset arrayAppend(errorArray,"Invalid Email Id")>
  <cfreturn errorArray>
</cfif>

</cffunction>


<cffunction name="validateUser" returnType="array" access="public" output="false">
<cfargument name="userEmail" required="true" type="string">
<cfargument name="userPassword" required="true" type="string">
  <cfset var aErrorMessage=arrayNew(1)>
    <cfif NOT isValid("email",arguments.userEmail)>
      <cfset arrayAppend(aErrorMessage,"invalid userEmail")>
    </cfif>

    <cfif arguments.userPassword EQ "">
      <cfset arrayAppend(aErrorMessage,"invalid password")>
    </cfif>
    <cfreturn aErrorMessage>
</cffunction>


<cffunction name="doLogin" access="public" output="false" returntype="boolean">
<cfargument name="userEmail" required="true" type="string">
  <cfargument name="userPassword" required="true" type="string">

<cfset var loginUser=variables.userInfo.doUserLogin(arguments.userEmail,arguments.userPassword)>
<cfset var checkStatus=variables.userInfo.checkUserOnline(loginUser.userID)>


     <cfif loginUser.recordCount EQ 1>

       <!--- logout other browser user --->
       <cfif NOT checkStatus.recordCount EQ 0>
         <cfinvoke component="removeSession" method="removeUserSession" userEmail=#checkStatus.email#>
       </cfif>
       <!--- --->
       <cflogin>
         <cfloginuser name="#loginUser.userFirstName# #loginUser.userMiddleName# #loginUser.userLastName#" password="#loginUser.userPassword#" roles="customer" />
       </cflogin>
       <cfset session.stLoggedInUser={"userFirstName"=#loginUser.userFirstName# , "userMiddleName"=#loginUser.userMiddleName# , "userLastName"=#loginUser.userLastName# , "userID"=#loginUser.userID# ,"userEmail"=#loginUser.userEmail# , "userProfilePhoto"=#loginUser.userProfilePhoto#}>

<!---Update status --->
<cfset variables.userInfo.changeUserStatus()>

<!---to show number of items in  cart --->
<!---<cfquery name="querycount">
select detailID from OrderDetails where userID=<cfqueryparam value=#loginUser.userID# cfsqltype="cf_sql_int"> AND status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar" />
</cfquery>--->

<cfset updateCartCount()>
  <!--- --->
         <cfset var isUserLoggedIn=true>

           <cfelse>
             <cfset var isUserLoggedIn=false>
</cfif>
<cfreturn isUserLoggedIn>
</cffunction>

<cffunction name="doLogout" returntype="void" output="false" access="public">

<cfif StructKeyExists(session, "stLoggedInUser")>
<cfinvoke method="doLogoutOf" component="db.userLogoutComponent.doUserLogout">

<cfset structDelete(session, "stLoggedInUser")>
  <cfset structDelete(session,"currentURL")>
    <cfset structDelete(session,"subCategoryID")>
      <cfset structDelete(session,"cartCount")>
    <cfset structClear(session)>
<cfset structDelete(cookie,"CFID")>
  <cfset structDelete(cookie, "CFTOKEN")>
    <!---<cfloop collection="#cookie#" item="name">
      <cfcookie name="#name#" value="" expires="now" />
    </cfloop>--->
  <cfcookie name="CFID" value="#cookie.CFID#" expires="now"   />
  <cfcookie name="CFTOKEN" value="#cookie.CFTOKEN#" expires="now"  />
  <cflogout />
  <cflocation url="index.cfm" addtoken="false" />
  <cfelse>
      <cflocation url="index.cfm" addtoken="false" />
</cfif>
</cffunction>

<cffunction name="addToCart" returntype="void" output="false" access="remote">

<cfset LOCAL.checkquery=variables.productInfo.getOrderDetailID("addedToCart")>

  <cfif LOCAL.checkquery.recordCount EQ 0>
      <cfset LOCAL.getproduct=variables.productInfo.getProductInfoByID()>

<cfloop query="#LOCAL.getproduct#">
  <cfset LOCAL.afterDiscount=#LOCAL.getproduct.afterDiscount#>
    <cfset LOCAL.supplierID=#LOCAL.getproduct.supplierID#>
</cfloop>

<cfset LOCAL.status="addedToCart">

      <cfset variables.productInfo.setOrderDetails(afterDiscount=#LOCAL.afterDiscount#,supplierID=#LOCAL.supplierID#,status=#LOCAL.status#)>
      <cfelse>
        <cfset variables.productInfo.updateOrderDetails()>
    </cfif>
<cfset updateCartCount()>
</cffunction>

<cffunction name="removeItemFromCart" access="public" output="false" returntype="any">
  <cfargument name="cartID" type="numeric" required="true">
    <cfset variables.productInfo.deleteOrder(arguments.cartID)>
<!---<cfquery name="countquery">
  select detailID from OrderDetails
  where
  userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
    AND
    status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar" >
</cfquery>--->

    <cfset updateCartCount()>
</cffunction>


<cffunction name="homePageContent" returnType="array" access="remote" output="false" returnformat="JSON" >

<cfset LOCAL.homequery=variables.productInfo.homePageLargePhoto()>
<cfset var arrayToStoreQuery=arrayNew(1)>

<cfloop query="LOCAL.homequery">
  <cfset stData=structNew()>
          <cfset stData.largePhoto=#LOCAL.homequery.largePhoto#>
        <cfset arrayAppend(arrayToStoreQuery,stData)>
</cfloop>
<cfreturn arrayToStoreQuery>
</cffunction>

<cffunction name="filterProduct" returntype="array" output="false" access="remote" returnformat="JSON" >
<cfargument name="brand" required="true" type="string">
<cfargument name="discount" required="true" type="string">

<cfset LOCAL.filterquery=variables.productInfo.getProductInfoBySubCategory(arguments.brand,arguments.discount)>
    <cfset var arrayToStoreQuery=arrayNew(1)>

    <cfloop query="LOCAL.filterquery">
      <cfset stData=structNew()>
              <cfset stData.thumbNailPhoto=#LOCAL.filterquery.thumbNailPhoto#>
              <cfset stData.productID=#LOCAL.filterquery.productID#>
              <cfset stData.productName=#LOCAL.filterquery.productName#>
              <cfset stData.productDesc=#LOCAL.filterquery.productDesc#>
                <cfset stData.discount=#LOCAL.filterquery.discount#>
              <cfset stData.unitPrice=#LOCAL.filterquery.unitPrice#>
            <cfset stData.thumbNailPhoto=#LOCAL.filterquery.thumbNailPhoto#>
            <cfset stData.brandName=#LOCAL.filterquery.brandName#>
            <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
    <cfreturn arrayToStoreQuery>

</cffunction>

<cffunction name="homePageThumbNailInfo" output="false" returntype="array" access="remote" returnformat="JSON" >

  <cfset LOCAL.thumbnailquery=variables.productInfo.getThumbnail()>
  <cfset var arrayToStoreQuery=arrayNew(1)>
  <cfloop query="LOCAL.thumbnailquery">
    <cfset stData=structNew()>
      <cfset stData.brandID=#LOCAL.thumbnailquery.brandID#>
        <cfset stData.subCategoryID=#LOCAL.thumbnailquery.subCategoryID#>
    <cfset stData.thumbNail=#LOCAL.thumbnailquery.thumbNailPhoto#>
      <cfset arrayAppend(arrayToStoreQuery, stData)>
  </cfloop>
  <cfreturn arrayToStoreQuery>
</cffunction>



<cffunction name="incrementQuantity" returntype="array" output="false" access="remote" returnformat="JSON" >
  <cfargument name="id" type="string" required="true">
<cfset LOCAL.idValue=#deserializeJSON(arguments.id)#>

    <cfset variables.productInfo.incrementQuantityInDatabase(LOCAL.idValue)>

<cfset LOCAL.getqueryof=variables.productInfo.getOrderDetailByOnlyID(LOCAL.idValue)>
<cfset var arrayToStoreQuery=arrayNew(1)>
<cfset var arrayCall=totalPriceAndQty()>

    <cfloop query="LOCAL.getqueryof">
      <cfset stData=structNew()>
      <cfset stData.quantity=#LOCAL.getqueryof.quantity#>
        <cfset stData.totalPrice=(#LOCAL.getqueryof.detailPrice# * #LOCAL.getqueryof.quantity#)>
          <cfset stData.totalCart=arrayCall[1]>
            <cfset stData.sum=arrayCall[2]>
            <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
<cfset updateCartCount()>
  <cfreturn arrayToStoreQuery>
</cffunction>

<cffunction name="totalPriceAndQty" returntype="array" output="false" access="public">

  <cfset LOCAL.getquery=variables.productInfo.getOrderPriceAndQty()>
  <cfset arrayToStoreQuery=arrayNew(1)>
  <cfloop query="getquery">
        <cfset arrayAppend(arrayToStoreQuery,#LOCAL.getquery.totalCount#)>
            <cfset arrayAppend(arrayToStoreQuery,#LOCAL.getquery.sum#)>
  </cfloop>
  <cfreturn arrayToStoreQuery>
</cffunction>

<cffunction name="decrementQuantity" returntype="array" output="false" access="remote" returnformat="JSON">
  <cfargument name="id" type="string" required="true">

    <cfset LOCAL.idValue=#deserializeJSON(arguments.id)#>
    <cfset variables.productInfo.decrementQuantityInDatabase(LOCAL.idValue)>

    <cfset LOCAL.getqueryof=variables.productInfo.getOrderDetailByOnlyID(LOCAL.idValue)>
    <cfset var arrayToStoreQuery=arrayNew(1)>
      <cfset var arrayCall=totalPriceAndQty()>
        <cfloop query="LOCAL.getqueryof">
          <cfset stData=structNew()>
            <cfset stData.totalPrice=(#LOCAL.getqueryof.detailPrice# * #LOCAL.getqueryof.quantity#)>
                  <cfset stData.quantity=#LOCAL.getqueryof.quantity#>
                <cfset arrayAppend(arrayToStoreQuery,stData)>
                  <cfset stData.totalCart=arrayCall[1]>
                    <cfset stData.sum=arrayCall[2]>
        </cfloop>
    <cfset updateCartCount()>
      <cfreturn arrayToStoreQuery>
    </cffunction>

<!--- Modifying prevoius function--->
<cffunction name="purchaseOrder" output="false" returnType="void" access="public">
<cfargument name="addressID" type="numeric" required="true">
  <cfset variables.productInfo.updateOrderDetailsBasedOnStatus()>

<!--- --->
<cftransaction >

  <cfif arguments.addressID GT 0>
  <cfset LOCAL.identityReturnID=variables.productInfo.setOrder(arguments.addressID)>
  <cfelse>
<cfset LOCAL.addressquery=variables.addressInfo.getAddressQuery()>
<cfset LOCAL.identityReturnID=variables.productInfo.setOrder(LOCAL.addressquery.addressID)>
  </cfif>
  <cfset session.identityID=#LOCAL.identityReturnID#>
    </cftransaction>

<cfset updateCartCount()>
</cffunction>

<cffunction name="updateCartCount" output="false" access="public" returntype="void">
  <cfparam name="initValue" default=0>

<cfset LOCAL.countquery=variables.productInfo.countOrderDetails()>
<cfloop query="LOCAL.countquery">
  <cfset initValue=#initValue#+#LOCAL.countquery.quantity#>
</cfloop>
<cfset session.cartCount=initValue>
</cffunction>


<cffunction name="getAllBrand" output="false" access="remote" returntype="array" returnformat="JSON">
  <cfset LOCAL.brandquery=variables.productInfo.getBrand()>
  <cfset var arrayToStoreQuery=arrayNew(1)>

  <cfloop query="LOCAL.brandquery">
    <cfset stData=structNew()>
            <cfset stData.brand="#LOCAL.brandquery.brandName#">
          <cfset arrayAppend(arrayToStoreQuery,stData)>
  </cfloop>
  <cfreturn arrayToStoreQuery>

</cffunction>


</cfcomponent>
