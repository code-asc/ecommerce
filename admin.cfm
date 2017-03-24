<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>

    <!-- Bootstrap -->

    <!---<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>--->
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="./css/adminCSS.css">
  </head>
  <body>

<cfif structKeyExists(session, "stLoggedInUser")>

  <!---  <cfquery name="productquery">
      select Brands.brandName , Products.productID , Products.productName from Products
      inner join Brands
      on
      Brands.brandID=Products.brandID
    </cfquery>
--->
<cfinvoke component="adminDashBoard" method="highestSaleProduct" returnvariable="highestPopular" >
<cfinvoke component="adminDashBoard" method="countryStatus" returnvariable="countrySale">
<cfinvoke component="adminDashBoard" method="allDetails" returnvariable="stData" >
      <body>
        <cfinclude template="header.cfm">
          <cfinclude template="adminMenu.cfm">
        <div class="container-fluid">
      <!---    <cfinclude template="delete.cfm">--->

            <div class="col-md-8 col-sm-8">
              <div class="panel panel-primary">
                <div class="panel-heading">
                  <h4 class="panel-title">DashBoard</h4>
                </div>
                <div class="panel-body">

<div class="row">

<cfchart title="Most Purchased Brands" backgroundcolor="##FFFFFF" chartwidth="420">
  <cfchartseries type="pie"  query="highestPopular" itemcolumn="brandName" valuecolumn="total" />
</cfchart>

<cfchart title="Sale in Countries" backgroundcolor="##FFFFFF" chartwidth="421" >
<cfchartseries type="pie" query="countrySale" itemcolumn="customerCountry" valuecolumn="total"  />
</cfchart>
</div>

<div class="row text-center">
  <div class="col-md-3 col-sm-3 text-center colorBlue" id="customerInfo">
    <div class="col-sm-8 col-md-8">
  <cfoutput>
     <h3>#stData.customer#</h3>
     <h4>Registered</h4>
   </div>
     <div class="col-md-3 col-sm-3" id="iTagDiv">
       <span class="fa-stack fa-2x">
  <i class="fa fa-circle-thin fa-stack-2x setCircle"></i>

  <i class="fa fa-user fa-stack-1x setCircle"></i>
</span>

     </div>
  </cfoutput>
</div>

<div class="col-md-3 col-sm-3 text-center colorGreen" id="customerInfo">
  <div class="col-sm-8 cl-md-8">
<cfoutput>
   <h3>#stData.product#</h3>
   <h4>Products</h4>
 </div>
   <div class="col-md-2 col-sm-2" id="iTagDiv">
     <span class="fa-stack fa-2x">
<i class="fa fa-circle-thin fa-stack-2x setCircle"></i>

<i class="fa fa-file-text-o fa-stack-1x setCircle"></i>
</span>

   </div>
</cfoutput>
</div>

<div class="col-md-3 col-sm-3 text-center colorShip" id="customerInfo">
  <div class="col-sm-8 cl-md-8">
<cfoutput>
   <h3>#stData.shipping#</h3>
   <h4>shipping</h4>
 </div>
   <div class="col-md-2 col-sm-2" id="iTagDiv">
     <span class="fa-stack fa-2x">
<i class="fa fa-circle-thin fa-stack-2x setCircle"></i>

<i class="fa fa-truck fa-stack-1x setCircle"></i>
</span>

   </div>
</cfoutput>
</div>


<div class="col-md-4 col-sm-4">
<cfoutput>
  Total Category: #stData.category#<br/>
</cfoutput>
</div>

<div class="col-md-4 col-sm-4">
<cfoutput>
  Total SubCategory: #stData.subcategory#<br/>
</cfoutput>
</div>

<div class="col-md-4 col-sm-4">
<cfoutput>
  Total Supplier: #stData.supplier#<br/>
</cfoutput>
</div>




</div>

                </div>
              </div>
            </div>



        </div>
        <cfelse>
          <cflocation url="signin.cfm" />
    </cfif>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <script src="./script/adminEditAjax.js"></script>
  </body>
</html>
