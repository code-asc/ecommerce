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
      <link rel="stylesheet" href="./css/panel.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
<cfinclude template="header.cfm"/>

<cfif structKeyExists(url,"subCategoryID")>
<cfset session.subCategoryID=#url.subCategoryID#>
</cfif>

<!---<cfif structKeyExists(form,"checkBrand")>
<cfdump var="#form.checkBrand#">
</cfif>--->


<div class="container-fluid">
<div class="row">
  <cfquery name="retriveProduct">
    select Products.productID , Products.productName ,Products.productDesc ,Products.unitPrice ,ProductPhoto.thumbNailPhoto ,Products.discount ,Brands.brandName from Products
    inner join ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    inner join Brands
    on
    Products.brandID=Brands.brandID
    where Products.subCategoryID=<cfqueryparam value="#session.subCategoryID#" cfsqltype="cf_sql_integer">
<cfif structKeyExists(form,"checkBrand")>
<cfoutput>
      AND
      Brands.brandID IN (#form.checkBrand#)
        </cfoutput>
      </cfif>

      <cfif structKeyExists(url,"checkBrand")>
      <cfoutput>
            AND
            Brands.brandID IN (#url.checkBrand#)
              </cfoutput>
            </cfif>

      <cfif structKeyExists(form,"checkDiscount")>
      <cfoutput>
            AND
            Products.discount IN (<cfqueryparam value=#form.checkDiscount# list="true" cfsqltype="cf_sql_decimal">)
              </cfoutput>
            </cfif>
  </cfquery>

  <cfquery name="retriveBrand">
    select DISTINCT Brands.brandName,Brands.brandID from Products
    inner join ProductPhoto
    on
    Products.photoID=ProductPhoto.photoID
    inner join Brands
    on
    Products.brandID=Brands.brandID
    where Products.subCategoryID=<cfqueryparam value="#session.subCategoryID#" cfsqltype="cf_sql_integer">
      ORDER BY Brands.brandName ASC

  </cfquery>



<form>
<div class="col-md-2 col-sm-2 col-xm-2 col-lg-2">
  <div class="panel panel-primary behclick-panel">
    <div class="panel-heading">
      <h4 class="panel-title"><i class="fa fa-filter" aria-hidden="true"></i>&nbspFilter By</h4>
    </div>
    <div class="panel-body">
      <div class="panel-heading">
        <h4 class="panel-title"><a href="#collapse0" data-toggle="collapse"><i class="fa fa-caret-down" aria-hidden="true"></i>&nbsp Brand</a></h4>
    </div>
    <div id="collapse0" class="panel-collapse collapse in" >
      <cfoutput query="retriveBrand">
<cfset brand=#retriveBrand.brandID#>
    						<ul class="list-group">
    							<li class="list-group-item">
    								<div class="checkbox">
    									<label>
    										<input type="checkbox" value='#brand#' name="checkBrand" class="checkBrand">
    										#retriveBrand.brandName#
    									</label>
    								</div>
    							</li>
                </ul>
              </cfoutput>
    </div>

    <div class="panel-heading">
      <h4 class="panel-title"><a href="#collapse1" data-toggle="collapse"><i class="fa fa-caret-down" aria-hidden="true"></i>&nbsp Discount</a></h4>
    </div>
    <div id="collapse1" class="panel-collapse collapse in" >

              <ul class="list-group">
                <li class="list-group-item">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" value='10' name="checkDiscount" class="checkDiscount">
                       Flat 10%
                    </label>
                  </div>
                </li>
                <li class="list-group-item">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" value='40' name="checkDiscount" class="checkDiscount">
                       Flat 40%
                    </label>
                  </div>
                </li>
                <li class="list-group-item">
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" value='50' name="checkDiscount" class="checkDiscount">
                       Flat 50%
                    </label>
                  </div>
                </li>
              </ul>

    </div>




    <input type="button" name="submit" value="apply" class="btn btn-info" id="loadFilter">
  </div>
</div>
</div>


</form>

<div id="filterTarget">
<cfloop query="retriveProduct">
  <cfoutput>

  <div class="col-sm-3 col-md-3 col-xm-3 col-lg-3" style="float : left" >

      <a href="user_action_single.cfm?productID=#retriveProduct.productID#"> <img src="#retriveProduct.thumbNailPhoto#"  class="img-responsive"></a>
      <br/>
      <strong>#retriveProduct.brandName#</strong>
      <p><cfif retriveProduct.discount GT 0>
        <strike>Rs.#retriveProduct.unitPrice#</strike>
        <strong>Rs.#LsNumberFormat(precisionEvaluate(retriveProduct.unitPrice-(retriveProduct.unitPrice*(retriveProduct.discount/100))),"0.00")#</strong>
        <h5>(#retriveProduct.discount#% <i>Off</i>)<h5>
        <span class="label label-info">#retriveProduct.productName#</span>
        <cfelse>
          <strong>Rs.#retriveProduct.unitPrice#</strong>
          <div class="label label-success">#retriveProduct.productName#</div>
      </cfif></p>

  </div>
</cfoutput>
</cfloop>
</div>
</div>
</div>
<!---<cfoutput>
  #url.subCategoryType#
  <br/>
  #url.subCategoryID#
</cfoutput>--->


    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <!---<script src="./script/singleSelectOption.js"></script>--->
    <script src="./script/categoryAjax.js"></script>
  </body>
</html>
