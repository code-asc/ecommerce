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
    <cfinclude template="header.cfm">
        <cfif NOT StructKeyExists(session, "stLoggedInUser")>
            <cflocation url="signin.cfm" />
            <cfelse>

                
                <cfinvoke method="getAddressOfUser" component="Controller.addressEntry" returnvariable="checkaddressquery" />
                <cfif checkaddressquery.recordCount EQ 1>

                    <cfoutput>
                        Make default page
                    </cfoutput>

                    <cfelse>
                        <div class="col-md-offset-4 col-sm-offset-4 col-xm-offset-4 col-lg-4 ">
                            <cfform>
                                <div class="form-group">
                                    <cfinput name="city" class="form-control" type="text" required>
                                </div>

                                <div class="form-group">
                                    <cfinput name="state" class="form-control" type="text" required>
                                </div>

                                <div class="form-group">
                                    <cfinput name="zip" class="form-control" type="" required>
                                </div>
                            </cfform>
                        </div>
                </cfif>


        </cfif>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="./script/autoSuggestion.js"></script>
</body>

</html>
