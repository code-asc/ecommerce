<cfcomponent >

<cffunction name="highestSaleProduct" output="false" returntype="query" access="public">
<cftry>
<cfquery name="productinfoquery">
select sum(OrderDetails.quantity) as total ,Brands.brandName  from OrderDetails
inner join Products
on
Products.productID=OrderDetails.detailProductID
inner join Brands
on
Products.brandID=Brands.brandID
group by Brands.brandName
  </cfquery>

  <cfcatch type="any">
    <cflog application="true" file="ecommerece" text="error:adminDashBoard.cfc-highestSaleProduct">
  </cfcatch>
</cftry>
  <cfreturn productinfoquery>
</cffunction>


<cffunction name="countryStatus" output="false" returntype="query" access="public">
  <cfquery name="countryquery">
    select count(customerCountry) as total , customerCountry from Address group by customerCountry
  </cfquery>
  <cfreturn countryquery>
</cffunction>

<cffunction name="allDetails" output="false" returntype="Struct" access="public">

<cfset var stData=StructNew()>
  <cfquery name="customerquery">
    select count(userID) as total from Customer
  </cfquery>

  <cfquery name="productquery">
    select count(productID) as total from Products
  </cfquery>

  <cfquery name="categoryquery">
    select count(categoryID) as total from Category
  </cfquery>

  <cfquery name="subcategoryquery">
    select count(subCategoryID) as total from SubCategory
  </cfquery>

  <cfquery name="supplierquery">
    select count(supplierID) as total from Supplier
  </cfquery>

  <cfquery name="shippingquery">
    select count(shippingID) as total from ShippingDetails
  </cfquery>

  <cfset stData.customer=#customerquery.total#>
  <cfset stData.product=#productquery.total#>
  <cfset stData.category=#categoryquery.total#>
  <cfset stData.subcategory=#subcategoryquery.total#>
  <cfset stData.supplier=#supplierquery.total#>
  <cfset stData.shipping=#shippingquery.total#>

<cfreturn stData>
</cffunction>

</cfcomponent>
