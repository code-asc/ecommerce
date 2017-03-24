<cfcomponent>

<cffunction name="addNewUser" output="false" access="public" returnType="array">

<cfset var errorArray=arrayNew(1)>
  <cfif IsValid("email", form.email)>
<cfset var registerEmail=#form.email#>
<cfquery name="myquery">
select userEmail from Customer where userEmail=<cfqueryparam value=#registerEmail#  cfsqltype="cf_sql_varchar">
</cfquery>


<cfif myquery.recordCount EQ 0>

<!---<cfquery name="insertQuery">
insert into Customer(userFirstName,userMiddleName,userLastName,userEmail,userPassword,userPhone,userRegisteredDate)
values(
  <cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">,
  <cfqueryparam value="#form.middleName#" cfsqltype="cf_sql_varchar">,
  <cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_varchar">,
  <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
  <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">,
  <cfqueryparam value="#form.mobile#" cfsqltype="cf_sql_varchar">,
  getDate()
  )
</cfquery>--->
<cfstoredproc procedure="hash_userDetails">
  <cfprocparam value="#form.firstName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.middleName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.lastName#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.email#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.password#" cfsqltype="cf_sql_varchar" />
  <cfprocparam value="#form.mobile#" cfsqltype="cf_sql_varchar"/>

</cfstoredproc>

<cfreturn errorArray>
<cfelse>
  <cfset arrayAppend(errorArray, "This email is already registered")>
<cfreturn errorArray>
</cfif>


<cfelse>
  <cfset arrayAppend(errorArray,"Invalid Email Id")>
  <cfreturn errorArray>
</cfif>

</cffunction>


<cffunction name="validateUser" returnType="array" access="public" output="false">
<cfargument name="userEmail" required="true" type="string">
<cfargument name="userPassword" required="true" type="string">
  <cfset var aErrorMessage=arrayNew(1)>
    <cfif NOT isValid("email",arguments.userEmail)>
      <cfset arrayAppend(aErrorMessage,"invalid userEmail")>
    </cfif>

    <cfif arguments.userPassword EQ "">
      <cfset arrayAppend(aErrorMessage,"invalid password")>
    </cfif>
    <cfreturn aErrorMessage>
</cffunction>


<cffunction name="doLogin" access="public" output="false" returntype="boolean">
<cfargument name="userEmail" required="true" type="string">
  <cfargument name="userPassword" required="true" type="string">
     <cfquery name="loginUser">
       select Customer.userID , Customer.userFirstName , Customer.userMiddleName , Customer.userLastName , Customer.userEmail , Customer.userPassword  from Customer
       where
       userEmail=<cfqueryparam value = "#arguments.userEmail#" CFSQLType = "cf_sql_varchar" >
         AND
         userPassword=hashbytes('sha2_512',<cfqueryparam value = "#arguments.userPassword#" CFSQLType = "cf_sql_varchar">)
     </cfquery>

<cfquery name="checkStatus">
  select OnlineUser.userID,OnlineUser.email from OnlineUser
  where
  userID=<cfqueryparam value=#loginUser.userID# cfsqltype="cf_sql_int">
</cfquery>

     <cfif loginUser.recordCount EQ 1>

       <!--- logout other browser user --->
       <cfif NOT checkStatus.recordCount EQ 0>
         <cfinvoke component="removeSession" method="removeUserSession" userEmail=#checkStatus.email#>
       </cfif>
       <!--- --->
       <cflogin>
         <cfloginuser name="#loginUser.userFirstName# #loginUser.userMiddleName# #loginUser.userLastName#" password="#loginUser.userPassword#" roles="customer" />
       </cflogin>
       <cfset session.stLoggedInUser={"userFirstName"=#loginUser.userFirstName# , "userMiddleName"=#loginUser.userMiddleName# , "userLastName"=#loginUser.userLastName# , "userID"=#loginUser.userID# ,"userEmail"=#loginUser.userEmail#}>

<!---Update status --->
<cfquery name="insertquery">
insert into OnlineUser(userID,status,email)
values(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
  <cfqueryparam value="online" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#session.stLoggedInUser.userEmail#" cfsqltype="cf_sql_varchar">)
</cfquery>

<!---to show number of items in  cart --->
<cfquery name="querycount">
select detailID from OrderDetails where userID=<cfqueryparam value=#loginUser.userID# cfsqltype="cf_sql_int"> AND status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar" />
</cfquery>

<cfset updateCartCount()>
  <!--- --->
         <cfset var isUserLoggedIn=true>

           <cfelse>
             <cfset var isUserLoggedIn=false>
</cfif>
<cfreturn isUserLoggedIn>
</cffunction>

<cffunction name="doLogout" returntype="void" output="false" access="public">

  <cfquery name="deletequery">
    delete from OnlineUser
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
  </cfquery>

<cfset structDelete(session, "stLoggedInUser")>
  <cfset structDelete(session,"currentURL")>
    <cfset structDelete(session,"subCategoryID")>
      <cfset structDelete(session,"cartCount")>
    <cfset structClear(session)>
<cfset structDelete(cookie,"CFID")>
  <cfset structDelete(cookie, "CFTOKEN")>
    <!---<cfloop collection="#cookie#" item="name">
      <cfcookie name="#name#" value="" expires="now" />
    </cfloop>--->
  <cfcookie name="CFID" value="#cookie.CFID#" expires="now"   />
  <cfcookie name="CFTOKEN" value="#cookie.CFTOKEN#" expires="now"  />
  <cflogout />
  <cflocation url="index.cfm" addtoken="false" />
</cffunction>

<cffunction name="addToCart" returntype="void" output="false" access="remote">

<cfquery name="checkquery">
  select detailID from OrderDetails
  where
  userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
    AND
    detailProductID=<cfqueryparam value=#session.productID# cfsqltype="cf_sql_int">
      AND
      status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar" >
</cfquery>

  <cfif checkquery.recordCount EQ 0>

    <cfquery name="getproduct">
        select unitPrice,supplierID ,afterDiscount from Products where productID=<cfqueryparam value=#session.productID# cfsqltype="cf_sql_int">
      </cfquery>

<cfloop query="#getproduct#">
  <cfset afterDiscount=#getproduct.afterDiscount#>
    <cfset supplierID=#getproduct.supplierID#>
</cfloop>

<cfset status="addedToCart">


     <cfquery name="insertquery">
        insert into OrderDetails(detailProductID,detailPrice,supplierID,status,userID,quantity)
        values(
        <cfqueryparam value=#session.productID# cfsqltype="cf_sql_int"> ,
            <cfqueryparam value=#afterDiscount# cfsqltype="cf_sql_decimal">,
              <cfqueryparam value=#supplierID# cfsqltype="cf_sql_int">,
                <cfqueryparam value="#status#" cfsqltype="cf_sql_varchar">,
                  <cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
                    <cfqueryparam value=#1# cfsqltype="cf_sql_int">

        )
      </cfquery>
      <cfelse>
        <cfquery name="updatequery">
          update OrderDetails
          set quantity=quantity+1
          where
          detailProductID=<cfqueryparam value=#session.productID# cfsqltype="cf_sql_int">
            AND
            userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        </cfquery>
    </cfif>
<cfset updateCartCount()>
</cffunction>

<cffunction name="removeItemFromCart" access="public" output="false" returntype="any">
  <cfargument name="cartID" type="numeric" required="true">

    <cfquery name="removecart">
      delete from OrderDetails where detailID=<cfqueryparam value=#arguments.cartID# cfsqltype="cf_sql_int">
      AND
      userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int" >
    </cfquery>
<cfquery name="countquery">
  select detailID from OrderDetails
  where
  userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
    AND
    status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar" >
</cfquery>

    <cfset updateCartCount()>

</cffunction>


<cffunction name="homePageContent" returnType="array" access="remote" output="false" returnformat="JSON" >
  <cfquery name="homequery">
    select largePhoto from ProductPhoto
    where largePhotoName=<cfqueryparam value="homepage" cfsqltype="varchar">
  </cfquery>

<cfset var arrayToStoreQuery=arrayNew(1)>

<cfloop query="homequery">
  <cfset stData=structNew()>
          <cfset stData.largePhoto=#homequery.largePhoto#>
        <cfset arrayAppend(arrayToStoreQuery,stData)>
</cfloop>
<cfreturn arrayToStoreQuery>
</cffunction>

<cffunction name="filterProduct" returntype="array" output="false" access="remote" returnformat="JSON" >
<cfargument name="brand" required="true" type="string">
<cfargument name="discount" required="true" type="string">

  <cfquery name="filterquery">
      select Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
      inner join ProductPhoto
      on
      Products.photoID=ProductPhoto.photoID
      inner join Brands
      on
      Products.brandID=Brands.brandID
      where Products.subCategoryID=<cfqueryparam value=#session.subCategoryID# cfsqltype="cf_sql_integer">
  <cfif ArrayLen(deserializeJSON(arguments.brand)) GT 0>

        AND
        Brands.brandID IN (<cfqueryparam value=#arrayToList(deserializeJSON(arguments.brand))# list="true" cfsqltype="cf_sql_int">)

        </cfif>

        <cfif ArrayLen(deserializeJSON(arguments.discount)) GT 0>

              AND
              Products.discount IN (<cfqueryparam value=#arrayToList(deserializeJSON(arguments.discount))# list="true" cfsqltype="cf_sql_decimal">)

              </cfif>
    </cfquery>

    <cfset var arrayToStoreQuery=arrayNew(1)>

    <cfloop query="filterquery">
      <cfset stData=structNew()>
              <cfset stData.thumbNailPhoto=#filterquery.thumbNailPhoto#>
              <cfset stData.productID=#filterquery.productID#>
              <cfset stData.productName=#filterquery.productName#>
              <cfset stData.productDesc=#filterquery.productDesc#>
                <cfset stData.discount=#filterquery.discount#>
              <cfset stData.unitPrice=#filterquery.unitPrice#>
            <cfset stData.thumbNailPhoto=#filterquery.thumbNailPhoto#>
            <cfset stData.brandName=#filterquery.brandName#>
            <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
    <cfreturn arrayToStoreQuery>

</cffunction>

<cffunction name="homePageThumbNailInfo" output="false" returntype="array" access="remote" returnformat="JSON" >
  <cfquery name="thumbnailquery">
    select thumbNailPhoto ,brandID,subCategoryID from ProductPhoto
    where thumbNailPhotoName=<cfqueryparam value="thumb" cfsqltype="varchar">
  </cfquery>
  <cfset var arrayToStoreQuery=arrayNew(1)>
  <cfloop query="thumbnailquery">
    <cfset stData=structNew()>
      <cfset stData.brandID=#thumbnailquery.brandID#>
        <cfset stData.subCategoryID=#thumbnailquery.subCategoryID#>
    <cfset stData.thumbNail=#thumbnailquery.thumbNailPhoto#>
      <cfset arrayAppend(arrayToStoreQuery, stData)>
  </cfloop>
  <cfreturn arrayToStoreQuery>
</cffunction>



<cffunction name="incrementQuantity" returntype="array" output="false" access="remote" returnformat="JSON" >
  <cfargument name="id" type="string" required="true">
<cfset idValue=#deserializeJSON(arguments.id)#>
    <cfquery name="incrementquery">
      update OrderDetails
      set quantity=quantity+1
      where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        detailID=<cfqueryparam value=#idValue# cfsqltype="cf_sql_int">
          AND
        quantity <= <cfqueryparam value=10 cfsqltype="cf_sql_int" >
    </cfquery>

<cfquery name="getqueryof">
  select detailPrice, quantity from OrderDetails
  where
  detailID=<cfqueryparam value=#idValue# cfsqltype="cf_sql_int">
</cfquery>

<cfset var arrayToStoreQuery=arrayNew(1)>
<cfset var arrayCall=totalPriceAndQty()>

    <cfloop query="getqueryof">
      <cfset stData=structNew()>
      <cfset stData.quantity=#getqueryof.quantity#>
        <cfset stData.totalPrice=(#getqueryof.detailPrice# * #getqueryof.quantity#)>
          <cfset stData.totalCart=arrayCall[1]>
            <cfset stData.sum=arrayCall[2]>
            <cfset arrayAppend(arrayToStoreQuery,stData)>
    </cfloop>
<cfset updateCartCount()>
  <cfreturn arrayToStoreQuery>
</cffunction>

<cffunction name="totalPriceAndQty" returntype="array" output="false" access="public">
  <cfquery name="getquery">
    select sum(quantity) as totalCount, sum(detailPrice*quantity) as sum from OrderDetails
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
    AND
    status=<cfqueryparam value="addedToCart" cfsqlType="cf_sql_varchar">
  </cfquery>
  <cfset arrayToStoreQuery=arrayNew(1)>
  <cfloop query="getquery">
        <cfset arrayAppend(arrayToStoreQuery,#getquery.totalCount#)>
            <cfset arrayAppend(arrayToStoreQuery,#getquery.sum#)>
  </cfloop>
  <cfreturn arrayToStoreQuery>
</cffunction>

<cffunction name="decrementQuantity" returntype="array" output="false" access="remote" returnformat="JSON">
  <cfargument name="id" type="string" required="true">
    <cfset idValue=#deserializeJSON(arguments.id)#>
    <cfquery name="decrementquery">
      update OrderDetails
      set quantity=quantity-1
      where userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
        AND
        detailID=<cfqueryparam value=#idValue# cfsqltype="cf_sql_int" >
          AND
        quantity >= <cfqueryparam value=2 cfsqltype="cf_sql_int" >
    </cfquery>
    <cfquery name="getqueryof">
      select detailPrice, quantity from OrderDetails
      where
      detailID=<cfqueryparam value=#idValue# cfsqltype="cf_sql_int">
    </cfquery>
    <cfset var arrayToStoreQuery=arrayNew(1)>
      <cfset var arrayCall=totalPriceAndQty()>
        <cfloop query="getqueryof">
          <cfset stData=structNew()>
            <cfset stData.totalPrice=(#getqueryof.detailPrice# * #getqueryof.quantity#)>
                  <cfset stData.quantity=#getqueryof.quantity#>
                <cfset arrayAppend(arrayToStoreQuery,stData)>
                  <cfset stData.totalCart=arrayCall[1]>
                    <cfset stData.sum=arrayCall[2]>
        </cfloop>
    <cfset updateCartCount()>
      <cfreturn arrayToStoreQuery>
    </cffunction>



<!---<cffunction name="purchaseOrder" output="false" returnType="void" access="public">
  <cfquery name="purchasequery">
    update OrderDetails
    set status='progress'
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
      AND
      status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar">
  </cfquery>

  <cfquery name="insertquery">
    insert into Orders(userID)
    values(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">)
  </cfquery>
  <cfset session.cartCount=0>

</cffunction>--->
<!--- Modifying prevoius function--->
<cffunction name="purchaseOrder" output="false" returnType="void" access="public">
<cfargument name="addressID" type="numeric" required="true">
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

<!--- --->
<cftransaction >

  <cfif arguments.addressID GT 0>
  <cfquery name="insertquery" result="result">
    insert into Orders(userID,addressID)
    values(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
      <cfqueryparam value=#arguments.addressID# cfsqltype="cf_sql_int">)
  </cfquery>
  <cfelse>
<cfquery name="selectquery">
  select addressID from Address
  where
  userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
    AND
    addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
</cfquery>
    <cfquery name="insertquery" result="result">
      insert into Orders(userID,addressID)
      values(<cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">,
          <cfqueryparam value=#selectquery.addressID# cfsqltype="cf_sql_int">)

    </cfquery>

  </cfif>
  <cfset session.identityID=#result.identitycol#>
    </cftransaction>
  <!---<cfset session.cartCount=0>--->
<cfset updateCartCount()>
</cffunction>

<cffunction name="updateCartCount" output="false" access="public" returntype="void">
  <cfparam name="initValue" default=0>
  <cfquery name="countquery">
    select quantity from OrderDetails
    where
    userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
    and
    status=<cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar" >
  </cfquery>

<cfloop query="countquery">
  <cfset initValue=#initValue#+#countquery.quantity#>
</cfloop>
<cfset session.cartCount=initValue>
</cffunction>


<cffunction name="getAllBrand" output="false" access="remote" returntype="array" returnformat="JSON">
  <cfquery name="brandquery">
    select brandName from Brands
  </cfquery>
  <cfset var arrayToStoreQuery=arrayNew(1)>

  <cfloop query="brandquery">
    <cfset stData=structNew()>
            <cfset stData.brand="#brandquery.brandName#">
          <cfset arrayAppend(arrayToStoreQuery,stData)>
  </cfloop>
  <cfreturn arrayToStoreQuery>

</cffunction>
</cfcomponent>
