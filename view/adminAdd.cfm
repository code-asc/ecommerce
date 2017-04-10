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

        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>

    <cfif structKeyExists(SESSION, "stLoggedInUser") AND SESSION.stLoggedInUser.userEmail EQ 'admin@admin.com'>
      <cfset LOCAL.productAddOption=createObject("component","Controller.getProductIDList")>
        <cfset LOCAL.categoryOption=LOCAL.productAddOption.getOnlyCategory()>
        <cfset LOCAL.brandOption=LOCAL.productAddOption.getOnlyBrand()>
          <cfset LOCAL.shippingOption=LOCAL.productAddOption.getOnlyShipping()>
            <cfset LOCAL.supplierOption=LOCAL.productAddOption.getOnlySupplier()>

        <body>
            <cfinclude template="/view/header.cfm">
                <div class="container-fluid">
                    <cfinclude template="/view/adminMenu.cfm">

                        <div class="col-md-8 col-sm-8">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Add Item</h4>
                                </div>
                                <div class="panel-body">

                                    <cfform id="formOption">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <cfinput class="form-control" name="productName" id="productName" type="text" required placeholder="Product Name">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <select name="brand" id="brand" class="form-control" form="formOption">
                                                    <option selected disabled>Brand</option>
                                                    <cfoutput query="LOCAL.brandOption">
                                                        <option value=#LOCAL.brandOption.brandID#>#LOCAL.brandOption.BrandName#</option>
                                                    </cfoutput>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <select name="category" id="category" class="form-control" form="formOption">
                                                    <option selected disabled>Category Type</option>
                                                    <cfoutput query="LOCAL.categoryOption">
                                                        <option value=#LOCAL.categoryOption.categoryID#>#LOCAL.categoryOption.categoryType#</option>
                                                    </cfoutput>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <select name="shipping" id="shipping" class="form-control" form="formOption">
                                                    <option selected disabled>Shipping</option>
                                                    <cfoutput query="LOCAL.shippingOption">
                                                        <option value=#LOCAL.shippingOption.shippingID#>#LOCAL.shippingOption.companyName#</option>
                                                    </cfoutput>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <select name="supplier" id="supplier" class="form-control" form="formOption">
                                                    <option selected disabled>Supplier</option>
                                                    <cfoutput query="LOCAL.supplierOption">
                                                        <option value=#LOCAL.supplierOption.supplierID#>#LOCAL.supplierOption.supplierName#</option>
                                                    </cfoutput>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <select name="subcategory" id="subcategory" class="form-control" form="formOption">
                                                    <option selected disabled>SubCategory Type</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2 col-sm-2">
                                            <div class="form-group">
                                                <cfinput class="form-control" name="price" id="price" type="text" required placeholder="Price">
                                            </div>
                                        </div>

                                        <div class="col-md-2 col-sm-2">
                                            <div class="form-group">
                                                <cfinput class="form-control" name="quantity" id="quantity" type="text" required placeholder="Quantity">
                                            </div>
                                        </div>

                                        <div class="col-md-2 col-sm-2">
                                            <div class="form-group">
                                                <cfinput class="form-control" name="discount" id="discount" type="text" required placeholder="Discount">
                                            </div>
                                        </div>

                                        <div class="col-md-2 col-sm-2">
                                            <div class="form-group">
                                                <cfinput class="form-control" name="rating" id="rating" type="text" required placeholder="Rating">
                                            </div>
                                        </div>



                                        <div class="form-group">
                                            <cfinput type="file" name="thumbNail" id="thumbNail" class="file" style="visibility: hidden ; position:absolute">
                                                <div class="input-group col-sm-5 col-md-5" style="margin-left:17px">

                                                    <input type="text" id="thumbNailText" class="form-control input-md" disabled placeholder="Upload ThumbNail Image">
                                                    <span class="input-group-btn">
       <button class="browse btn btn-primary input-md" type="button"><i class="glyphicon glyphicon-search"></i> Browse</button>
     </span>
                                                </div>
                                        </div>

                                        <div class="col-md-12 col-sm-12">
                                            <div class="form-group">
                                                <cfinput class="form-control" name="thumbNailType" id="thumbNailType" type="text" required placeholder="ThumbNail Type">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <cfinput type="file" name="largePhoto" id="largePhoto" class="file" style="visibility: hidden ; position:absolute">
                                                <div class="input-group col-sm-5 col-md-5" style="margin-left:17px">

                                                    <input type="text" id="largePhotoText" class="form-control input-md" disabled placeholder="Upload Large Image">
                                                    <span class="input-group-btn">
       <button class="browse btn btn-primary input-md" type="button"><i class="glyphicon glyphicon-search"></i> Browse</button>
     </span>
                                                </div>
                                        </div>

                                        <div class="col-md-6 col-sm-6">
                                            <div class="form-group">
                                                <cfinput class="form-control" name="largePhotoType" id="largePhotoType" type="text" required placeholder="LargePhoto Type">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <cftextarea class="form-control" name="productDesc" id="productDesc" placeholder="productDesc" required />
                                        </div>

                                        <div class="text-center">
                                            <div class="form-group">
                                                <cfinput class="btn btn-primary" type="button" name="submitData" value="Add Product">
                                            </div>
                                        </div>
                                    </cfform>

                                    <div id="formData">
                                    </div>

                                </div>
                            </div>
                        </div>

                </div>
                <cfelse>
                    <cflocation url="/view/signin.cfm" />
    </cfif>

    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="/assets/script/adminAddMenu.js"></script>
    <script src="/assets/script/getSubCategoryAjax.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
    <script src="/assets/script/adminValidate.js"></script>
    <script src="/assets/script/uploadImage.js"></script>
    <script src="/assets/script/autoSuggestion.js"></script>
    </body>

    </html>
