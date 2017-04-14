<!---
FileName      :orderDetails.cfm
Functionality : It will show the order details of the customer
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

    <cfif NOT StructKeyExists(SESSION, "stLoggedInUser")>
        <cflocation url="/view/signin.cfm" />
        <cfelse>
            <cfinclude template="/common/header.cfm" />
            <cfinvoke component="Controller.orderDetails" method="showDetails" returnvariable="detailquery">
                <!---<cfdump var="#detailquery#">--->

                <cfif detailquery.recordCount EQ 0>
                    <div class="row">
                        <div class="col-sm-8 col-md-8 col-lg-12">
                            No previous purchases....
                        </div>
                    </div>
                    <cfelse>
                        <div class="container" style="margin-left:80px">
                            <cfoutput query="detailquery" group="orderID">
                                <div class="row well well-sm">

                                    <cfoutput>

                                        <div class="col-sm-8 col-md-8 col-xm-8 col-lg-12" style="margin-bottom:10px">
                                            <div class="col-sm-2 col-md-2 col-lg-5">
                                                <img src=#detailquery.thumbNailPhoto# alt="not found" class="img-responsive">
                                            </div>
                                            <div class="col-sm-5 col-md-5 col-lg-6">
                                                <h4>#detailquery.brandName# #detailquery.productName#</h4>
                                                <p>Price:#detailquery.detailPrice#</p>
                                                <p>Qty:#detailquery.quantity#</p>
                                          </div>
                                        </div>
                                        <br/>
                                    </cfoutput>
                                    <div class="text-center">
                                        <h5>Shipping Address:</h5> #detailquery.customerAddress1#
                                        <br/>
                                        <cfif len(trim(detailquery.customerAddress2))>
                                            #detailquery.customerAddress2#
                                            <br/>
                                        </cfif>
                                        #detailquery.customerCity#
                                        <br/> #detailquery.customerState#
                                        <br/> #detailquery.customerCountry#
                                        <br/> Ordered Date :#detailquery.orderDate#
                                        <br/> Total : Rs.<strong>#LsNumberFormat(precisionEvaluate(detailquery.orderAmount),"0.00")#</strong>
                                    </div>
                                </div>
                            </cfoutput>
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
                </cfif>

    </cfif>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
