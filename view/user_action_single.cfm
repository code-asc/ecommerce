<!---
FileName      :user_action_single.cfm
Functionality : It will show the product details of single product
--->
<!DOCTYPE html>
<cfheader name="Expires" value="#Now()#">
    <cfheader name="pragma" value="no-change" />
    <cfheader name="cache-control" value="no-cache,no-store,must-revalidate" />

    <html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">


        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="/assets/css/transformEffect.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>


        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>

    <body>

        <cfif structKeyExists(url, "photoID") AND IsNumeric(#url.photoID#)>
            <cfinvoke method="deleteFromDatabase" component="Controller.adminData" photoID=#url.photoID#/>
            <cflocation url=#SESSION.previousURL# />
        </cfif>

        <cfif structKeyExists(url, "buyNow")>

            <cfinvoke method="getAddressInProductPage" component="Controller.addressEntry" returnvariable="addressquery">

                <cfinclude template="/view/header.cfm" />
                <div class="container-fluid">
                    <div class="col-md-4 col-sm-offset-2 col-xs-offset-4 ">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h4 class="panel-title">Shipping Details</h4>
                            </div>
                            <div class="panel-body">
                                <cfoutput>
                                    <cfif addressquery.recordCount GT 0>

                                        #addressquery.customerAddress1#
                                        <br/>
                                        <cfif len(trim(addressquery.customerAddress2))>
                                            #addressquery.customerAddress2#
                                            <br/>
                                        </cfif>
                                        #addressquery.customerCity#
                                        <br/> #addressquery.customerState#
                                        <br/> #addressquery.customerCountry#
                                        <br/>
                                        <cfelse>
                                            No Address Exists. Need to edit Address field
                                    </cfif>

                            </div>

                            <div class="text-center">
                                <a href="/view/payment.cfm?newAddress" class="btn btn-info"><i class="fa fa-pencil" aria-hidden="true"></i>&nbsp Edit</a>
                                <cfif addressquery.recordCount GT 0>
                                    <a href="/view/payment.cfm?newAddress&linkAddress" class="btn btn-primary">New Address</a>
                                    <button class="btn btn-success" id="onBuyNow">Proceed</button>
                                </cfif>

                            </div>
                        </div>
                    </div>
                </div>
                </cfoutput>
                <cfelse>
                    <cfinclude template="/view/header.cfm" />

                    <cfif structKeyExists(SESSION, "allowPreviousURL") AND SESSION.allowPreviousURL EQ true>
                        <cfset SESSION.previousURL=#SESSION.currentURL#>
                            <cfset SESSION.allowPreviousURL=false>
                    </cfif>

                    <cfset SESSION.currentURL=#cgi.SCRIPT_NAME#>
                        <cfset SESSION.currentURL=#replace(SESSION.currentURL, "/project_ecommerce/", "", "All")#>

                            <div class="container">
                              <cfif StructKeyExists(url, "productID") AND IsNumeric(#url.productID#)>
                                <cfset LOCAL.productQuery=createObject("component","Controller.retriveProduct")>
                                  <cfset LOCAL.retriveProduct=LOCAL.productQuery.getProducts(url.productID)>
                                    <cfif LOCAL.retriveProduct.recordCount GT 0>
                                        <cfif (structKeyExists(SESSION, "stLoggedInUser") AND SESSION.stLoggedInUser.userEmail EQ 'admin@admin.com') AND NOT LOCAL.retriveProduct.recordCount EQ 1>
                                            <cflocation url=#SESSION.previousURL# />
                                        </cfif>

                                        <cfset SESSION.currentURL=#SESSION.currentURL#& "?productID="&#LOCAL.retriveProduct.productID#>
                                            <cfset SESSION.productID=#LOCAL.retriveProduct.productID#>
                                                <!---<cfdump var="#SESSION.productID#">--->
                                                <cfoutput>
                                                    <div class="row">

                                                        <div class="col-md-4 col-sm-4 col-xm-4 col-lg-6" style="float:left">
                                                            <img src="#LOCAL.retriveProduct.largePhoto#" alt="image not found" class="img-responsive">
                                                        </div>

                                                        <div class="col-md-4 col-sm-4 col-xm-4 col-lg-4">
                                                            <h3>#LOCAL.retriveProduct.brandName# #LOCAL.retriveProduct.productName#</h3>
                                                            <cfif LOCAL.retriveProduct.discount GT 0>
                                                                <strike>Rs.#LOCAL.retriveProduct.unitPrice#</strike>
                                                                <strong>Rs.#LsNumberFormat(precisionEvaluate(LOCAL.retriveProduct.unitPrice-(LOCAL.retriveProduct.unitPrice*(LOCAL.retriveProduct.discount/100))),"0.00")#</strong>
                                                                <h4>(#LOCAL.retriveProduct.discount#% OFF)</h4> #LOCAL.retriveProduct.productName#
                                                                <cfelse>
                                                                    <strong>Rs.#LOCAL.retriveProduct.unitPrice#</strong>
                                                                    <br/> #LOCAL.retriveProduct.productName#
                                                            </cfif>
                                                            </p>
                                                            <strong class="label label-primary">Product Info</strong>
                                                            <br/> #LOCAL.retriveProduct.productDesc#
                                                            <cfif StructKeyExists(SESSION, "stLoggedInUser") AND SESSION.stLoggedInUser.userEmail EQ 'admin@admin.com'>
                                                                <h4>(Left :#LOCAL.retriveProduct.unitInStock#)</h4></cfif>
                                                            <br/>
                                                        </div>

                                                        <div class="col-md-3 col-sm-3 col-xm-3 col-lg-3">

                                                            <br/>
                                                            <cfif NOT StructKeyExists(SESSION, "stLoggedInUser")>
                                                                <button class="btn btn-success" disabled="true"><i class="fa fa-credit-card" aria-hidden="true"></i> &nbspBuy Now</button>

                                                                <button class="btn btn-info" id="onAddCart" disabled="true"><i class="fa fa-shopping-cart" aria-hidden="true"></i> &nbspAdd To Cart</button>
                                                                <cfelse>

                                                                    <!--- Condition for admin --->
                                                                    <cfif NOT SESSION.stLoggedInUser.userEmail EQ 'admin@admin.com'>
                                                                        <cfif LOCAL.retriveProduct.unitInStock GT 0>
                                                                            <a class="btn btn-success" href="/view/user_action_single.cfm?buyNow"><i class="fa fa-credit-card" aria-hidden="true"></i> &nbspBuy Now</a>
                                                                              <button class="btn btn-info" id="onAddCart"><i class="fa fa-shopping-cart" aria-hidden="true"></i> &nbspAdd To Cart</button>
                                                                            <cfelse>
                                                                                <button class="btn btn-warning" disabled="true">No Stock</button>

                                                                        </cfif>



                                                                        <cfelse>

                                                                            <a class="btn btn-primary" href="/view/adminProductEdit.cfm?productID=#url.productID#"><i class="fa fa-pencil" aria-hidden="true"></i> &nbspEdit</a>
                                                                            <a class="btn btn-danger" href="/view/user_action_single.cfm?photoID=#LOCAL.retriveProduct.photoID#"><i class="fa fa-trash" aria-hidden="true"></i> &nbspRemove</a>

                                                                    </cfif>
                                                            </cfif>

                                                        </div>

                                                        <div class="col-md-3 col-sm-3 col-xm-3 col-lg-4" id="infoAboutCart">
                                                        </div>

                                                </cfoutput>
                                                </div>

                                                <!---Similar Products --->

                                                <div class="row" style="margin-top:35px;margin-bottom:40px;border-top:1px solid #eaeaec">
                                                  <cfif LOCAL.retriveProduct.recordCount GT 0>
                                                    <cfset LOCAL.suggestProduct=LOCAL.productQuery.similarProducts(subCategoryID=#LOCAL.retriveProduct.subCategoryID#,productID=#LOCAL.retriveProduct.productID#)>

                                                    <cfif NOT isNull(LOCAL.suggestProduct)>
                                                        <h4>Similar Products</h4>

                                                        <cfoutput query="LOCAL.suggestProduct">
                                                            <div class="col-sm-3 col-md-3 col-xs-2">
                                                                <a href="/view/user_action_single.cfm?productID=#LOCAL.suggestProduct.productID#">
                                                                    <div class="itemthumb"> <img src="#LOCAL.suggestProduct.thumbNailPhoto#" class="img-responsive"></div>
                                                                </a>
                                                                <br/>
                                                                <strong style="color:black">#LOCAL.suggestProduct.brandName#</strong>
                                                                <br/>
                                                                <cfif LOCAL.retriveProduct.discount GT 0>
                                                                    <strike>Rs.#LOCAL.retriveProduct.unitPrice#</strike>
                                                                    <p><strong>Rs.#LsNumberFormat(precisionEvaluate(LOCAL.suggestProduct.unitPrice-(LOCAL.suggestProduct.unitPrice*(LOCAL.suggestProduct.discount/100))),"0.00")#</strong></p>
                                                                    <h5>(#LOCAL.retriveProduct.discount#% <i>Off</i>)<h5>
  <cfelse>
    <strong>Rs.#LOCAL.suggestProduct.unitPrice#</strong>
</cfif>
</div>
    </cfoutput>
</cfif>
</cfif>
</div>
<cfelse>
  <p>No product available</p>
</cfif>
</cfif>
</div>

<!--- --->

<div class="container-fluid">
<div class="row">
  <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12">
<cfinclude template="/view/footer.cfm" />
</div>
</div>
</div>
</cfif>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="/assets/script/autoSuggestion.js"></script>
    <script src="/assets/script/addCartAjax.js"></script>
    <script src="/assets/script/singleBuyAjax.js"></script>

  </body>
</html>
