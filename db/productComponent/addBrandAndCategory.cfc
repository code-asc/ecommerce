<cfcomponent>
<cffunction name="addBrandToDatabase" output="false" access="public" returntype="void">
<cfargument name="brandName" required="true" type="string">

<cftry>
  <cfquery name="addquery">
    insert into Brands(brandName)
    values(<cfqueryparam value="#arguments.brandName#" cfsqltype="cf_sql_varchar">)
  </cfquery>
  <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in addBrandToDatabase function" application="true" >
  </cfcatch>
</cftry>
</cffunction>

<cffunction name="addCategoryToDatabase" output="false" access="remote" returntype="void">
<cfargument name="categoryType" required="true" type="string">
<cftry>
  <cfquery name="addquery">
    insert into Category(categoryType)
    values(<cfqueryparam value="#arguments.categoryType#" cfsqltype="cf_sql_varchar">)
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in addcategoryToDatabase function" application="true" >
  </cfcatch>
</cftry>
</cffunction>

<cffunction name="getBrand" returntype="query" access="public" output="false">
  <cftry>
    <cfquery name="brandquery">
      select brandName from Brands
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in getBrand function" application="true" >
        <cfset emptyQuery=queryNew("brandName")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn brandquery/>
</cffunction>
</cfcomponent>
