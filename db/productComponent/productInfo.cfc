<cfcomponent extends="db.productComponent.orderDetails" >
<cffunction name="getProductInfo" output="false" access="public" returnType="query">
<cfargument name="productID" type="numeric" required="true">
<cftry>
  <cfquery name="productquery">
    select  Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice,Products.unitInStock,ProductPhoto.photoID ,ProductPhoto.largePhoto,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName ,SubCategory.subCategoryType,Category.categoryType,SubCategory.subCategoryID,Category.categoryID
     from Products
    inner join ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    inner join Brands
    on
    Products.brandID=Brands.brandID
    inner join SubCategory
    on
    Products.subCategoryID=SubCategory.subCategoryID
    inner join Category
    on
    Subcategory.categoryID=Category.categoryID
    where Products.productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_int">
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc" application="true" >
      <cfset emptyQuery=queryNew("productID,productName,productDesc,unitPrice,unitInStock,largePhoto,thumbNailPhoto,discount,brandName,subCategoryType,categoryType,subCategoryID,categoryID")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn productquery>
</cffunction>

<cffunction name="getProductInfoBySubCategory" output="false" access="public" returnType="query">
<cfargument name="brand" required="true" type="string">
<cfargument name="discount" required="true" type="string">

<cftry>
  <cfquery name="filterquery">
      select Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
      inner join ProductPhoto
      on
      Products.photoID=ProductPhoto.photoID
      inner join Brands
      on
      Products.brandID=Brands.brandID
      where Products.subCategoryID=<cfqueryparam value=#session.subCategoryID# cfsqltype="cf_sql_integer">
  <cfif ArrayLen(deserializeJSON(arguments.brand)) GT 0>

        AND
        Brands.brandID IN (<cfqueryparam value=#arrayToList(deserializeJSON(arguments.brand))# list="true" cfsqltype="cf_sql_int">)

        </cfif>

        <cfif ArrayLen(deserializeJSON(arguments.discount)) GT 0>

              AND
              Products.discount IN (<cfqueryparam value=#arrayToList(deserializeJSON(arguments.discount))# list="true" cfsqltype="cf_sql_decimal">)

              </cfif>
    </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc getProductInfoBySubCategory function" application="true" >
      <cfset emptyQuery=queryNew("productID,productName,productDesc,unitPrice,unitPrice,thumbNailPhoto,discount,brandName")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn filterquery>
</cffunction>

<cffunction name="getProductInfoByID" returntype="query" access="public" output="false">
<cftry>
  <cfquery name="getproduct">
      select unitPrice,supplierID ,afterDiscount from Products
      where
      productID=<cfqueryparam value=#session.productID# cfsqltype="cf_sql_int">
    </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc in getProductInfoByID function" application="true" >
    <cfset emptyQuery=queryNew("unitPrice,supplierID,afterDiscount")>
      <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn getproduct/>
</cffunction>


<cffunction name="getThumbnail" returntype="query" output="false" access="public">
  <cftry>
    <cfquery name="thumbnailquery" cachedwithin="#createTimeSpan(0,0,1,0)#" >
      select thumbNailPhoto ,brandID,subCategoryID from ProductPhoto
      where thumbNailPhotoName=<cfqueryparam value="thumb" cfsqltype="varchar">
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in getThumbnail function" application="true" >
      <cfset emptyQuery=queryNew("thumbNailPhoto ,brandID,subCategoryID")>
        <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn thumbnailquery/>
</cffunction>

<cffunction name="homePageLargePhoto" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="homequery" cachedwithin="#createTimeSpan(0,0,1,0)#" >
    select largePhoto from ProductPhoto
    where largePhotoName=<cfqueryparam value="homepage" cfsqltype="varchar">
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc in homePageLargePhoto function" application="true" >
    <cfset emptyQuery=queryNew("largePhoto")>
      <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn homequery/>
</cffunction>

<cffunction name="incrementQuantityInDatabase" output="false" returntype="void" access="public">
<cfargument name="id" type="string" required="true">
  <cftry>
    <cfquery name="incrementquery">
      update OrderDetails
      set quantity=quantity+1
      where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        detailID=<cfqueryparam value=#arguments.id# cfsqltype="cf_sql_int">
          AND
        quantity <= <cfqueryparam value=10 cfsqltype="cf_sql_int" >
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in incrementQuantityInDatabase function" application="true" >
    </cfcatch>
  </cftry>
</cffunction>

<cffunction name="decrementQuantityInDatabase" output="false" returntype="void" access="public">
<cfargument name="id" type="string" required="true">
  <cftry>
    <cfquery name="decrementquery">
      update OrderDetails
      set quantity=quantity-1
      where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        detailID=<cfqueryparam value=#id# cfsqltype="cf_sql_int" >
          AND
        quantity >= <cfqueryparam value=2 cfsqltype="cf_sql_int" >
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in decrementQuantityInDatabase function" application="true" >
    </cfcatch>
  </cftry>
</cffunction>

<cffunction name="getBrandBySubCategory" output="false" returntype="query" access="public">
<cfargument name="subCategoryID" required="true" type="numeric">
<cftry>
  <cfquery name="retriveBrand">
    select DISTINCT Brands.brandName,Brands.brandID from Products
    inner join ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    inner join Brands
    on
    Products.brandID=Brands.brandID
    where Products.subCategoryID=<cfqueryparam value=#arguments.subCategoryID# cfsqltype="cf_sql_integer">
      ORDER BY Brands.brandName ASC
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc in getBrandBySubCategory function" application="true" >
      <cfset emptyQuery=queryNew("brandName,brandID")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn retriveBrand>
</cffunction>

<cffunction name="suggestedProduct" output="false" returntype="query" access="public">
  <cfargument name="subCategoryID" required="true" type="numeric">
  <cfargument name="productID" required="true" type="numeric">
    <cftry>
      <cfquery name="retriveProduct">
        select TOP 3 Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice,Products.discount ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
        inner join ProductPhoto
        on
        Products.photoID=ProductPhoto.photoID
        inner join Brands
        on
        Products.brandID=Brands.brandID
        where Products.subCategoryID=<cfqueryparam value=#arguments.subCategoryID# cfsqltype="cf_sql_integer">
          AND
          NOT Products.productID=<cfqueryparam value=#arguments.productID# cfsqltype="cf_sql_int" >
        order by NEWID()
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in productInfo.cfc in suggestedProduct function" application="true" >
          <cfset emptyQuery=queryNew("productID ,productName ,productDesc ,unitPrice,discount ,thumbNailPhoto,discount ,brandName")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn retriveProduct/>
</cffunction>
</cfcomponent>
