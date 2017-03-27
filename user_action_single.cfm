<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>

<cfif structKeyExists(url,"buyNow")>
<!---<cfoutput>
  #url.productID#
</cfoutput> --->
<cfquery name="addressquery">
  select Address.customerAddress1,Address.customerAddress2,Address.customerCity,Address.customerState,Address.customerCountry from Address
  where
  userID=<cfqueryparam value=#session.stLoggedInUser.userID# cfsqlType="cf_sql_int">
  AND
  addressType=<cfqueryparam value="default" cfsqltype="cf_sql_varchar">
</cfquery>

<cfinclude template="header.cfm"/>
<div class="container-fluid">
  <div class="col-md-4 col-sm-offset-2 col-xs-offset-4 ">
    <div class="panel panel-info">
      <div class="panel-heading">
        <h4 class="panel-title">Shipping Details</h4>
      </div>
      <div class="panel-body">
        <cfoutput>
        <cfif addressquery.recordCount GT 0>

          #addressquery.customerAddress1#<br/>
          <cfif len(trim(addressquery.customerAddress2))>
          #addressquery.customerAddress2#<br/>
        </cfif>
          #addressquery.customerCity#<br/>
          #addressquery.customerState#<br/>
          #addressquery.customerCountry#<br/>
          <cfelse>
            No Address Exists. Need to edit Address field
        </cfif>



      </div>

<div class="text-center">
      <a href="payment.cfm?newAddress" class="btn btn-info"><i class="fa fa-pencil" aria-hidden="true"></i>&nbsp Edit</a>
      <cfif addressquery.recordCount GT 0>
        <a href="payment.cfm?newAddress&linkAddress" class="btn btn-primary">New Address</a>
        <button  class="btn btn-success" id="onBuyNow">Proceed</button>
      </cfif>

</div>
    </div>
  </div>
</div>
</cfoutput>
<cfelse>
<cfinclude template="header.cfm" />

<cfset session.currentURL=#cgi.SCRIPT_NAME#>
  <cfset session.currentURL=#replace(session.currentURL,"/project_ecommerce/","","All")#>

<div class="container">
  <cfquery name="retriveProduct">
    select  Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice,Products.unitInStock ,ProductPhoto.largePhoto ,Products.discount ,Brands.brandName from Products
    inner join ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    inner join Brands
    on
    Products.brandID=Brands.brandID
    where Products.productID=<cfqueryparam value="#url.productID#" cfsqltype="cf_sql_integer">

  </cfquery>
  <cfset session.currentURL=#session.currentURL#&"?productID="&#retriveProduct.productID#>
<cfset session.productID=#retriveProduct.productID#>
<!---<cfdump var="#session.productID#">--->
<cfoutput>
  <div class="row">

    <div class="col-md-4 col-sm-4 col-xm-4 col-lg-6" style="float:left">
    <img src="#retriveProduct.largePhoto#" alt="image not found" class="img-responsive">
  </div>

  <div class="col-md-4 col-sm-4 col-xm-4 col-lg-4">
    <h3>#retriveProduct.brandName# #retriveProduct.productName#</h3>
    <cfif retriveProduct.discount GT 0>
      <strike>Rs.#retriveProduct.unitPrice#</strike>
      <strong>Rs.#LsNumberFormat(precisionEvaluate(retriveProduct.unitPrice-(retriveProduct.unitPrice*(retriveProduct.discount/100))),"0.00")#</strong>
      <h4>(#retriveProduct.discount#% OFF)</h4>

      #retriveProduct.productName#
      <cfelse>
        <strong>Rs.#retriveProduct.unitPrice#</strong>
        <br/>
        #retriveProduct.productName#
    </cfif></p>
    <strong class="label label-primary">Product Info</strong>
    <br/>
    #retriveProduct.productDesc#
    <br/>
  </div>

  <div class="col-md-3 col-sm-3 col-xm-3 col-lg-3">

    <br/>
    <cfif NOT StructKeyExists(session, "stLoggedInUser")>
    <button class="btn btn-success" disabled="true"><i class="fa fa-credit-card" aria-hidden="true"></i> &nbspBuy Now</button>

    <button class="btn btn-info" id="onAddCart" disabled="true"><i class="fa fa-shopping-cart" aria-hidden="true"></i> &nbspAdd To Cart</button>
    <cfelse>

<!--- Condition for admin --->
<cfif NOT session.stLoggedInUser.userEmail EQ 'admin@admin.com'>
      <cfif retriveProduct.unitInStock GT 0>
      <a class="btn btn-success" href="user_action_single.cfm?buyNow"><i class="fa fa-credit-card" aria-hidden="true"></i> &nbspBuy Now</a>
      <cfelse>
        <button class="btn btn-warning" disabled="true">No Stock</button>
    </cfif>
      <button class="btn btn-info" id="onAddCart"><i class="fa fa-shopping-cart" aria-hidden="true"></i> &nbspAdd To Cart</button>

<cfelse>

  <a class="btn btn-primary" href="adminProductEdit.cfm?productID=#url.productID#"><i class="fa fa-pencil" aria-hidden="true"></i> &nbspEdit</a>
  <a class="btn btn-danger" href=""><i class="fa fa-trash" aria-hidden="true"></i> &nbspRemove</a>
    </cfif>
</cfif>

  </div>

  <div class="col-md-3 col-sm-3 col-xm-3 col-lg-4" id="infoAboutCart">
  </div>

</cfoutput>
</div>

<div class="container-fluid">
<div class="row">
  <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12">
<cfinclude template="footer.cfm" />
</div>
</div>
</div>
</cfif>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="./script/autoSuggestion.js"></script>
    <script src="./script/addCartAjax.js"></script>
    <script src="./script/singleBuyAjax.js"></script>
  </body>
</html>
