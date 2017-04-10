<cfcomponent extends="db.productComponent.addBrandAndCategory">

  <!---
  function    :setOrderDetails
  returnType  :void
  hint        :It is userd to add customer order details
  --->
  <cffunction name="setOrderDetails" output="false" access="public" returntype="void" >
    <cfargument name="afterDiscount" required="true" type="numeric"/>
    <cfargument name="supplierID" required="true" type="numeric"/>
    <cfargument name="status" required="true" type="string"/>
    <cfargument name="productID" required="false" default=#SESSION.productID# type="numeric" />

<cftry>
    <cfquery name="insertquery">
       INSERT INTO OrderDetails(detailProductID,detailPrice,supplierID,status,userID,quantity)
       VALUES(
       <cfqueryparam value=#ARGUMENTS.productID# cfsqltype="cf_sql_int"> ,
           <cfqueryparam value=#ARGUMENTS.afterDiscount# cfsqltype="cf_sql_decimal">,
             <cfqueryparam value=#ARGUMENTS.supplierID# cfsqltype="cf_sql_int">,
               <cfqueryparam value="#ARGUMENTS.status#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
                   <cfqueryparam value=#1# cfsqltype="cf_sql_int">
                     )
     </cfquery>
     <cfcatch type="Database">
       <cflog file="ecommerece" text="error occured in orderDetails.cfc .The SQL state : #cfcatch.queryError#" application="true" >
     </cfcatch>
   </cftry>
  </cffunction>


  <!---
  function    :updateOrderDetails
  returnType  :void
  hint        :It is used to update the order details based on productID
  --->
  <cffunction name="updateOrderDetails" returntype="void" output="false" access="public">
    <cftry>
      <cfquery name="updatequery">
        UPDATE OrderDetails
        SET quantity=quantity+1
        WHERE
        detailProductID=<cfqueryparam value=#SESSION.productID# cfsqltype="cf_sql_int">
          AND
          userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc .The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>


  <!---
  function    :updateOrderDetailsBasedOnStatus
  returnType  :void
  hint        :It updates the status of Order details to progress
  --->
  <cffunction name="updateOrderDetailsBasedOnStatus" returntype="void" output="false" access="public">
    <cftry>
      <cfquery name="purchasequery">
        UPDATE OrderDetails
        SET OrderDetails.status='progress'
        FROM OrderDetails
        INNER JOIN Products
        ON
        Products.productID=OrderDetails.detailProductID
        WHERE
        OrderDetails.userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqlType="cf_sql_int">
          AND
          OrderDetails.status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar">
            AND
            Products.unitInStock >= OrderDetails.quantity
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc .The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>


  <!---
  function    :countOrderDetails
  returnType  :query
  hint        :It will return total quantity of the order ddetails
  --->
  <cffunction name="countOrderDetails" output="false" access="public" returntype="query">
    <cftry>
      <cfquery name="countquery">
        SELECT quantity from OrderDetails
        WHERE
        userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqlType="cf_sql_int">
        AND
        status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar" >
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc in countOrderDetails function .The SQL state : #cfcatch.queryError#" application="true" >
          <cfset emptyQuery=queryNew("quantity")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn countquery/>
  </cffunction>


  <!---
  function    :setOrder
  returnType  :numeric
  hint        :It insert a new record with customer addressID and returns the identitycol
  --->
  <cffunction name="setOrder" output="false" returntype="numeric" access="public">
    <cfargument name="addressID" required="true" type="numeric"/>
    <cftry>
      <cfquery name="insertquery" result="result">
      INSERT INTO Orders(userID,addressID)
        VALUES(<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
            <cfqueryparam value=#ARGUMENTS.addressID# cfsqltype="cf_sql_int">)
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc in setOrder function .The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>
    </cftry>
    <cfset LOCAL.identityID=#result.identitycol#>
    <cfreturn LOCAL.identityID/>
  </cffunction>


  <!---
  function    :getOrderDetailID
  returnType  :query
  hint        :It will return a detailID of the user based on the status such as addedToCart , progress , ordered
  --->
<cffunction name="getOrderDetailID" returntype="query" output="false" access="public">
<cfargument name="status" required="true" type="string"/>
  <cftry>
    <cfquery name="checkquery">
      SELECT detailID FROM OrderDetails
      WHERE
      userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        detailProductID=<cfqueryparam value=#SESSION.productID# cfsqltype="cf_sql_int">
          AND
          status=<cfqueryparam value="#ARGUMENTS.status#" cfsqltype="cf_sql_varchar" >
    </cfquery>
    <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in orderDetails.cfc in getOrderDetailID function .The SQL state : #cfcatch.queryError#" application="true" >
        <cfset emptyQuery=queryNew("detailID")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn checkquery/>
</cffunction>


<!---
function    :getDetailProductID
returnType  :query
hint        :It will return the productID and quantity of each product that is addedToCatr or ordered`
--->
<cffunction name="getDetailProductID" returntype="query" output="false" access="public">
<cfargument name="status" required="true" type="string"/>
  <cftry>
    <cfquery name="retriveInfo">
    SELECT detailProductID , quantity  FROM OrderDetails
    WHERE userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqlType="cf_sql_int">
    AND
    status=<cfqueryparam value="#ARGUMENTS.status#" cfsqlType="cf_sql_varchar">
      AND
      orderID=<cfqueryparam value=#SESSION.identityID# cfsqltype="cf_sql_int" >
    </cfquery>
    <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in orderDetails.cfc in getDetailProductID function .The SQL state : #cfcatch.queryError#" application="true" >
        <cfset emptyQuery=queryNew("detailProductID , quantity ")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn retriveInfo/>
</cffunction>


<!---
function    :getOrderDetailByOnlyID
returnType  :query
hint        :It returns the orderDetails based on detailID
--->
<cffunction name="getOrderDetailByOnlyID" output="false" returntype="query" access="public">
  <cfargument name="id" required="true" type="numeric"/>
  <cftry>
    <cfquery name="getqueryof">
      SELECT detailPrice, quantity FROM OrderDetails
      WHERE
      detailID=<cfqueryparam value=#ARGUMENTS.id# cfsqltype="cf_sql_int">
    </cfquery>
    <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in orderDetails.cfc in getOrderDetailByOnlyID function. The SQL state : #cfcatch.queryError#" application="true" >
        <cfset emptyQuery=queryNew(" detailPrice, quantity")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn getqueryof/>
</cffunction>


<!---
function    :getOrderPriceAndQty
returnType  :query
hint        :It returns total quantity and total price  of products that added to cart
--->
<cffunction name="getOrderPriceAndQty" output="false" returntype="query" access="public">
  <cftry>
    <cfquery name="getquery">
      SELECT sum(quantity) AS totalCount, sum(detailPrice*quantity) AS sum FROM OrderDetails
      WHERE
      userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      AND
      status=<cfqueryparam value="addedToCart" cfsqlType="cf_sql_varchar">
    </cfquery>
    <cfcatch type="Database">
      <cflog file="ecommerece" text="error occured in orderDetails.cfc in getOrderPriceAndQty function. The SQL state : #cfcatch.queryError#" application="true" >
        <cfset emptyQuery=queryNew(" totalCount,sum")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn getquery/>
</cffunction>


<!---
function    :deleteOrder
returnType  :void
hint        :It is used to delete order
--->
<cffunction name="deleteOrder" returntype="void" output="false" access="public">
  <cfargument name="cartID" type="numeric" required="true">
    <cftry>
      <cfquery name="removecart">
        DELETE FROM OrderDetails where detailID=<cfqueryparam value=#ARGUMENTS.cartID# cfsqltype="cf_sql_int">
        AND
        userID=<cfqueryparam value=#SESSION.stLoggedInUser.userID# cfsqlType="cf_sql_int" >
      </cfquery>
      <cfcatch type="Database">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc in deleteOrder function .The SQL state : #cfcatch.queryError#" application="true" >
      </cfcatch>
    </cftry>
</cffunction>
</cfcomponent>
