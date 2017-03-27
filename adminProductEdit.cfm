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


<!---<cfoutput>
  #url.productID#
</cfoutput> --->

<cfif StructKeyExists(session,"stLoggedInUser") AND session.stLoggedInUser.userEmail EQ 'admin@admin.com'>

<cfif structKeyExists(url,"productID")>
<cfset session.productID=#url.productID#>
  <cfdump var=#session.productID#>
</cfif>

<cfinclude template="header.cfm" />

<cfset session.currentURL=#cgi.SCRIPT_NAME#>
  <cfset session.currentURL=#replace(session.currentURL,"/project_ecommerce/","","All")#>

<!---  <cfset responseAfterSubmit=false>
    <cfif structKeyExists(form, "submitEdit")>
    <cfinvoke component="adminData" method="editProduct" productID=#session.productID# productDesc="#form.productDesc#" unitPrice=#form.unitPrice# unitInStock=#form.stock# discount=#form.discount# thumbNailPhoto="#form.thumbNailPhoto#" largePhoto="#form.largePhoto#"/>
    <cfset responseAfterSubmit=true>
    <cfset structDelete(form,"submitEdit")>
    </cfif>--->


<div class="container">
  <cfinvoke component="adminData" method="getProductBasedOnID" productID=#session.productID# returnvariable="retriveProduct" >
  <cfset session.currentURL=#session.currentURL#&"?productID="&#retriveProduct.productID#>

<!---<cfdump var="#session.productID#">--->
<cfoutput>
  <div class="row">

    <div class="col-md-4 col-sm-4 col-xm-4 col-lg-6" style="float:left">
    <img src="#retriveProduct.largePhoto#" alt="image not found" class="img-responsive">
  </div>

<form method="POST" action="adminProductEdit.cfm" name="editProductAdmin" id="editProductAdmin">

  <div class="col-md-4 col-sm-4 col-xm-4 col-lg-4">
    <h3>#retriveProduct.brandName# #retriveProduct.productName#</h3>

    <div class='col-sm-4 col-md-4'>
      <div class='form-group'>
      <label for='Category'>CategoryID</label>
      <input class='form-control' form='editProductAdmin' id='category' name='category' type='text' value="#retriveProduct.categoryID#" disabled>
    </div>
    </div>

    <div class='col-sm-4 col-md-4'>
      <div class='form-group'>
      <label for='SubCategory'>SubCategoryID</label>
      <input class='form-control' form='editProductAdmin' id='subCategory' name='subCategory' type='text' value="#retriveProduct.subCategoryID#" disabled>
    </div>
    </div>

    <div class='col-sm-4 col-md-4'>
      <div class='form-group'>
      <label for='ProductID'>ProductID</label>
      <input class='form-control' form='editProductAdmin' id='productID' name='productID' type='text' value="#retriveProduct.productID#" disabled>
    </div>
    </div>

    <div class='col-sm-12 col-md-12'>
      <div class='form-group'>
      <label for='thumbNailPhoto'>ThumbNail Path</label>
      <input class='form-control' form='editProductAdmin' id='thumbNailPhoto' name='thumbNailPhoto' type='text' value="#retriveProduct.thumbNailPhoto#">
    </div>
  </div>

  <div class='col-sm-12 col-md-12'>
    <div class='form-group'>
    <label for='largePhoto'>largePhoto Path</label>
    <input class='form-control' form='editProductAdmin' id='largePhoto' name='largePhoto' type='text' value="#retriveProduct.largePhoto#">
  </div>
</div>

<div class='col-sm-4 col-md-4'>
  <div class='form-group'>
  <label for='unitPrice'>Price</label>
  <input class='form-control' form='editProductAdmin' id='unitPrice' name='unitPrice' type='text' value="#retriveProduct.unitPrice#">
</div>
</div>

<div class='col-sm-4 col-md-4'>
  <div class='form-group'>
  <label for='stock'>Stock</label>
  <input class='form-control' form='editProductAdmin' id='stock' name='stock' type='text' value="#retriveProduct.unitInStock#">
</div>
</div>

<div class='col-sm-4 col-md-4'>
  <div class='form-group'>
  <label for='discount'>Discount</label>
  <input class='form-control' form='editProductAdmin' id='discount' name='discount' type='text' value="#retriveProduct.discount#">
</div>
</div>


<div class='col-sm-12 col-md-12'>
  <div class='form-group'>
    <textarea class='form-control' form='editProductAdmin' name='productDesc' id='productDesc' rows='5' cols='42'>#retriveProduct.productDesc#</textarea>
  </div>
</div>



<!--- Condition for admin --->

<cfif  session.stLoggedInUser.userEmail EQ 'admin@admin.com'>

<!---<div class="col-md-3 col-sm-3 col-xm-3 col-lg-3">
<input type="submit"  class="btn btn-success" value="Save" name="submitEdit" id="subitAlert">
</div>--->

<div class="col-md-3 col-sm-3 col-xm-3 col-lg-3">
<input type="button"  class="btn btn-success" value="Save" name="submitEditProduct">
</div>

<div class="col-md-3 col-sm-3 col-xm-3 col-lg-3">
<input type="reset" class="btn btn-danger" value="Reset" name="reset">
</div>
    </cfif>

</form>

<div class='row'>
  <div class="col-md-12 col-sm-12 col-xm-12 col-lg-12" id="infoAboutEdit">

  </div>
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

<cfelse>
  <cflocation url="signin.cfm" />
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
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
    <script src="./script/adminValidate.js"></script>
    <script src="./script/adminSearchAndEditAjax.js"></script>
  </body>
</html>
