<!---
FileName      :addressConfirm.cfm
Functionality : It will show the address details to the customer if exists
--->
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


    <cfinvoke method="getAddressInProductPage" component="Controller.addressEntry"  returnvariable="addressquery" />
    <cfinclude template="/view/header.cfm" />

    <div class="container">
        <div class="row">
            <cfoutput>
                <div class="col-md-offset-3 col-sm-4 col-lg-4 col-xm-6 jumbotron text-center">
                    <div>
                        <h4>Shipping Address:</h4>
                        <cfif addressquery.recordCount GTE 1>

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
                        <div class="row">
                            <a href="/view/payment.cfm?addressAll" class="btn btn-info"><i class="fa fa-pencil" aria-hidden="true"></i>&nbsp Edit</a>
                            <cfif addressquery.recordCount GT 0>
                                <a href="/view/payment.cfm?addressAll&linkAddress" class="btn btn-primary">New Address</a>
                                <a href="/view/payment.cfm" class="btn btn-success">Proceed</a>
                            </cfif>
                        </div>
                    </div>

            </cfoutput>
            </div>
        </div>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
