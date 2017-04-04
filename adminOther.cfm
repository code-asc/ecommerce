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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

    <cfif structKeyExists(session, "stLoggedInUser") AND session.stLoggedInUser.userEmail EQ 'admin@admin.com'>

        <cfinclude template="header.cfm">
            <div class="container-fluid">
                <cfinclude template="adminMenu.cfm">

                    <div class="col-md-8 col-sm-8">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h4 class="panel-title">Add Other</h4>
                            </div>
                            <div class="panel-body">

                                <div class="row">
                                    <form id="formOtherBrand">
                                        <div class="col-sm-3 col-md-5 col-lg-5">
                                            <div class="form-group">
                                                <input class="form-control" name="brandName" id="brandName" type="text" required placeholder="BrandName">
                                            </div>
                                        </div>

                                        <div class="col-sm-5 col-md-5">
                                            <div class="form-group">
                                                <input class="btn btn-success" type="button" id="addBrand" name="addBrand" value="Add Brand">
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="row">
                                    <form id="formOtherCategory">
                                        <div class="col-sm-3 col-md-5 col-lg-5">
                                            <div class="form-group">
                                                <input class="form-control" name="category" id="category" type="text" required placeholder="Category">
                                            </div>
                                        </div>

                                        <div class="col-sm-5 col-md-5">
                                            <div class="form-group">
                                                <input class="btn btn-success" type="button" id="addCategory" name="addCategory" value="Add Category">
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div id="formOtherData">
                                </div>

                            </div>
                        </div>
                    </div>

                    <cfelse>
                        <cflocation url="signin.cfm" />
            </div>

    </cfif>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
    <script src="./script/adminValidate.js"></script>
    <script src="./script/adminOther.js"></script>
</body>

</html>
