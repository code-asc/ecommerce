<!---
FileName      :searchPage.cfm
Functionality : It will retrive the product based on brand search
--->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/assets/css/panel.css">
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

    <cfinclude template="/common/header.cfm" />

    <cfset SESSION.currentURL=#CGI.SCRIPT_NAME#>
    <cfset SESSION.currentURL=#replace(SESSION.currentURL, "/project_ecommerce/", "", "All")#>
    <cfset SESSION.currentURL=#SESSION.currentURL#& "?brand="&#URL.brand#>
    <cfset LOCAL.searchProductInfo=createObject("component","Controller.retriveProduct")>
        <cfif structKeyExists(URL, "brand")>
           <cfset LOCAL.retriveProduct=LOCAL.searchProductInfo.productsForSearchPage(URL.brand)>
        <cfelse>
          <cfset LOCAL.retriveProduct=LOCAL.searchProductInfo.productsForSearchPage()>
        </cfif>

      <cfif LOCAL.retriveProduct.recordCount GT 0>
         <cfset LOCAL.retriveBrand=LOCAL.searchProductInfo.getProductBrand(LOCAL.retriveProduct.subCategoryID)>
      <cfelse>
        <cfset LOCAL.retriveBrand=LOCAL.searchProductInfo.getProductBrand(0)>
      </cfif>

                <div class="container-fluid">
                    <div class="row">
                      <cfif LOCAL.retriveProduct.recordCount GT 0>
                        <form>
                            <div class="col-md-2 col-sm-2 col-xm-2 col-lg-2" style="margin-bottom:200px">
                                <div class="panel panel-primary behclick-panel" style="margin-bottom:500px">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><i class="fa fa-filter" aria-hidden="true"></i>&nbspFilter By</h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="panel-heading">
                                            <h4 class="panel-title"><a href="#collapse0" data-toggle="collapse"><i class="fa fa-caret-down" aria-hidden="true"></i>&nbsp Brand</a></h4>
                                        </div>
                                        <div id="collapse0" class="panel-collapse collapse in">
                                            <cfoutput query="LOCAL.retriveBrand">
                                                <cfset brand=#LOCAL.retriveBrand.brandID#>
                                                    <ul class="list-group">
                                                        <li class="list-group-item">
                                                            <div class="checkbox">
                                                                <label>
                                                                    <input type="checkbox" value='#brand#' name="checkBrand" class="checkBrand"> #LOCAL.retriveBrand.brandName#
                                                                </label>
                                                            </div>
                                                        </li>
                                                    </ul>
                                            </cfoutput>
                                        </div>

                                        <div class="panel-heading">
                                            <h4 class="panel-title"><a href="#collapse1" data-toggle="collapse"><i class="fa fa-caret-down" aria-hidden="true"></i>&nbsp Discount</a></h4>
                                        </div>
                                        <div id="collapse1" class="panel-collapse collapse in">

                                            <ul class="list-group">
                                                <li class="list-group-item">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" value='10' name="checkDiscount" class="checkDiscount"> Flat 10%
                                                        </label>
                                                    </div>
                                                </li>
                                                <li class="list-group-item">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" value='40' name="checkDiscount" class="checkDiscount"> Flat 40%
                                                        </label>
                                                    </div>
                                                </li>
                                                <li class="list-group-item">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" value='50' name="checkDiscount" class="checkDiscount"> Flat 50%
                                                        </label>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>


                                    </div>
                                </div>
                            </div>

                        </form>

                        <div id="filterTarget">
                            <cfloop query="LOCAL.retriveProduct">
                                <cfoutput>

                                    <div class="col-sm-3 col-md-3 col-xm-3 col-lg-3" style="float : left">

                                        <a href="/view/user_action_single.cfm?productID=#LOCAL.retriveProduct.productID#">
                                            <div class="itemthumb"><img src="#LOCAL.retriveProduct.thumbNailPhoto#" class="img-responsive"></div>
                                        </a>
                                        <br/>
                                        <strong>#LOCAL.retriveProduct.brandName#</strong>
                                        <p>
                                            <cfif LOCAL.retriveProduct.discount GT 0>
                                                <strike>Rs.#LOCAL.retriveProduct.unitPrice#</strike>
                                                <strong>Rs.#LsNumberFormat(precisionEvaluate(LOCAL.retriveProduct.unitPrice-(LOCAL.retriveProduct.unitPrice*(LOCAL.retriveProduct.discount/100))),"0.00")#</strong>
                                                <h5>(#LOCAL.retriveProduct.discount#% <i>Off</i>)<h5>
        <span class="label label-info">#LOCAL.retriveProduct.productName#</span>
        <cfelse>
          <strong>Rs.#LOCAL.retriveProduct.unitPrice#</strong>
          <div class="label label-success">#LOCAL.retriveProduct.productName#</div>
      </cfif></p>

  </div>
</cfoutput>
</cfloop>
</div>
</div>
<cfelse>
<cfinclude template="/common/productNotFound.cfm"/>
</cfif>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12">
          <cfcache action="cache" timespan="#createTimespan(0,14,0,0)#" >
            <cfinclude template="/common/footer.cfm" />
          </cfcache>
        </div>
    </div>
</div>


    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <!---<script src="./script/singleSelectOption.js"></script>--->

    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="/assets/script/categorySearchAjax.js"></script>
    <script src="/assets/script/autoSuggestion.js"></script>
  </body>
</html>
