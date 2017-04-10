<cfcomponent>

  <!---
  function    :addBrandToDatabase
  returnType  :void
  hint        :It adds new bran to database
  --->
<cffunction name="addBrandToDatabase" output="false" access="public" returntype="void">
<cfargument name="brandName" required="true" type="string">
<cftry>
  <cfquery name="addquery">
    INSERT INTO Brands(brandName)
    VALUES(<cfqueryparam value="#ARGUMENTS.brandName#" cfsqltype="cf_sql_varchar">)
  </cfquery>
  <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in addBrandToDatabase function.The SQL state : #cfcatch.queryError#" application="true" >
  </cfcatch>
</cftry>
</cffunction>


<!---
function    :addCategoryToDatabase
returnType  :void
hint        :It adds new category to database
--->
<cffunction name="addCategoryToDatabase" output="false" access="remote" returntype="void">
<cfargument name="categoryType" required="true" type="string">
<cftry>
  <cfquery name="addquery">
    INSERT INTO Category(categoryType)
    VALUES(<cfqueryparam value="#ARGUMENTS.categoryType#" cfsqltype="cf_sql_varchar">)
  </cfquery>
  <cfcatch type="Database">
    <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in addcategoryToDatabase function .The SQL state : #cfcatch.queryError#" application="true" >
  </cfcatch>
</cftry>
</cffunction>


<!---
function    :getBrand
returnType  :query
hint        :It return all the brand names available
--->
<cffunction name="getBrand" returntype="query" access="public" output="false">
  <cftry>
    <cfquery name="brandquery">
      SELECT brandName FROM Brands
    </cfquery>
    <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in getBrand function . The SQL state : #cfcatch.queryError#" application="true" >
        <cfset emptyQuery=queryNew("brandName")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn brandquery/>
</cffunction>
</cfcomponent>
