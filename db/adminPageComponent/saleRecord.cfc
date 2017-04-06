<cfcomponent>

  <cffunction name="countCountry" output="false" returntype="query" access="public">
    <cftry>
      <cfquery name="countryquery">
        select count(customerCountry) as total , customerCountry from Address group by customerCountry
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
    select count(userID) as total from Customer
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
    select count(productID) as total from Products
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
    select count(categoryID) as total from Category
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
    select count(subCategoryID) as total from SubCategory
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
    select count(supplierID) as total from Supplier
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
    select count(shippingID) as total from ShippingDetails
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
