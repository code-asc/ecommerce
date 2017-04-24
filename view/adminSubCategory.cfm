<!---
FileName      :adminSubCategory.cfm
Functionality : It will allow the admin to add the new subcategory
--->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>


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
</head>

<body>

    <cfif structKeyExists(SESSION, "stLoggedInUser") AND SESSION.stLoggedInUser.userRole EQ "admin">
      <cfset LOCAL.productAddOption=createObject("component","Controller.getProductIDList")>
        <cfif structKeyExists(form, "submitEdit") AND StructKeyExists(form, "products")>
            <cfinvoke component="Controller.adminData" method="editProduct" productID=#form.products# productDesc="#form.productDesc#" unitPrice=#form.unitPrice# unitInStock=#form.unitInStock# discount=#form.discount# thumbNailPhoto="#form.thumbNailPhoto#" largePhoto="#form.largePhoto#" />
        </cfif>
        <cfset LOCAL.categoryOption=LOCAL.productAddOption.getOnlyCategory()>

        <body>
            <cfinclude template="/common/header.cfm">
                <div class="container-fluid">
                    <cfinclude template="/view/adminMenu.cfm">

                        <div class="col-md-8 col-sm-8">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Add SubCategory</h4>
                                </div>
                                <div class="panel-body">

                                    <form id="formAddSubCategory" class="formAddSubCategory" name="formAddSubCategory" method="POST">

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <select name="category" id="category" class="form-control" form="formAddSubCategory">
                                                    <option selected disabled>select Category</option>
                                                    <cfoutput query="LOCAL.categoryOption">
                                                        <option value=#LOCAL.categoryOption.categoryID#>#LOCAL.categoryOption.categoryType#</option>
                                                    </cfoutput>
                                                </select>
                                            </div>
                                        </div>



                                        <div class="col-md-6">
                                            <div class="form-group">
                                          <input type="text" class="form-control" name="subcategory" id="subcategory">
                                            </div>
                                        </div>



                                        <div class="col-sm-6 col-md-6">
                                            <div class="form-group">
                                                <input class="btn btn-primary" type="button" name="addSubCategory" value="Save" id="addSubCategory">
                                            </div>
                                        </div>
                                    </form>

                                    <div class="col-sm-12 col-md-12 col-xs-12 col-lg-12">
                                    <div id="formDataStatusShow">
                                    </div>
                                  </div>

                                  <div class="col-sm-12 col-md-12 col-xs-12 col-lg-12">
                                  <div id="subCategoryList">
                                    <table class="table-bordered table-condensed table-responsive col-md-6 col-lg-6 col-sm-12 col-xs-12" id="subCategoryListTable">

                                    </table>
                                  </div>
                                </div>

                                </div>
                            </div>
                        </div>


                </div>
                <cfelse>
                    <cflocation url="/view/signin.cfm" />
    </cfif>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
    <script src="/assets/script/adminValidate.js"></script>
    <script src="/assets/script/subCategoryList.js"></script>
    <script src="/assets/script/adminAddSubcategoryAJAX.js"></script>

    </body>

</html>
