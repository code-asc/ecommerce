<cfcomponent>
<cfset VARIABLES.addBrandAndCategory=createObject("component","db.productComponent.addBrandAndCategory")>
<cfset VARIABLES.productInfo=createObject("component","db.productComponent.productInfo")>
<cfset VARIABLES.socketAndUserStatus=createObject("component","db.userComponent.socketNotification")>

  <!---
  function     :addToDatabase
  returnType   :void
  hint         :It is used to add products and its related photos to the database
  --->
<cffunction name="addToDatabase" access="remote" output="false" returnType="string" returnformat="JSON" >
<cfargument name="productName" type="string" required="true">
<cfargument name="productDesc" type="string" required="true">
<cfargument name="supplierID" type="numeric" required="true">
<cfargument name="subcategoryID" type="numeric" required="true">
<cfargument name="unitPrice" type="numeric" required="true">
<cfargument name="thumbNail" type="string" required="true">
<cfargument name="thumbNailType" type="string" required="true">
<cfargument name="largePhotoType" type="string" required="true">
<cfargument name="largePhoto" type="string" required="true">
<cfargument name="quantity" type="numeric" required="true">
<cfargument name="discount" type="numeric" required="true">
<cfargument name="rating" type="numeric" required="true">
<cfargument name="brandID" type="numeric" required="true">
<cfinvoke method="addProductInfoToDatabase" component="db.productComponent.productAdd" productName="#ARGUMENTS.productName#" productDesc="#ARGUMENTS.productDesc#" supplierID=#ARGUMENTS.supplierID# subcategoryID=#ARGUMENTS.subcategoryID# unitPrice=#ARGUMENTS.unitPrice# thumbNail="#ARGUMENTS.thumbNail#" thumbNailType="#ARGUMENTS.thumbNailType#" largePhotoType="#ARGUMENTS.largePhotoType#" largePhoto="#ARGUMENTS.largePhoto#" quantity=#ARGUMENTS.quantity# discount=#ARGUMENTS.discount# rating=#ARGUMENTS.rating# brandID=#ARGUMENTS.brandID# returnvariable="returnVal" />
<cfreturn returnVal/>
</cffunction>


<!---
function     :deleteFromDatabase
returnType   :void
hint         :It is used to delete the product and its photo from the database
--->
<cffunction name="deleteFromDatabase" access="public" output="false" returnType="void">
<cfargument name="photoID" required="true" type="numeric">
<cfinvoke method="deleteProduct" component="db.productComponent.productDelete" photoID=#ARGUMENTS.photoID#>
</cffunction>


<!---
function     :getProductInfo
returnType   :array
hint         :It is used to return the array of structure of the product information
--->
<cffunction name="getProductInfo" output="false" access="remote" returnType="array" returnformat="JSON">
<cfargument name="productID" type="numeric" required="true">

<cfset LOCAL.productquery=VARIABLES.productInfo.getProductInfo(ARGUMENTS.productID)>
<cfset var arrayToStoreQuery=arrayNew(1)>

<cfloop query="productquery">
  <cfset stData=structNew()>
          <cfset stData.thumbNailPhoto="#LOCAL.productquery.thumbNailPhoto#">
          <cfset stData.productDesc="#LOCAL.productquery.productDesc#">
          <cfset stData.unitPrice="#LOCAL.productquery.unitPrice#">
          <cfset stData.unitInStock="#LOCAL.productquery.unitInStock#">
          <cfset stData.discount="#LOCAL.productquery.discount#">
          <cfset stData.largePhoto="#LOCAL.productquery.largePhoto#">
          <cfset arrayAppend(arrayToStoreQuery,stData)>
</cfloop>
<cfreturn arrayToStoreQuery>
</cffunction>


<!---
function     :editProduct
returnType   :void
hint         :It is used to edit the product details
--->
<cffunction name="editProduct" output="false" access="public" returnType="void">
<cfargument name="productID" type="numeric" required="true">
<cfargument name="productDesc" type="string" required="true">
<cfargument name="unitPrice" type="numeric" required="true">
<cfargument name="unitInStock" type="numeric" required="true">
<cfargument name="discount" type="numeric" required="true">
<cfargument name="thumbNailPhoto" type="string" required="true">
<cfargument name="largePhoto" type="string" required="true">
<cfinvoke method="productEdit" component="db.productComponent.productEdit" productID=#ARGUMENTS.productID# productDesc="#ARGUMENTS.productDesc#" unitPrice=#ARGUMENTS.unitPrice# unitInStock=#ARGUMENTS.unitInStock# discount=#ARGUMENTS.discount# thumbNailPhoto="#ARGUMENTS.thumbNailPhoto#" largePhoto="#ARGUMENTS.largePhoto#"/>
</cffunction>


<!---
function     :editProductRemote
returnType   :numeric
hint         :It is used to edit the product details using AJAX call
--->
<cffunction name="editProductRemote" output="false" access="remote" returnType="numeric" returnformat="JSON" >
<cfargument name="productID" type="numeric" required="true">
<cfargument name="productDesc" type="string" required="true">
<cfargument name="unitPrice" type="numeric" required="true">
<cfargument name="unitInStock" type="numeric" required="true">
<cfargument name="discount" type="numeric" required="true">
<cfargument name="thumbNailPhoto" type="string" required="true">
<cfargument name="largePhoto" type="string" required="true">

<cftry>
<cfinvoke method="productEdit" component="db.productComponent.productEdit" productID=#ARGUMENTS.productID# productDesc="#ARGUMENTS.productDesc#" unitPrice=#ARGUMENTS.unitPrice# unitInStock=#ARGUMENTS.unitInStock# discount=#ARGUMENTS.discount# thumbNailPhoto="#ARGUMENTS.thumbNailPhoto#" largePhoto="#ARGUMENTS.largePhoto#"/>
<cfcatch type="any">
  <cfreturn 0>
</cfcatch>
</cftry>
<cfreturn 1>
</cffunction>


<!---
function     :getSubCategory
returnType   :array
hint         :It is used return the subCategory details using AJAX call
--->
<cffunction name="getSubCategory" output="false" access="remote" returntype="array" returnformat="JSON">
  <cfargument name="categoryID" required="true" cfsqltype="cf_sql_int">

    <cfinvoke method="getSubCategoryQuery" component="db.productComponent.productSubCategoryAndBrandAndCategory" categoryID=#ARGUMENTS.categoryID# returnvariable="subcategoryquery" />
    <cfset var arrayToStoreQuery=arrayNew(1)>

    <cfloop query="subcategoryquery">
      <cfset stData=structNew()>
              <cfset stData.subCategoryType="#subcategoryquery.subCategoryType#">
                <cfset stData.subCategoryID=#subcategoryquery.subCategoryID#>
              <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
    <cfreturn arrayToStoreQuery>
</cffunction>


<!---
function     :getProduct
returnType   :array
hint         :It is used to return the product details using AJAX call
--->
<cffunction name="getProduct" output="false" access="remote" returntype="array" returnformat="JSON">
  <cfargument name="subCategoryID" required="true" type="numeric" >

    <cfinvoke method="getProductQuery" component="db.productComponent.productSubCategoryAndBrandAndCategory" subCategoryID=#ARGUMENTS.subCategoryID# returnvariable="productquery" />
    <cfset var arrayToStoreQuery=arrayNew(1)>

    <cfloop query="productquery">
      <cfset stData=structNew()>
              <cfset stData.brandName="#productquery.brandName#">
                <cfset stData.photoID=#productquery.photoID#>
                  <cfset stData.productName="#productquery.productName#">
              <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
    <cfreturn arrayToStoreQuery>
</cffunction>



<!---
function     :getProductForEdit
returnType   :array
hint         :It is used to edit the products using AJAX call
--->
<cffunction name="getProductForEdit"  output="false" access="remote" returntype="array" returnformat="JSON">
  <cfargument name="subCategoryID" required="true" type="numeric" >
    <cfinvoke method="getProductQuery" component="db.productComponent.productSubCategoryAndBrandAndCategory" subCategoryID=#ARGUMENTS.subCategoryID# returnvariable="productquery" />
    <cfset var arrayToStoreQuery=arrayNew(1)>

    <cfloop query="productquery">
      <cfset stData=structNew()>
              <cfset stData.brandName="#productquery.brandName#">
                <cfset stData.productID=#productquery.productID#>
                  <cfset stData.productName="#productquery.productName#">
              <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
    <cfreturn arrayToStoreQuery>
</cffunction>



<!---
function     :onlineUsers
returnType   :numeric
hint         :It return number of online users
--->
<cffunction name="onlineUsers" output="false" returntype="numeric" access="remote" returnformat="JSON" >

<cftry>
  <cfinvoke method="getUsersOnline" component="db.userComponent.countOnlineUsers" returnvariable="onlinequery" />
<cfcatch type="any">
  <cflog file="ecommerece" text="error occured in adminData.cfc at onlineUsers function" application="true" >
</cfcatch>
</cftry>
  <cfreturn onlinequery.totalUsers>
</cffunction>


<!---
function     :getProductBasedOnID
returnType   :query
hint         :It returns the product details based on productID
--->
<cffunction name="getProductBasedOnID" access="public" returntype="query" output="false">
  <cfargument name="productID" required="true" type="numeric">
    <cfset LOCAL.retriveProduct=VARIABLES.productInfo.getProductInfo(ARGUMENTS.productID)>
    <cfreturn LOCAL.retriveProduct>
</cffunction>


<!---
function     :notificationData
returnType   :array
hint         :It is used to return top 3 notification in array
--->
<cffunction name="notificationData" output="false" access="remote" returntype="array" returnformat="JSON">
<cfargument name="content" required="true" type="string">

<cfset VARIABLES.socketAndUserStatus.insertNotificationDataQuery(ARGUMENTS.content)>
  <cfset LOCAL.getquery=VARIABLES.socketAndUserStatus.getTopNotification()>


<cfset var arrayToStoreQuery=arrayNew(1)>

<cfloop query="getquery">
  <cfset stData=structNew()>
          <cfset stData.content="#LOCAL.getquery.content#">

              <cfset stData.postTime="#LOCAL.getquery.postTime#">
          <cfset arrayAppend(arrayToStoreQuery,stData)>
</cfloop>
<cfreturn arrayToStoreQuery>
</cffunction>


<!---
function     :getNotification
returnType   :query
hint         :It is return all the notifications
--->
<cffunction name="getNotification" output="false" access="public" returntype="query">

  <cfset LOCAL.getquery=VARIABLES.socketAndUserStatus.getNotificationQuery()>
  <cfreturn LOCAL.getquery>
</cffunction>


<!---
function     :markAsReadNotification
returnType   :void
hint         :It is used to change the status of the notifications
--->
<cffunction name="markAsReadNotification" output="false" access="remote" returntype="void">
  <cfset VARIABLES.socketAndUserStatus.markAsReadNotificationQuery()>
</cffunction>


<!---
function     :addBrand
returnType   :void
hint         :It is used to add new brand
--->
<cffunction name="addBrand" output="false" access="remote" returntype="void">
<cfargument name="brandName" required="true" type="string">
<cfset VARIABLES.addBrandAndCategory.addBrandToDatabase(ARGUMENTS.brandName)>
</cffunction>


<!---
function     :addCategory
returnType   :void
hint         :It is used to add new category
--->
<cffunction name="addCategory" output="false" access="remote" returntype="void">
<cfargument name="categoryType" required="true" type="string">
<cfset variables.addBrandAndCategory.addCategoryToDatabase(ARGUMENTS.categoryType)>
</cffunction>

</cfcomponent>
