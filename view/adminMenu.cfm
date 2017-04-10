<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  
    <link rel="stylesheet" href="/assets/css/adminCSS.css">
    <!-- Bootstrap -->
    <!---<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
--->
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
    <cfif structKeyExists(session, "stLoggedInUser")>
        <div class="col-md-2 col-sm-2 sidebar">
            <ul class="nav nav-pills nav-stacked" style="border: 1px solid #337ab7 ; border-radius:8px">
                <li class="active"><a href="/view/admin.cfm">DashBoard</a></li>
                <li><a href="/view/adminAdd.cfm">Add Item</a></li>
                <li><a href="/view/adminOther.cfm">Add Other</a></li>
                <li><a href="/view/adminEdit.cfm">Edit Item</a></li>
                <li><a href="/view/adminRemove.cfm">Remove Item</a></li>

            </ul>
        </div>
        <cfelse>
            <cflocation url="/view/signin.cfm" />
    </cfif>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!---  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    --->

</body>
</html>
