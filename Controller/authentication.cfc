<cfcomponent>

<cfset VARIABLES.userInfo=createObject("component","db.userLoginComponent.isUserOnline")>
<cfset VARIABLES.productInfo=createObject("component","db.productComponent.productInfo")>
<cfset VARIABLES.addressInfo=createObject("component","db.addressComponent.searchAndGetAddress")>


  <!---
  function     :addNewUser
  returnType   :array
  hint         :It is used to add new user
  --->
<cffunction name="addNewUser" output="false" access="public" returnType="array">

<cfset  LOCAL.errorArray=arrayNew(1)>
  <cfif IsValid("email", form.email)>
<cfset myquery=VARIABLES.userInfo.checkUserAlreadyRegistered(email=#form.email#)>

<cfif myquery.recordCount EQ 0>

<cfstoredproc procedure="hash_userDetails">
  <cfprocparam value="#FORM.firstName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#FORM.middleName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#FORM.lastName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#FORM.email#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#FORM.password#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#FORM.mobile#" cfsqltype="cf_sql_varchar"/>
  <cfprocparam  value="customer" cfsqltype="cf_sql_varchar" />
</cfstoredproc>

<cfreturn LOCAL.errorArray>
<cfelse>
  <cfset arrayAppend(LOCAL.errorArray, "This email is already registered")>
<cfreturn LOCAL.errorArray>
</cfif>


<cfelse>
  <cfset arrayAppend(LOCAL.errorArray,"Invalid Email Id")>
  <cfreturn LOCAL.errorArray>
</cfif>

</cffunction>


<!---
function     :validateUser
returnType   :array
hint         :It is used to the user login details
--->
<cffunction name="validateUser" returnType="array" access="public" output="false">
<cfargument name="userEmail" required="true" type="string">
<cfargument name="userPassword" required="true" type="string">
  <cfset var aErrorMessage=arrayNew(1)>
    <cfif NOT isValid("email",ARGUMENTS.userEmail)>
      <cfset arrayAppend(aErrorMessage,"invalid userEmail")>
    </cfif>

    <cfif ARGUMENTS.userPassword EQ "">
      <cfset arrayAppend(aErrorMessage,"invalid password")>
    </cfif>
    <cfreturn aErrorMessage>
</cffunction>



<!---
function     :doLogin
returnType   :boolean
hint         :It is used to perform login
--->
<cffunction name="doLogin" access="public" output="false" returntype="boolean">
<cfargument name="userEmail" required="true" type="string">
  <cfargument name="userPassword" required="true" type="string">

<cfset var loginUser=VARIABLES.userInfo.doUserLogin(ARGUMENTS.userEmail,ARGUMENTS.userPassword)>
<cfset var checkStatus=VARIABLES.userInfo.checkUserOnline(loginUser.userID)>


     <cfif loginUser.recordCount EQ 1>

       <!--- logout other browser user --->
       <cfif NOT checkStatus.recordCount EQ 0>
         <cfinvoke component="removeSession" method="removeUserSession" userEmail=#checkStatus.email#>
       </cfif>
       <!--- --->
       <cflogin>
         <cfloginuser name="#loginUser.userFirstName# #loginUser.userMiddleName# #loginUser.userLastName#" password="#loginUser.userPassword#" roles="#loginUser.roles#" />
       </cflogin>
       <cfset SESSION.stLoggedInUser={"userFirstName"=#loginUser.userFirstName# , "userMiddleName"=#loginUser.userMiddleName# , "userLastName"=#loginUser.userLastName# , "userID"=#loginUser.userID# ,"userEmail"=#loginUser.userEmail# , "userProfilePhoto"=#loginUser.userProfilePhoto# ,"userRole"="#loginUser.roles#"}>

<!---Update status --->
<cfset VARIABLES.userInfo.changeUserStatus()>
<cfset updateCartCount()>
         <cfset var isUserLoggedIn=true>

           <cfelse>
             <cfset var isUserLoggedIn=false>
</cfif>
<cfreturn isUserLoggedIn>
</cffunction>


<!---
function     :doLogout
returnType   :void
hint         :It is used to perform logout
--->
<cffunction name="doLogout" returntype="void" output="false" access="public">
<cfif StructKeyExists(SESSION, "stLoggedInUser")>
<cfinvoke method="doLogoutOf" component="db.userLogoutComponent.doUserLogout">

<cfset structDelete(SESSION, "stLoggedInUser")>
  <cfset structDelete(SESSION,"currentURL")>
    <cfset structDelete(SESSION,"subCategoryID")>
      <cfset structDelete(SESSION,"cartCount")>
    <cfset structClear(SESSION)>
<cfset structDelete(COOKIE,"CFID")>
  <cfset structDelete(COOKIE, "CFTOKEN")>
  <cfcookie name="CFID" value="#COOKIE.CFID#" expires="now"   />
  <cfcookie name="CFTOKEN" value="#COOKIE.CFTOKEN#" expires="now"  />
  <cflogout />
  <cflocation url="index.cfm" addtoken="false" />
  <cfelse>
      <cflocation url="index.cfm" addtoken="false" />
</cfif>
</cffunction>


<!---
function     :addToCart
returnType   :void
hint         :It is used to add an item to cart using AJAX call
--->
<cffunction name="addToCart" returntype="void" output="false" access="remote">
<cfset LOCAL.checkquery=VARIABLES.productInfo.getOrderDetailID("addedToCart")>

  <cfif LOCAL.checkquery.recordCount EQ 0>
      <cfset LOCAL.getproduct=VARIABLES.productInfo.getProductInfoByID()>

<cfloop query="#LOCAL.getproduct#">
  <cfset LOCAL.afterDiscount=#LOCAL.getproduct.afterDiscount#>
    <cfset LOCAL.supplierID=#LOCAL.getproduct.supplierID#>
</cfloop>

<cfset LOCAL.status="addedToCart">

      <cfset VARIABLES.productInfo.setOrderDetails(afterDiscount=#LOCAL.afterDiscount#,supplierID=#LOCAL.supplierID#,status=#LOCAL.status#)>
      <cfelse>
        <cfset VARIABLES.productInfo.updateOrderDetails()>
    </cfif>
<cfset updateCartCount()>
</cffunction>



<!---
function     :removeItemFromCart
returnType   :array
hint         :It is used to remove an item from the cart
--->
<cffunction name="removeItemFromCart" access="public" output="false" returntype="any">
  <cfargument name="cartID" type="numeric" required="true">
    <cfset VARIABLES.productInfo.deleteOrder(ARGUMENTS.cartID)>
    <cfset updateCartCount()>
</cffunction>


<!---
function     :homePageContent
returnType   :array
hint         :It is used to return home page content such as photo
--->
<cffunction name="homePageContent" returnType="array" access="remote" output="false" returnformat="JSON" >
<cfset LOCAL.homequery=VARIABLES.productInfo.homePageLargePhoto()>
<cfset var arrayToStoreQuery=arrayNew(1)>

<cfloop query="LOCAL.homequery">
  <cfset stData=structNew()>
          <cfset stData.largePhoto=#LOCAL.homequery.largePhoto#>
        <cfset arrayAppend(arrayToStoreQuery,stData)>
</cfloop>
<cfreturn arrayToStoreQuery>
</cffunction>


<!---
function     :filterProduct
returnType   :array
hint         :It is used to return the filtered products
--->
<cffunction name="filterProduct" returntype="array" output="false" access="remote" returnformat="JSON" >
<cfargument name="brand" required="true" type="string">
<cfargument name="discount" required="true" type="string">

<cfset LOCAL.filterquery=VARIABLES.productInfo.getProductInfoBySubCategory(ARGUMENTS.brand,ARGUMENTS.discount)>
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


<!---
function     :homePageThumbNailInfo
returnType   :array
hint         :It is used to return home page thumbnail photos
--->
<cffunction name="homePageThumbNailInfo" output="false" returntype="array" access="remote" returnformat="JSON" >

  <cfset LOCAL.thumbnailquery=VARIABLES.productInfo.getThumbnail()>
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


<!---
function     :incrementQuantity
returnType   :array
hint         :It is used to increment quantity in cart
--->
<cffunction name="incrementQuantity" returntype="array" output="false" access="remote" returnformat="JSON" >
  <cfargument name="id" type="string" required="true">
<cfset LOCAL.idValue=#deserializeJSON(ARGUMENTS.id)#>

    <cfset VARIABLES.productInfo.incrementQuantityInDatabase(LOCAL.idValue)>

<cfset LOCAL.getqueryof=VARIABLES.productInfo.getOrderDetailByOnlyID(LOCAL.idValue)>
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


<!---
function     :totalPriceAndQty
returnType   :array
hint         :It is used to return the total price and quantity of all items in cart
--->
<cffunction name="totalPriceAndQty" returntype="array" output="false" access="public">

  <cfset LOCAL.getquery=VARIABLES.productInfo.getOrderPriceAndQty()>
  <cfset arrayToStoreQuery=arrayNew(1)>
  <cfloop query="getquery">
        <cfset arrayAppend(arrayToStoreQuery,#LOCAL.getquery.totalCount#)>
            <cfset arrayAppend(arrayToStoreQuery,#LOCAL.getquery.sum#)>
  </cfloop>
  <cfreturn arrayToStoreQuery>
</cffunction>


<!---
function     :decrementQuantity
returnType   :array
hint         :It is used to decerment products in cart
--->
<cffunction name="decrementQuantity" returntype="array" output="false" access="remote" returnformat="JSON">
  <cfargument name="id" type="string" required="true">

    <cfset LOCAL.idValue=#deserializeJSON(ARGUMENTS.id)#>
    <cfset VARIABLES.productInfo.decrementQuantityInDatabase(LOCAL.idValue)>

    <cfset LOCAL.getqueryof=VARIABLES.productInfo.getOrderDetailByOnlyID(LOCAL.idValue)>
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


    <!---
    function     :purchaseOrder
    returnType   :void
    hint         :It is used to update the purchaseOrder of the customer
    --->
<!--- Modifying prevoius function--->
<cffunction name="purchaseOrder" output="false" returnType="void" access="public">
<cfargument name="addressID" type="numeric" required="true">
  <cfset VARIABLES.productInfo.updateOrderDetailsBasedOnStatus()>

<!--- --->
<cftransaction >

  <cfif ARGUMENTS.addressID GT 0>
  <cfset LOCAL.identityReturnID=VARIABLES.productInfo.setOrder(ARGUMENTS.addressID)>
  <cfelse>
<cfset LOCAL.addressquery=VARIABLES.addressInfo.getAddressQuery()>
<cfset LOCAL.identityReturnID=VARIABLES.productInfo.setOrder(LOCAL.addressquery.addressID)>
  </cfif>
  <cfset SESSION.identityID=#LOCAL.identityReturnID#>
    </cftransaction>

<cfset updateCartCount()>
</cffunction>


<!---
function     :updateCartCount
returnType   :void
hint         :It is used to update the cart count
--->
<cffunction name="updateCartCount" output="false" access="public" returntype="void">
  <cfparam name="initValue" default=0>

<cfset LOCAL.countquery=VARIABLES.productInfo.countOrderDetails()>
<cfloop query="LOCAL.countquery">
  <cfset initValue=#initValue#+#LOCAL.countquery.quantity#>
</cfloop>
<cfset SESSION.cartCount=initValue>
</cffunction>


<!---
function     :getAllBrand
returnType   :array
hint         :It is used to return all the brands on AJAX call
--->
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
