<!DOCTYPE html>
<cfheader name="Expires" value="#Now()#">
    <cfheader name="pragma" value="no-change" />
    <cfheader name="cache-control" value="no-cache,no-store,must-revalidate" />
    <html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title></title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>

    <body>

        <cfif StructKeyExists(session, "stLoggedInUser")>

            <cfif structKeyExists(url, "removeFromCart")>
                <cfinvoke component="authentication" method="removeItemFromCart" cartID=#url.removeFromCart#>
                    <cfset structDelete(url, "removeFromCart")>
            </cfif>

            <cfif structKeyExists(url, "buyAll")>
                <!---  <cfinvoke component="authentication" method="purchaseOrder"> --->
                <cflocation url="addressConfirm.cfm" addtoken="false" />
            </cfif>

            <cfinclude template="header.cfm">
                <cfparam name="total" default=0>
                    <div class="container">
                        <cfif structKeyExists(session, "stLoggedInUser")>
                            <cfquery name="retrivecart">
                                select Brands.brandName,OrderDetails.detailProductID,OrderDetails.quantity,Products.supplierID,OrderDetails.detailID,ProductPhoto.thumbNailPhoto,Products.afterDiscount,Products.productName,OrderDetails.supplierID,Supplier.supplierName,OrderDetails.status from OrderDetails inner join Products on Products.productID=OrderDetails.detailProductID inner join ProductPhoto on Products.photoID=ProductPhoto.photoID inner join Supplier on Products.supplierID=Supplier.supplierID inner join Brands on Products.brandID=Brands.brandID where OrderDetails.userID=
                                <cfqueryparam value=#session.stLoggedInUser.userID# cfsqltype="cf_sql_int">
                                    AND OrderDetails.status=
                                    <cfqueryparam value="addedToCart" cfsqltype="cf_sql_varchar">
                            </cfquery>

                            <!---<cfdump var="#retrivecart#">--->

                            <cfif retrivecart.recordCount GT 0>
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xm-12 col-lg-12">
                                        <h3 class="text-muted">My Shopping bag
        <!---(<cfoutput>#session.cartCount#</cfoutput> items)--->
      </h3>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-5 col-md-5 col-xs-5 col-lg-5">
                                        <cfoutput query="retrivecart">
                                            <!---Calucating price --->
                                            <cfset total=#total#+(#retrivecart.afterDiscount# * #retrivecart.quantity# )>
                                                <!--- --->

                                                <div class="col-sm-12 col-md-12 col-xs-12 col-lg-12 well well-sm">

                                                    <div class="col-sm-6 col-md-6 col-xs-6 col-lg-4">
                                                        <img src="#retrivecart.thumbNailPhoto#" class="img-responsive">
                                                    </div>

                                                    <div class="col-sm-6 col-md-6 col-xs-12 col-lg-6">
                                                        <cfset totalPrice=#retrivecart.afterDiscount#*#retrivecart.quantity#>
                                                            <cfset totalQuantityPrice=#retrivecart.detailID#& "paraID">
                                                                <cfset eachPrice=#retrivecart.detailID#& "eachPrice">
                                                                    <h4>#retrivecart.brandName# #retrivecart.productName#</h4>
                                                                    <p>Sold by:<strong>#retrivecart.supplierName#</strong></p>
                                                                    <p class="#retrivecart.detailID#">Price(each):Rs.<strong><span id=#eachPrice#>#retrivecart.afterDiscount#</span></strong></p>
                                                                    <p id="#totalQuantityPrice#">Total:Rs.<strong>#totalPrice#</strong></p>
                                                                    <button value="#retrivecart.detailID#" class="increment"><i class="fa fa-plus" aria-hidden="true"></i></button>&nbsp Qty:<strong><p id="#retrivecart.detailID#" style="display:inline">#retrivecart.quantity#</p></strong>&nbsp
                                                                    <button value="#retrivecart.detailID#" class="decrement"><i class="fa fa-minus" aria-hidden="true"></i></button>
                                                                    <br/>
                                                                    <br/>
                                                                    <a href="userCart.cfm?removeFromCart=#retrivecart.detailID#" class="btn btn-warning"><i class="fa fa-trash" aria-hidden="true"></i>&nbsp Remove From Bag</a>

                                                    </div>

                                                </div>

                                        </cfoutput>
                                    </div>

                                    <cfoutput>
                                        <div class="col-md-4 col-sm-4 col-xm-12 col-lg-4 alert alert-info">
                                            <h5 class="text-muted"> PRICE DETAILS:</h5>
                                            <h6 class="text-success">Bag Total : Rs.<span id="totalPriceAll">#total#</span></h6>
                                            <a class="btn btn-success" href="userCart.cfm?buyAll">Place Order</a>
                                        </div>
                                    </cfoutput>

                                </div>
                                <cfelse>
                                    <div class="col-xs-8 col-md-8 col-lg-8 col-sm-8">
                                        <div class="alert alert-warning">
                                            Your bag is empty

                                        </div>
                            </cfif>

                            <cfelse>
                                <div class="alert alert-warning">
                                    Need to SignIn

                                </div>

                        </cfif>
                        </div>

                        <cfelse>
                            <cflocation url="signin.cfm" />
        </cfif>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="./script/autoSuggestion.js"></script>
        <script src="./script/deleteCartAjax.js"></script>
        <script src="./script/incrementCart.js"></script>
        <script src="./script/decrementCart.js"></script>
    </body>

    </html>
