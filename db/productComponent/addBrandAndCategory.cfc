<cfcomponent>

  <!---
  function    :addBrandToDatabase
  returnType  :void
  hint        :It adds new bran to database
  --->
<cffunction name="addBrandToDatabase" output="false" access="public" returntype="numeric">
<cfargument name="brandName" required="true" type="string">
    <cftry>
      <cfset LOCAL.checkQueryStatus=true>
          <cfquery name="addquery">
            BEGIN
            IF NOT EXISTS(SELECT brandID FROM Brands
            WHERE
            brandName=<cfqueryparam value="#ARGUMENTS.brandName#" cfsqltype="cf_sql_varchar">
            )
            BEGIN
            INSERT INTO Brands(brandName)
            VALUES(<cfqueryparam value="#ARGUMENTS.brandName#" cfsqltype="cf_sql_varchar">)
              END
              ELSE
              THROW 50001 , 'row already Exists' , 198;
              END
          </cfquery>
      <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in addBrandToDatabase function.The SQL state : #cfcatch.queryError#" application="true" >
          <cfreturn 0/>
      </cfcatch>
    </cftry>
    <cfreturn 1/>
</cffunction>


<!---
function    :addCategoryToDatabase
returnType  :void
hint        :It adds new category to database
--->
<cffunction name="addCategoryToDatabase" output="false" access="remote" returntype="numeric">
<cfargument name="categoryType" required="true" type="string">
    <cftry>
      <cfquery name="addquery">
        BEGIN
        IF NOT EXISTS(SELECT categoryType FROM Category
        WHERE
        categoryType=<cfqueryparam value="#ARGUMENTS.categoryType#" cfsqltype="cf_sql_varchar">
        )
        BEGIN
        INSERT INTO Category(categoryType)
        VALUES(<cfqueryparam value="#ARGUMENTS.categoryType#" cfsqltype="cf_sql_varchar">)
          END
          ELSE
          THROW 50001 , 'row already Exists' , 198;
          END
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in addcategoryToDatabase function .The SQL state : #cfcatch.queryError#" application="true" >
          <cfreturn 0/>
      </cfcatch>
    </cftry>
    <cfreturn 1/>
</cffunction>


<!---
function    :getBrand
returnType  :query
hint        :It return all the brand names available
--->
<cffunction name="getBrand" returntype="query" access="public" output="false">
    <cftry>
      <cfset LOCAL.brandquery=queryNew("brandName")>
      <cfquery name="LOCAL.brandquery">
        SELECT brandName FROM Brands
      </cfquery>
      <cfcatch type="Database">
          <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in getBrand function . The SQL state : #cfcatch.queryError#" application="true" >
          <!---<cfset emptyQuery=queryNew("brandName")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.brandquery/>
      </cfcatch>
    </cftry>
  <cfreturn LOCAL.brandquery/>
</cffunction>


<cffunction name="addSubCategory" returntype="numeric" access="public" output="false">
<cfargument name="categoryID" required="true" type="numeric">
<cfargument name="subCategory" required="true" type="string">
<cftry>
    <cfquery name="insertquery" result="getResult" >
      BEGIN
      IF NOT EXISTS(SELECT subCategoryID FROM SubCategory
      WHERE
      subCategoryType= <cfqueryparam value="#ARGUMENTS.subCategory#" cfsqltype="cf_sql_varchar"/>
      AND
      categoryID= <cfqueryparam value=#ARGUMENTS.categoryID# cfsqltype="cf_sql_int" />

      )
      BEGIN
      INSERT INTO SubCategory(categoryID,subCategoryType)
      VALUES
      (
      <cfqueryparam value=#ARGUMENTS.categoryID# cfsqltype="cf_sql_int" />,
      <cfqueryparam value="#ARGUMENTS.subCategory#" cfsqltype="cf_sql_varchar"/>
      )
      END
      ELSE
      THROW 50001 , 'row already Exists',198;
      END
    </cfquery>
  <cfcatch type="database">
    <cflog file="ecommerece" text="error occured in addBrandAndCategory.cfc in addSubCategory function . The SQL state : #cfcatch.queryError#" application="true" >
      <cfreturn 0/>
  </cfcatch>
</cftry>
<cfreturn 1/>
</cffunction>
</cfcomponent>
