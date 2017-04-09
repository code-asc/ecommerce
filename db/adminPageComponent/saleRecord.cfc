<cfcomponent>

  <cffunction name="countCountry" output="false" returntype="query" access="public">
    <cftry>
      <cfquery name="countryquery">
        SELECT count(customerCountry) AS total , customerCountry FROM Address GROUP BY customerCountry
      </cfquery>
      <cfcatch type="any">
        <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countCountry function">
          <cfset emptyQuery=queryNew("total,customerCountry")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn countryquery>
  </cffunction>

<cffunction name="countCustomer" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="customerquery">
    SELECT count(userID) AS total FROM Customer
  </cfquery>
  <cfcatch type="any">
    <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countCustomer function">
      <cfset emptyQuery=queryNew("total")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn customerquery/>
</cffunction>

<cffunction name="countProduct" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="productquery">
    SELECT count(productID) as total FROM Products
  </cfquery>
  <cfcatch type="any">
    <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countProduct function">
      <cfset emptyQuery=queryNew("total")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn productquery/>
</cffunction>

<cffunction name="countCategory" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="categoryquery">
    SELECT count(categoryID) AS total FROM Category
  </cfquery>
  <cfcatch type="any">
    <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countCategory function">
      <cfset emptyQuery=queryNew("total")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn categoryquery/>
</cffunction>

<cffunction name="countSubCategory" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="subcategoryquery">
    SELECT count(subCategoryID) as total FROM SubCategory
  </cfquery>
  <cfcatch type="any">
    <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countSubCategory function">
      <cfset emptyQuery=queryNew("total")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn subcategoryquery/>
</cffunction>

<cffunction name="countSupplier" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="supplierquery">
    SELECT count(supplierID) AS total FROM Supplier
  </cfquery>
  <cfcatch type="any">
    <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countSupplier function">
      <cfset emptyQuery=queryNew("total")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn supplierquery/>
</cffunction>

<cffunction name="countShipping" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="shippingquery">
    SELECT count(shippingID) as total FROM ShippingDetails
  </cfquery>
  <cfcatch type="any">
    <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countShipping function">
      <cfset emptyQuery=queryNew("total")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn shippingquery/>
</cffunction>

</cfcomponent>
