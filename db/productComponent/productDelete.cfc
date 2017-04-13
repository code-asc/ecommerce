<cfcomponent>


  <!---
  function    :deleteProduct
  returnType  :void
  hint        :It is used to delete the product and the photo
  --->
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
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in productDelete.cfc .The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>
    </cftry>
</cffunction>
</cfcomponent>
