<cfcomponent>

<cffunction name="deleteProduct" access="public" output="false" returnType="void">
<cfargument name="photoID" required="true" type="numeric">

<cftry>
  <cfquery name="productquery">
  DELETE FROM Products WHERE
  photoID=<cfqueryparam value=#ARGUMENTS.photoID# cfsqltype="cf_sql_int">
  </cfquery>

  <cfquery name="photoquery">
  DELETE FROM ProductPhoto WHERE
  photoID=<cfqueryparam value=#ARGUMENTS.photoID# cfsqltype="cf_sql_int">
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productDelete.cfc" application="true" >
  </cfcatch>
</cftry>
</cffunction>
</cfcomponent>
