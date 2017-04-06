<cfcomponent>
<cffunction name="filterProduct" returntype="array" output="false" access="remote" returnformat="JSON" >
<cfargument name="brand" required="true" type="string">
<cfargument name="discount" required="true" type="string">
<cfargument name="category" required="true" type="string">

  <cfquery name="filterquery">
      select Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
      inner join ProductPhoto
      on
      Products.photoID=ProductPhoto.photoID
      inner join Brands
      on
      Products.brandID=Brands.brandID
      <!--- --->
      inner join SubCategory
      on
      Products.subCategoryID=SubCategory.subCategoryID
      inner join Category
      on
      Category.categoryID=SubCategory.categoryID
      <!--- --->
      where Products.subCategoryID IN (<cfqueryparam value="1,2,3,11" cfsqltype="cf_sql_integer" list="true">)
  <cfif ArrayLen(deserializeJSON(arguments.brand)) GT 0>

        AND
        Brands.brandID IN (<cfqueryparam value=#arrayToList(deserializeJSON(arguments.brand))# list="true" cfsqltype="cf_sql_int">)

        </cfif>

<cfif ArrayLen(deserializeJSON(arguments.discount)) GT 0>

              AND
              Products.discount IN (<cfqueryparam value=#arrayToList(deserializeJSON(arguments.discount))# list="true" cfsqltype="cf_sql_decimal">)
        </cfif>

<cfif ArrayLen(deserializeJSON(arguments.category)) GT 0>

  AND
  Category.categoryType IN (<cfqueryparam value=#arrayToList(deserializeJSON(arguments.category))# list="true" cfsqltype="cf_sql_varchar">)
</cfif>

    </cfquery>

    <cfset var arrayToStoreQuery=arrayNew(1)>


    <cfloop query="filterquery">
      <cfset stData=structNew()>
            <cfset stData.thumbNailPhoto=#filterquery.thumbNailPhoto#>
            <cfset stData.productID=#filterquery.productID#>
            <cfset stData.productName=#filterquery.productName#>
            <cfset stData.productDesc=#filterquery.productDesc#>
            <cfset stData.discount=#filterquery.discount#>
            <cfset stData.unitPrice=#filterquery.unitPrice#>
            <cfset stData.thumbNailPhoto=#filterquery.thumbNailPhoto#>
            <cfset stData.brandName=#filterquery.brandName#>
            <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
    <cfreturn arrayToStoreQuery>
    </cffunction>
    </cfcomponent>
