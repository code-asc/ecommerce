<cfcomponent extends="db.productComponent.addBrandAndCategory">
  <cffunction name="setOrderDetails" output="false" access="public" returntype="void" >
    <cfargument name="afterDiscount" required="true" type="numeric"/>
    <cfargument name="supplierID" required="true" type="numeric"/>
    <cfargument name="status" required="true" type="string"/>

<cftry>
    <cfquery name="insertquery">
       insert into OrderDetails(detailProductID,detailPrice,supplierID,status,userID,quantity)
       values(
       <cfqueryparam value=#session.productID# cfsqltype="cf_sql_int"> ,
           <cfqueryparam value=#arguments.afterDiscount# cfsqltype="cf_sql_decimal">,
             <cfqueryparam value=#arguments.supplierID# cfsqltype="cf_sql_int">,
               <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
                   <cfqueryparam value=#1# cfsqltype="cf_sql_int">
                     )
     </cfquery>
     <cfcatch type="any">
       <cflog file="ecommerece" text="error occured in orderDetails.cfc" application="true" >
     </cfcatch>
   </cftry>
  </cffunction>

  <cffunction name="updateOrderDetails" returntype="void" output="false" access="public">
    <cftry>
      <cfquery name="updatequery">
        update OrderDetails
        set quantity=quantity+1
        where
        detailProductID=<cfqueryparam value=#session.productID# cfsqltype="cf_sql_int">
          AND
          userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>

  <cffunction name="updateOrderDetailsBasedOnStatus" returntype="void" output="false" access="public">
    <cftry>
      <cfquery name="purchasequery">
        update OrderDetails
        set OrderDetails.status='progress'
        from OrderDetails
        inner join Products
        on
        Products.productID=OrderDetails.detailProductID
        where
        OrderDetails.userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
          AND
          OrderDetails.status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar">
            AND
            Products.unitInStock >= OrderDetails.quantity
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc" application="true" >
      </cfcatch>
    </cftry>
  </cffunction>

  <cffunction name="countOrderDetails" output="false" access="public" returntype="query">
    <cftry>
      <cfquery name="countquery">
        select quantity from OrderDetails
        where
        userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
        and
        status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar" >
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc in countOrderDetails function" application="true" >
          <cfset emptyQuery=queryNew("quantity")>
            <cfreturn emptyQuery>
      </cfcatch>
    </cftry>
    <cfreturn countquery/>
  </cffunction>

  <cffunction name="setOrder" output="false" returntype="numeric" access="public">
    <cfargument name="addressID" required="true" type="numeric"/>
    <cftry>
      <cfquery name="insertquery" result="result">
        insert into Orders(userID,addressID)
        values(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
            <cfqueryparam value=#arguments.addressID# cfsqltype="cf_sql_int">)
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc in setOrder function" application="true" >
      </cfcatch>
    </cftry>
    <cfset LOCAL.identityID=#result.identitycol#>
    <cfreturn LOCAL.identityID/>
  </cffunction>

<cffunction name="getOrderDetailID" returntype="query" output="false" access="public">
<cfargument name="status" required="true" type="string"/>
  <cftry>
    <cfquery name="checkquery">
      select detailID from OrderDetails
      where
      userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        detailProductID=<cfqueryparam value=#session.productID# cfsqltype="cf_sql_int">
          AND
          status=<cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_varchar" >
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in orderDetails.cfc in getOrderDetailID function" application="true" >
        <cfset emptyQuery=queryNew("detailID")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn checkquery/>
</cffunction>

<cffunction name="getDetailProductID" returntype="query" output="false" access="public">
<cfargument name="status" required="true" type="string"/>
  <cftry>
    <cfquery name="retriveInfo">
    select detailProductID , quantity  from OrderDetails
    where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
    AND
    status=<cfqueryparam value="#arguments.status#" cfsqlType="cf_sql_varchar">
      AND
      orderID=<cfqueryparam value=#session.identityID# cfsqltype="cf_sql_int" >
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in orderDetails.cfc in getDetailProductID function" application="true" >
        <cfset emptyQuery=queryNew("detailProductID , quantity ")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn retriveInfo/>
</cffunction>

<cffunction name="getOrderDetailByOnlyID" output="false" returntype="query" access="public">
  <cfargument name="id" required="true" type="numeric"/>
  <cftry>
    <cfquery name="getqueryof">
      select detailPrice, quantity from OrderDetails
      where
      detailID=<cfqueryparam value=#arguments.id# cfsqltype="cf_sql_int">
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in orderDetails.cfc in getOrderDetailByOnlyID function" application="true" >
        <cfset emptyQuery=queryNew(" detailPrice, quantity")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn getqueryof/>
</cffunction>

<cffunction name="getOrderPriceAndQty" output="false" returntype="query" access="public">
  <cftry>
    <cfquery name="getquery">
      select sum(quantity) as totalCount, sum(detailPrice*quantity) as sum from OrderDetails
      where
      userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
      AND
      status=<cfqueryparam value="addedToCart" cfsqlType="cf_sql_varchar">
    </cfquery>
    <cfcatch type="any">
      <cflog file="ecommerece" text="error occured in orderDetails.cfc in getOrderPriceAndQty function" application="true" >
        <cfset emptyQuery=queryNew(" totalCount,sum")>
          <cfreturn emptyQuery>
    </cfcatch>
  </cftry>
  <cfreturn getquery/>
</cffunction>

<cffunction name="deleteOrder" returntype="void" output="false" access="public">
  <cfargument name="cartID" type="numeric" required="true">
    <cftry>
      <cfquery name="removecart">
        delete from OrderDetails where detailID=<cfqueryparam value=#arguments.cartID# cfsqltype="cf_sql_int">
        AND
        userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int" >
      </cfquery>
      <cfcatch type="any">
        <cflog file="ecommerece" text="error occured in orderDetails.cfc in deleteOrder function" application="true" >
      </cfcatch>
    </cftry>
</cffunction>
</cfcomponent>
