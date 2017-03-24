<cfcomponent>

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

<cfquery name="addphotoquery" result="getPhotoIdentity">
insert into ProductPhoto(thumbNailPhoto,thumbNailPhotoName,largePhoto,largePhotoName,brandID,subCategoryID)
values(<cfqueryparam value="#arguments.thumbNail#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#arguments.thumbNailType#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#arguments.largePhoto#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#arguments.largePhotoType#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value=#arguments.brandID# cfsqltype="cf_sql_int">,
<cfqueryparam value=#arguments.subcategoryID# cfsqltype="cf_sql_int">
)
</cfquery>


<cfset var photoID=#getPhotoIdentity.identitycol#>


<cfquery name="productquery">
insert into Products(productName,productDesc,supplierID,subcategoryID,unitPrice,photoID,unitInStock,discount,rating,brandID)
values(<cfqueryparam value="#arguments.productName#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#arguments.productDesc#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#arguments.supplierID#" cfsqltype="cf_sql_int">,
<cfqueryparam value="#arguments.subCategoryID#" cfsqltype="cf_sql_int">,
<cfqueryparam value="#arguments.unitPrice#" cfsqltype="cf_sql_decimal">,
<cfqueryparam value="#photoID#" cfsqltype="cf_sql_int">,
<cfqueryparam value="#arguments.quantity#" cfsqltype="cf_sql_int">,
<cfqueryparam value="#arguments.discount#" cfsqltype="cf_sql_int">,
<cfqueryparam value="#arguments.rating#" cfsqltype="cf_sql_int">,
<cfqueryparam value="#arguments.brandID#" cfsqltype="cf_sql_int">
)
</cfquery>
</cffunction>

<cffunction name="deleteFromDatabase" access="public" output="false" returnType="void">
<cfargument name="photoID" required="true" type="numeric">

<cfquery name="productquery">
delete from Products where
photoID=<cfqueryparam value=#arguments.photoID# cfsqltype="cf_sql_int">
</cfquery>

<cfquery name="photoquery">
delete from ProductPhoto where
photoID=<cfqueryparam value=#arguments.photoID# cfsqltype="cf_sql_int">
</cfquery>

</cffunction>


<cffunction name="getProductInfo" output="false" access="remote" returnType="array" returnformat="JSON">
<cfargument name="productID" type="numeric" required="true">

<cfquery name="productquery">
select Products.productDesc,Products.unitPrice,Products.unitInStock,Products.discount,ProductPhoto.thumbNailPhoto,ProductPhoto.largePhoto from Products
inner join ProductPhoto
on
Products.photoID=ProductPhoto.photoID
where
Products.productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_int">
</cfquery>
<cfset var arrayToStoreQuery=arrayNew(1)>

<cfloop query="productquery">
  <cfset stData=structNew()>
          <cfset stData.thumbNailPhoto="#productquery.thumbNailPhoto#">
          <cfset stData.productDesc="#productquery.productDesc#">
          <cfset stData.unitPrice="#productquery.unitPrice#">
          <cfset stData.unitInStock="#productquery.unitInStock#">
          <cfset stData.discount="#productquery.discount#">
          <cfset stData.largePhoto="#productquery.largePhoto#">
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

<cfquery name="productupdatequery">
update Products
set productDesc=<cfqueryparam value="#arguments.productDesc#" cfsqltype="cf_sql_varchar">,
unitPrice=<cfqueryparam value=#arguments.unitPrice# cfsqltype="cf_sql_decimal">,
unitInStock=<cfqueryparam value=#arguments.unitInStock# cfsqltype="cf_sql_int">,
discount=<cfqueryparam value=#arguments.discount# cfsqltype="cf_sql_int">
where
productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_int">
</cfquery>

<cfquery name="photoupdatequery">
update ProductPhoto
set thumbNailPhoto=<cfqueryparam value="#arguments.thumbNailPhoto#" cfsqltype="cf_sql_varchar">,
   largePhoto=<cfqueryparam value="#arguments.largePhoto#" cfsqltype="cf_sql_varchar">
  from ProductPhoto
  inner join Products
  on
  Products.photoID=ProductPhoto.photoID
  where
  Products.productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_int" >
</cfquery>
</cffunction>

<cffunction name="getSubCategory" output="false" access="remote" returntype="array" returnformat="JSON">
  <cfargument name="categoryID" required="true" cfsqltype="cf_sql_int">
    <cfquery name="subcategoryquery">
      select subCategoryType , subCategoryID from SubCategory
      where categoryID=<cfqueryparam value=#arguments.categoryID# cfsqltype="cf_sql_int">
    </cfquery>

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
    <cfquery name="productquery">
      select Brands.brandName , Products.photoID , Products.productName from Products
      inner join Brands
      on
      Brands.brandID=Products.brandID
      where
      subCategoryID=<cfqueryparam value=#arguments.subCategoryID# cfsqltype="cf_sql_int" >
    </cfquery>
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
    <cfquery name="productquery">
      select Brands.brandName , Products.productID , Products.productName from Products
      inner join Brands
      on
      Brands.brandID=Products.brandID
      where
      subCategoryID=<cfqueryparam value=#arguments.subCategoryID# cfsqltype="cf_sql_int" >
    </cfquery>
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

</cfcomponent>
