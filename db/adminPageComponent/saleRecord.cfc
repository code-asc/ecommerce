<cfcomponent>


  <!---
  function     :countCountry
  returnType   :query
  hint         :It return number to different countries of the customers
  --->
  <cffunction name="countCountry" output="false" returntype="query" access="public">
        <cftry>
          <cfset LOCAL.countryquery=queryNew("total,customerCountry")>
            <cfquery name="LOCAL.countryquery">
              SELECT count(customerCountry) AS total , customerCountry FROM Address GROUP BY customerCountry
            </cfquery>
          <cfcatch type="Database">
              <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countCountry function .The SQL state : #cfcatch.queryError#">
            <!---  <cfset emptyQuery=queryNew("total,customerCountry")>
              <cfreturn emptyQuery>--->
              <cfreturn LOCAL.countryquery>
          </cfcatch>
        </cftry>
  <cfreturn LOCAL.countryquery>
  </cffunction>


  <!---
  function      :countCustomer
  returnType    :query
  hint          :It returns total number of customers
  --->
<cffunction name="countCustomer" output="false" returntype="query" access="public">
    <cftry>
      <cfset LOCAL.customerquery=queryNew("total")>
        <cfquery name="LOCAL.customerquery">
          SELECT count(userID) AS total FROM Customer
        </cfquery>
      <cfcatch type="Database">
          <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countCustomer function">
          <!---<cfset emptyQuery=queryNew("total")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.customerquery/>
      </cfcatch>
    </cftry>
<cfreturn LOCAL.customerquery/>
</cffunction>


<!---
function     :countProduct
returnType   :query
hint         :It returns total number of products
--->
<cffunction name="countProduct" output="false" returntype="query" access="public">
    <cftry>
      <cfset LOCAL.productquery=queryNew("total")>
      <cfquery name="LOCAL.productquery">
        SELECT count(productID) as total FROM Products
      </cfquery>
      <cfcatch type="Database">
          <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countProduct function">
          <!---<cfset emptyQuery=queryNew("total")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.productquery/>
      </cfcatch>
    </cftry>
<cfreturn LOCAL.productquery/>
</cffunction>


<!---
function    :countCategory
returnType  :query
hint        :It return number of Categories
--->
<cffunction name="countCategory" output="false" returntype="query" access="public">
    <cftry>
      <cfset LOCAL.categoryquery=queryNew("total")>
      <cfquery name="LOCAL.categoryquery">
        SELECT count(categoryID) AS total FROM Category
      </cfquery>
      <cfcatch type="Database">
          <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countCategory function">
          <!---<cfset emptyQuery=queryNew("total")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.categoryquery/>
      </cfcatch>
    </cftry>
<cfreturn LOCAL.categoryquery/>
</cffunction>

<!---
function     :countSubCategory
returnType   :query
hint         :It returns number of cubCategories
--->
<cffunction name="countSubCategory" output="false" returntype="query" access="public">
    <cftry>
      <cfset LOCAL.subcategoryquery=queryNew("total")>
      <cfquery name="LOCAL.subcategoryquery">
        SELECT count(subCategoryID) as total FROM SubCategory
      </cfquery>
      <cfcatch type="Database">
          <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countSubCategory function">
        <!---  <cfset emptyQuery=queryNew("total")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.subcategoryquery/>
      </cfcatch>
    </cftry>
<cfreturn LOCAL.subcategoryquery/>
</cffunction>


<!---
function        :countSupplier
returnType      :query
hint            :It returns number of suppliers
--->
<cffunction name="countSupplier" output="false" returntype="query" access="public">
    <cftry>
      <cfset LOCAL.supplierquery=queryNew("total")>
      <cfquery name="LOCAL.supplierquery">
        SELECT count(supplierID) AS total FROM Supplier
      </cfquery>
      <cfcatch type="Database">
          <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countSupplier function">
          <!---<cfset emptyQuery=queryNew("total")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.supplierquery/>
      </cfcatch>
    </cftry>
<cfreturn LOCAL.supplierquery/>
</cffunction>


<!---
function         :countShipping
returnType       :query
hint             :It returns number of shipping available
--->
<cffunction name="countShipping" output="false" returntype="query" access="public">
    <cftry>
      <cfset LOCAL.shippingquery=queryNew("total")>
      <cfquery name="LOCAL.shippingquery">
        SELECT count(shippingID) as total FROM ShippingDetails
      </cfquery>
      <cfcatch type="Database">
          <cflog application="true" file="ecommerece" text="error in saleRecord.cfc in countShipping function">
          <!---<cfset emptyQuery=queryNew("total")>
          <cfreturn emptyQuery>--->
          <cfreturn LOCAL.shippingquery/>
      </cfcatch>
    </cftry>
<cfreturn LOCAL.shippingquery/>
</cffunction>

</cfcomponent>
