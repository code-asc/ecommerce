<cfcomponent extends="db.adminPageComponent.saleRecord">


  <!---
  function     :highestSaleProductQuery
  returnType   :query
  hint         :It will number of total quantity of the product sold
  --->
<cffunction name="highestSaleProductQuery" returntype="query" output="false" access="public">
  <cftry>
  <cfquery name="productinfoquery" cachedwithin="#createTimeSpan(0,0,1,0)#" >
  SELECT sum(OrderDetails.quantity) AS total ,Brands.brandName  from OrderDetails
  INNER JOIN Products
  on
  Products.productID=OrderDetails.detailProductID
  INNER JOIN Brands
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
