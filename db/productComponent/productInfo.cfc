<cfcomponent extends="db.productComponent.orderDetails" >

  <!---
  function     :getProductInfo
  returnType   :query
  hint         :It is used to get complete product information using productID
  --->
<cffunction name="getProductInfo" output="false" access="public" returnType="query">
<cfargument name="productID" type="numeric" required="true">
<cftry>
  <cfquery name="productquery">
    SELECT  Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice,Products.unitInStock,ProductPhoto.photoID ,ProductPhoto.largePhoto,ProductPhoto.thumbNailPhoto ,Products.discount,Products.supplierID,Products.afterDiscount ,Brands.brandName ,SubCategory.subCategoryType,Category.categoryType,SubCategory.subCategoryID,Category.categoryID
     from Products
    INNER JOIN ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    INNER JOIN Brands
    on
    Products.brandID=Brands.brandID
    INNER JOIN SubCategory
    on
    Products.subCategoryID=SubCategory.subCategoryID
    INNER JOIN Category
    on
    Subcategory.categoryID=Category.categoryID
    where Products.productID=<cfqueryparam value=#ARGUMENTS.productID# cfsqltype="cf_sql_int">
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc" application="true" >
      <cfset emptyQuery=queryNew("productID,productName,productDesc,unitPrice,unitInStock,largePhoto,thumbNailPhoto,discount,brandName,subCategoryType,categoryType,subCategoryID,categoryID")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn productquery>
</cffunction>


<!---
function     :getProductInfoBySubCategory
returnType   :query
hint         :It is used to get product information based on subCategoryID
--->
<cffunction name="getProductInfoBySubCategory" output="false" access="public" returnType="query">
<cfargument name="brand" required="true" type="string">
<cfargument name="discount" required="true" type="string">
<cftry>
  <cfquery name="filterquery">
      SELECT Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
      INNER JOIN ProductPhoto
      on
      Products.photoID=ProductPhoto.photoID
      INNER JOIN Brands
      on
      Products.brandID=Brands.brandID
      where Products.subCategoryID=<cfqueryparam value=#session.subCategoryID# cfsqltype="cf_sql_integer">
  <cfif ArrayLen(deserializeJSON(ARGUMENTS.brand)) GT 0>

        AND
        Brands.brandID IN (<cfqueryparam value=#arrayToList(deserializeJSON(ARGUMENTS.brand))# list="true" cfsqltype="cf_sql_int">)

        </cfif>

        <cfif ArrayLen(deserializeJSON(ARGUMENTS.discount)) GT 0>

              AND
              Products.discount IN (<cfqueryparam value=#arrayToList(deserializeJSON(ARGUMENTS.discount))# list="true" cfsqltype="cf_sql_decimal">)

              </cfif>
    </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc getProductInfoBySubCategory function" application="true" >
      <cfset emptyQuery=queryNew("productID,productName,productDesc,unitPrice,unitPrice,thumbNailPhoto,discount,brandName")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn filterquery>
</cffunction>



<!---
function     :getProductInfoByID
returnType   :query
hint         :It is used to return unitPrice , supplierID and afterDiscount based on productID
--->
<cffunction name="getProductInfoByID" returntype="query" access="public" output="false">
<cftry>
  <cfquery name="getproduct">
      SELECT unitPrice,supplierID ,afterDiscount from Products
      where
      productID=<cfqueryparam value=#SESSION.productID# cfsqltype="cf_sql_int">
    </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc in getProductInfoByID function" application="true" >
    <cfset emptyQuery=queryNew("unitPrice,supplierID,afterDiscount")>
      <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn getproduct/>
</cffunction>


<!---
function     :getThumbnail
returnType   :query
hint         :It is used to get all thumbNail information
--->
<cffunction name="getThumbnail" returntype="query" output="false" access="public">
  <cftry>
    <cfquery name="thumbnailquery" cachedwithin="#createTimeSpan(0,0,1,0)#" >
      SELECT thumbNailPhoto ,brandID,subCategoryID from ProductPhoto
      where thumbNailPhotoName=<cfqueryparam value="thumb" cfsqltype="varchar">
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in getThumbnail function" application="true" >
      <cfset emptyQuery=queryNew("thumbNailPhoto ,brandID,subCategoryID")>
        <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn thumbnailquery/>
</cffunction>


<!---
function     :homePageLargePhoto
returnType   :query
hint         :It is used to get home page photos
--->
<cffunction name="homePageLargePhoto" output="false" returntype="query" access="public">
<cftry>
  <cfquery name="homequery" cachedwithin="#createTimeSpan(0,0,1,0)#" >
    SELECT largePhoto from ProductPhoto
    where largePhotoName=<cfqueryparam value="homepage" cfsqltype="varchar">
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc in homePageLargePhoto function" application="true" >
    <cfset emptyQuery=queryNew("largePhoto")>
      <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn homequery/>
</cffunction>

<!---
function     :incrementQuantityInDatabase
returnType   :void
hint         :It is used to incerment the ordered product of the customer
--->
<cffunction name="incrementQuantityInDatabase" output="false" returntype="void" access="public">
<cfargument name="id" type="string" required="true">
  <cftry>
    <cfquery name="incrementquery">
      update OrderDetails
      set quantity=quantity+1
      where userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        detailID=<cfqueryparam value=#ARGUMENTS.id# cfsqltype="cf_sql_int">
          AND
        quantity <= <cfqueryparam value=10 cfsqltype="cf_sql_int" >
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in incrementQuantityInDatabase function" application="true" >
    </cfcatch>
  </cftry>
</cffunction>


<!---
function     :decrementQuantityInDatabase
returnType   :void
hint         :It is used to decrement the of ordered product of a Customer
--->
<cffunction name="decrementQuantityInDatabase" output="false" returntype="void" access="public">
<cfargument name="id" type="string" required="true">
  <cftry>
    <cfquery name="decrementquery">
      update OrderDetails
      set quantity=quantity-1
      where userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        detailID=<cfqueryparam value=#id# cfsqltype="cf_sql_int" >
          AND
        quantity >= <cfqueryparam value=2 cfsqltype="cf_sql_int" >
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in decrementQuantityInDatabase function" application="true" >
    </cfcatch>
  </cftry>
</cffunction>


<!---
function     :productCartDetails
returnType   :query
hint         :It is used to return the cart details of the customer
--->
<cffunction name="productCartDetails" returntype="query" output="false" access="public">
  <cfargument name="status" required="true" type="string"/>
  <cftry>
    <cfquery name="retrivecart">
        SELECT Brands.brandName,OrderDetails.detailProductID,OrderDetails.quantity,Products.supplierID,OrderDetails.detailID,ProductPhoto.thumbNailPhoto,Products.afterDiscount,Products.productName,OrderDetails.supplierID,Supplier.supplierName,OrderDetails.status from OrderDetails
        INNER JOIN Products
        on
         Products.productID=OrderDetails.detailProductID
         INNER JOIN ProductPhoto
         on
         Products.photoID=ProductPhoto.photoID
         INNER JOIN Supplier
         on
         Products.supplierID=Supplier.supplierID
         INNER JOIN Brands
         on
         Products.brandID=Brands.brandID
         where
         OrderDetails.userID=
        <cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
            AND OrderDetails.status=
        <cfqueryparam value="#ARGUMENTS.status#" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in productCartDetails function" application="true" >
        <cfset emptyQuery=queryNew("brandName,detailProductID,quantity,supplierID,detailID,thumbNailPhoto,afterDiscount,productName,supplierID,supplierName,status")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn retrivecart/>
</cffunction>


<!---
function     :getBrandBySubCategory
returnType   :query
hint         :It is used to return the brand based on subCategoryID
--->
<cffunction name="getBrandBySubCategory" output="false" returntype="query" access="public">
<cfargument name="subCategoryID" required="true" type="numeric">
<cftry>
  <cfif ARGUMENTS.subCategoryID GT 0>
  <cfquery name="retriveBrand">
    SELECT DISTINCT Brands.brandName,Brands.brandID from Products
    INNER JOIN ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    INNER JOIN Brands
    on
    Products.brandID=Brands.brandID
    where Products.subCategoryID=<cfqueryparam value=#ARGUMENTS.subCategoryID# cfsqltype="cf_sql_integer">
      ORDER BY Brands.brandName ASC
  </cfquery>
  <cfelse>
    <cfset emptyQuery=queryNew("brandName,brandID")>
    <cfreturn emptyQuery>
</cfif>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc in getBrandBySubCategory function" application="true" >
      <cfset emptyQuery=queryNew("brandName,brandID")>
        <cfreturn emptyQuery>
  </cfcatch>
</cftry>
<cfreturn retriveBrand>
</cffunction>


<!---
function     :suggestedProduct
returnType   :query
hint         :It is used to return products based on subcategoryID
--->
<cffunction name="suggestedProduct" output="false" returntype="query" access="public">
  <cfargument name="subCategoryID" required="true" type="numeric">
  <cfargument name="productID" required="true" type="numeric">
    <cftry>
      <cfquery name="retriveProduct">
        SELECT TOP 3 Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice,Products.discount ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
        INNER JOIN ProductPhoto
        on
        Products.photoID=ProductPhoto.photoID
        INNER JOIN Brands
        on
        Products.brandID=Brands.brandID
        where Products.subCategoryID=<cfqueryparam value=#ARGUMENTS.subCategoryID# cfsqltype="cf_sql_integer">
          AND
          NOT Products.productID=<cfqueryparam value=#ARGUMENTS.productID# cfsqltype="cf_sql_int" >
        order by NEWID()
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in productInfo.cfc in suggestedProduct function" application="true" >
          <cfset emptyQuery=queryNew("productID ,productName ,productDesc ,unitPrice,discount ,thumbNailPhoto,discount ,brandName")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn retriveProduct/>
</cffunction>


<!---
function     :productInfoForFilters
returnType   :query
hint         :It is used to return the products based on brand filter
--->
<cffunction name="productInfoForFilters" returntype="query" access="public" output="false">
  <cfargument name="brand" required="true" type="string">
  <cfargument name="discount" required="true" type="string">
  <cfargument name="category" required="true" type="string">
    <cftry>
      <cfquery name="filterquery">
          SELECT Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
          INNER JOIN ProductPhoto
          on
          Products.photoID=ProductPhoto.photoID
          INNER JOIN Brands
          on
          Products.brandID=Brands.brandID
          <!--- --->
          INNER JOIN SubCategory
          on
          Products.subCategoryID=SubCategory.subCategoryID
          INNER JOIN Category
          on
          Category.categoryID=SubCategory.categoryID
          <!--- --->
          where Products.subCategoryID IN (<cfqueryparam value="1,2,3,11" cfsqltype="cf_sql_integer" list="true">)
      <cfif ArrayLen(deserializeJSON(ARGUMENTS.brand)) GT 0>

            AND
            Brands.brandID IN (<cfqueryparam value=#arrayToList(deserializeJSON(ARGUMENTS.brand))# list="true" cfsqltype="cf_sql_int">)

            </cfif>

    <cfif ArrayLen(deserializeJSON(ARGUMENTS.discount)) GT 0>

                  AND
                  Products.discount IN (<cfqueryparam value=#arrayToList(deserializeJSON(ARGUMENTS.discount))# list="true" cfsqltype="cf_sql_decimal">)
            </cfif>

    <cfif ArrayLen(deserializeJSON(ARGUMENTS.category)) GT 0>

      AND
      Category.categoryType IN (<cfqueryparam value=#arrayToList(deserializeJSON(ARGUMENTS.category))# list="true" cfsqltype="cf_sql_varchar">)
    </cfif>

        </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in productInfo.cfc in productInfoForFilters function" application="true" >
          <cfset emptyQuery=queryNew("productID ,productName ,productDesc ,unitPrice ,thumbNailPhoto ,discount ,brandName")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn filterquery/>
</cffunction>


<!---
function     :updateProductQtyOnOrder
returnType   :void
hint         :It is used to update the product quantity in the databases on any of the product ordered
--->
<cffunction name="updateProductQtyOnOrder" returntype="void" output="false" access="public" >
<cfargument name="productID" required="true" type="numeric"/>
<cftry>
  <cfquery name="updateproductquery">
  update Products
  set unitInStock=unitInStock-1
  where
  productID=<cfqueryparam value=#ARGUMENTS.productID# cfsqltype="cf_sql_int">
  </cfquery>
  <cfcatch type="any">
    <cflog file="ecommerece" text="error occured in productInfo.cfc in updateProductQtyOnOrder function" application="true" >
   </cfcatch>
</cftry>
</cffunction>


<!---
function     :productsDisplay
returnType   :query
hint         :It is used to return alll the  products based on subCategoryID
--->
<cffunction name="productsDisplay" returntype="query" output="false" access="public">
  <cftry>
    <cfquery name="retriveProduct" cachedwithin="#createTimeSpan(0,0,1,0)#" >
        SELECT Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
        INNER JOIN ProductPhoto
        on
        Products.photoID=ProductPhoto.photoID
        INNER JOIN Brands
        on
        Products.brandID=Brands.brandID
        where
        Products.subCategoryID=
        <cfqueryparam value="#session.subCategoryID#" cfsqltype="cf_sql_integer">
        </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in productDisplay function" application="true" >
        <cfset emptyQuery=queryNew("productID ,productName ,productDesc ,unitPrice ,thumbNailPhoto ,discount ,brandName")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn retriveProduct/>
</cffunction>


<!---
function     :retriveOnlyCategory
returnType   :query
hint         :It is used to return only categories
--->
<cffunction name="retriveOnlyCategory" output="false" returntype="query" access="public">
  <cftry>
    <cfquery name="categoryquery" cachedwithin="#createTimeSpan(0,0,1,0)#">
        SELECT Category.categoryID , Category.categoryType from Category
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in retriveOnlyCategory function" application="true" >
        <cfset emptyQuery=queryNew("categoryID,categoryType")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn categoryquery>
</cffunction>


<!---
function     :retriveOnlyBrand
returnType   :query
hint         :It is used only to retirve brands
--->
<cffunction name="retriveOnlyBrand" output="false" returntype="query" access="public">
  <cftry>
    <cfquery name="brandquery" cachedwithin="#createTimeSpan(0,0,1,0)#">
        SELECT Brands.brandID , Brands.brandName from Brands
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in retriveOnlyBrand function" application="true" >
        <cfset emptyQuery=queryNew("brandID,brandName")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn brandquery>
</cffunction>


<!---
function     :retriveOnlyShipping
returnType   :query
hint         :It is used only to retirve shippingID
--->
<cffunction name="retriveOnlyShipping" output="false" returntype="query" access="public" >
  <cftry>
    <cfquery name="shippingquery" cachedwithin="#createTimeSpan(0,0,1,0)#">
        SELECT ShippingDetails.shippingID , ShippingDetails.companyName from ShippingDetails
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in retriveOnlyShipping function" application="true" >
        <cfset emptyQuery=queryNew("shippingID ,companyName")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn shippingquery>
</cffunction>


<!---
function     :retriveOnlySupplier
returnType   :query
hint         :It is used only to retirve supplierID
--->
<cffunction name="retriveOnlySupplier" output="false" returntype="query" access="public">
  <cftry>
    <cfquery name="supplierquery" cachedwithin="#createTimeSpan(0,0,1,0)#">
        SELECT Supplier.supplierID , Supplier.supplierName from Supplier
    </cfquery>

    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in retriveOnlySupplier function" application="true" >
        <cfset emptyQuery=queryNew("supplierID,supplierName")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn supplierquery>
</cffunction>

<!---
function     :categoryOptionForHeader
returnType   :query
hint         :It is used to get categories for header
--->
<cffunction name="categoryOptionForHeader" output="false" returntype="query" access="public">
<cfargument name="arg1" required="true" type="numeric"/>
<cfargument name="arg2" required="false" type="numeric" default="0" />
<cfargument name="arg3" required="false" type="numeric" default="0" />
  <cftry>
    <cfquery name="subCategory" cachedwithin="#createTimeSpan(0,0,1,0)#" >
        SELECT Category.categoryType , SubCategory.subCategoryType , SubCategory.subCategoryID from Category
        INNER JOIN SubCategory
        on
        Category.categoryID=SubCategory.categoryID
        where
        Category.categoryID IN (<cfqueryparam value=#ARGUMENTS.arg1# cfsqltype="cf_sql_int" >
          <cfif ARGUMENTS.arg2 GT 0>
            <cfoutput>
              ,
            <cfqueryparam value=#ARGUMENTS.arg2# cfsqltype="cf_sql_int"/>
            </cfoutput>
          </cfif>
          <cfif ARGUMENTS.arg3 GT 0>
            <cfoutput>
              ,
            <cfqueryparam value=#ARGUMENTS.arg3# cfsqltype="cf_sql_int"/>
            </cfoutput>
          </cfif>
          )

    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in retriveOnlySupplier function" application="true" >
        <cfset emptyQuery=queryNew("categoryType , subCategoryType ,subCategoryID")>
          <cfreturn emptyQuery/>
    </cfcatch>
  </cftry>
  <cfreturn subCategory/>
</cffunction>


<!---
function     :productInfoForSearchPage
returnType   :query
hint         :It is used to return product information for search page
--->
<cffunction name="productInfoForSearchPage" output="false" access="public" returntype="query">
  <cfargument name="brandName" required="false" default="noSearch"/>
  <cftry>
    <cfquery name="retriveProduct">
        SELECT Products.productID , Products.productName,Products.subCategoryID ,Products.productDesc ,Products.unitPrice ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
        INNER JOIN ProductPhoto
        on
        Products.photoID=ProductPhoto.photoID
        INNER JOIN Brands
        on
        Products.brandID=Brands.brandID

            <cfif NOT ARGUMENTS.brandName EQ "noSearch">

                    WHERE Brands.brandName LIKE
                    <cfqueryparam value="%#ARGUMENTS.brandName#%" cfsqltype="cf_sql_varchar">

            </cfif>

    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in productInfo.cfc in productInfoForSearchPage function" application="true" >
        <cfset emptyQuery=queryNew("productID ,productName,subCategoryID ,productDesc ,unitPrice ,thumbNailPhoto ,discount ,brandName")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn retriveProduct/>
</cffunction>


</cfcomponent>
