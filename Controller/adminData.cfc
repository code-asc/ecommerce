<cfcomponent>
<cfset variables.addBrandAndCategory=createObject("component","db.productComponent.addBrandAndCategory")>
<cfset variables.productInfo=createObject("component","db.productComponent.productInfo")>
<cfset variables.socketAndUserStatus=createObject("component","db.userComponent.socketNotification")>

<cffunction name="addToDatabase" access="remote" output="false" returnType="void">
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
<cfinvoke method="addProductInfoToDatabase" component="db.productComponent.productAdd" productName="#arguments.productName#" productDesc="#arguments.productDesc#" supplierID=#arguments.supplierID# subcategoryID=#arguments.subcategoryID# unitPrice=#arguments.unitPrice# thumbNail="#arguments.thumbNail#" thumbNailType="#arguments.thumbNailType#" largePhotoType="#arguments.largePhotoType#" largePhoto="#arguments.largePhoto#" quantity=#arguments.quantity# discount=#arguments.discount# rating=#arguments.rating# brandID=#arguments.brandID#/>
</cffunction>

<cffunction name="deleteFromDatabase" access="public" output="false" returnType="void">
<cfargument name="photoID" required="true" type="numeric">
<cfinvoke method="deleteProduct" component="db.productComponent.productDelete" photoID=#arguments.photoID#>
</cffunction>


<cffunction name="getProductInfo" output="false" access="remote" returnType="array" returnformat="JSON">
<cfargument name="productID" type="numeric" required="true">

<cfset LOCAL.productquery=variables.productInfo.getProductInfo(arguments.productID)>
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

<cffunction name="editProduct" output="false" access="public" returnType="void">
<cfargument name="productID" type="numeric" required="true">
<cfargument name="productDesc" type="string" required="true">
<cfargument name="unitPrice" type="numeric" required="true">
<cfargument name="unitInStock" type="numeric" required="true">
<cfargument name="discount" type="numeric" required="true">
<cfargument name="thumbNailPhoto" type="string" required="true">
<cfargument name="largePhoto" type="string" required="true">
<cfinvoke method="productEdit" component="db.productComponent.productEdit" productID=#arguments.productID# productDesc="#arguments.productDesc#" unitPrice=#arguments.unitPrice# unitInStock=#arguments.unitInStock# discount=#arguments.discount# thumbNailPhoto="#arguments.thumbNailPhoto#" largePhoto="#arguments.largePhoto#"/>
</cffunction>

<cffunction name="editProductRemote" output="false" access="remote" returnType="numeric" returnformat="JSON" >
<cfargument name="productID" type="numeric" required="true">
<cfargument name="productDesc" type="string" required="true">
<cfargument name="unitPrice" type="numeric" required="true">
<cfargument name="unitInStock" type="numeric" required="true">
<cfargument name="discount" type="numeric" required="true">
<cfargument name="thumbNailPhoto" type="string" required="true">
<cfargument name="largePhoto" type="string" required="true">

<cftry>
<cfinvoke method="productEdit" component="db.productComponent.productEdit" productID=#arguments.productID# productDesc="#arguments.productDesc#" unitPrice=#arguments.unitPrice# unitInStock=#arguments.unitInStock# discount=#arguments.discount# thumbNailPhoto="#arguments.thumbNailPhoto#" largePhoto="#arguments.largePhoto#"/>
<cfcatch type="any">
  <cfreturn 0>
</cfcatch>
</cftry>
<cfreturn 1>
</cffunction>

<cffunction name="getSubCategory" output="false" access="remote" returntype="array" returnformat="JSON">
  <cfargument name="categoryID" required="true" cfsqltype="cf_sql_int">

    <cfinvoke method="getSubCategoryQuery" component="db.productComponent.productSubCategoryAndBrandAndCategory" categoryID=#arguments.categoryID# returnvariable="subcategoryquery" />
    <cfset var arrayToStoreQuery=arrayNew(1)>

    <cfloop query="subcategoryquery">
      <cfset stData=structNew()>
              <cfset stData.subCategoryType="#subcategoryquery.subCategoryType#">
                <cfset stData.subCategoryID=#subcategoryquery.subCategoryID#>
              <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
    <cfreturn arrayToStoreQuery>
</cffunction>

<cffunction name="getProduct" output="false" access="remote" returntype="array" returnformat="JSON">
  <cfargument name="subCategoryID" required="true" type="numeric" >

    <cfinvoke method="getProductQuery" component="db.productComponent.productSubCategoryAndBrandAndCategory" subCategoryID=#arguments.subCategoryID# returnvariable="productquery" />
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


<cffunction name="getProductForEdit"  output="false" access="remote" returntype="array" returnformat="JSON">
  <cfargument name="subCategoryID" required="true" type="numeric" >
    <cfinvoke method="getProductQuery" component="db.productComponent.productSubCategoryAndBrandAndCategory" subCategoryID=#arguments.subCategoryID# returnvariable="productquery" />
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


<cffunction name="onlineUsers" output="false" returntype="numeric" access="remote" returnformat="JSON" >

<cftry>
  <cfinvoke method="getUsersOnline" component="db.userComponent.countOnlineUsers" returnvariable="onlinequery" />
<cfcatch type="any">
  <cflog file="ecommerece" text="error occured in adminData.cfc at onlineUsers function" application="true" >
</cfcatch>
</cftry>
  <cfreturn onlinequery.totalUsers>
</cffunction>


<cffunction name="getProductBasedOnID" access="public" returntype="query" output="false">
  <cfargument name="productID" required="true" type="numeric">
    <cfset LOCAL.retriveProduct=variables.productInfo.getProductInfo(arguments.productID)>
    <cfreturn LOCAL.retriveProduct>
</cffunction>

<cffunction name="notificationData" output="false" access="remote" returntype="array" returnformat="JSON">
<cfargument name="content" required="true" type="string">

<cfset variables.socketAndUserStatus.insertNotificationDataQuery(arguments.content)>
  <cfset LOCAL.getquery=variables.socketAndUserStatus.getTopNotification()>


<cfset var arrayToStoreQuery=arrayNew(1)>

<cfloop query="getquery">
  <cfset stData=structNew()>
          <cfset stData.content="#LOCAL.getquery.content#">

              <cfset stData.postTime="#LOCAL.getquery.postTime#">
          <cfset arrayAppend(arrayToStoreQuery,stData)>
</cfloop>
<cfreturn arrayToStoreQuery>
</cffunction>

<cffunction name="getNotification" output="false" access="public" returntype="query">

  <cfset LOCAL.getquery=variables.socketAndUserStatus.getNotificationQuery()>
  <cfreturn LOCAL.getquery>
</cffunction>


<cffunction name="markAsReadNotification" output="false" access="remote" returntype="void">

  <cfset variables.socketAndUserStatus.markAsReadNotificationQuery()>
</cffunction>


<cffunction name="addBrand" output="false" access="remote" returntype="void">
<cfargument name="brandName" required="true" type="string">
<cfset variables.addBrandAndCategory.addBrandToDatabase(arguments.brandName)>
</cffunction>

<cffunction name="addCategory" output="false" access="remote" returntype="void">
<cfargument name="categoryType" required="true" type="string">
<cfset variables.addBrandAndCategory.addCategoryToDatabase(arguments.categoryType)>
</cffunction>

</cfcomponent>
