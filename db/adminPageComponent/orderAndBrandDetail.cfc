<cfcomponent extends="db.adminPageComponent.saleRecord">

<cffunction name="highestSaleProductQuery" returntype="query" output="false" access="public">
  <cftry>
  <cfquery name="productinfoquery" cachedwithin="#createTimeSpan(0,0,1,0)#" >
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
      <cflog application="true" file="ecommerece" text="error in orderAndBrandDetail.cfc in highestSaleProductQuery function">
        <cfset emptyQuery=queryNew("total,brandName")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn productinfoquery/>
</cffunction>

</cfcomponent>
