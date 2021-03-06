<!---
FileName      :payment.cfm
Functionality : It will process the payment details
--->
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.2/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>

    <body>
        <cfif StructKeyExists(SESSION, "showDefaultButton")>
            <cfset StructDelete(SESSION, "showDefaultButton")>
        </cfif>

        <cfparam name="addressVar" default=0>
            <cfif structKeyExists(url, "newAddress")>
                <cfset SESSION.allowToBuySingle=true>
            </cfif>

            <cfif structKeyExists(url, "linkAddress")>
                <cfset SESSION.setDifferentAddress=true>
                    <cfset SESSION.showDefaultButton=true>
            </cfif>

            <cfinclude template="/common/header.cfm" />
            <div class="container">

                <cfif structKeyExists(form, "submit")>
                    <cfinvoke component="Controller.addressEntry" method="storeAddress" argumentCollection="#form#" returnvariable="checkValForAddress">
                        <cfset SESSION.setDifferentAddress=false>
                            <cfset structDelete(SESSION, "setDifferentAddress")>
                                <cfset addressVar=#checkValForAddress#>
                                    <cfset structDelete(form, "submit")>
                                        <cfset SESSION.repeat=false>
                </cfif>
                <!--- Allow user to set default address in other Address option --->
                <cfif structKeyExists(form, "setDefault")>
                    <cfset SESSION.setDifferentAddress=false>
                        <cfinvoke component="Controller.addressEntry" method="storeAddress" argumentCollection="#form#" returnvariable="checkValForAddress">
                            <cfset structDelete(SESSION, "setDifferentAddress")>
                                <cfset addressVar=#checkValForAddress#>
                                    <cfset structDelete(form, "setDefault")>
                                        <cfset SESSION.repeat=false>
                </cfif>

                <!--- --->

                <cfif NOT StructKeyExists(SESSION, "stLoggedInUser")>
                    <cflocation url="/view/signup.cfm" addtoken="false" />
                    <cfelse>
                        <cfset getObject=createObject( "component", "Controller.addressEntry")>
                            <cfset check=getObject.searchUserAddress()>

                                <cfif check EQ true AND NOT StructKeyExists(url, "newAddress") AND NOT StructKeyExists(url, "addressAll")>

                                    <cfoutput>
                                        <cfif structKeyExists(SESSION, "allowToBuySingle") AND SESSION.allowToBuySingle EQ true>
                                            <cfinvoke component="Controller.singleBuy" method="buyNow" addressID=#addressVar#>
                                                <cfset structDelete(SESSION, "allowToBuySingle")>
                                                    <cfelse>

                                                        <cfinvoke component="Controller.authentication" method="purchaseOrder" addressID=#addressVar#>
                                                            <cfinvoke component="Controller.getProductIDList" method="decrementProduct">

                                                                <!--- Need to add roll back based on above transaction --->
                                        </cfif>
                                        <cflocation url="/view/paymentProcessing.cfm" />

                                    </cfoutput>
                                    <cfelse>
                                        <div class="row">
                                            <div class="col-md-12 col-sm-12 col-lg-12 col-xm-12">
                                                <div class="alert alert-info">
                                                    Create a new Delivery Address below
                                                </div>

                                                <div class="col-md-4 col-sm-4 col-lg-6 col-xm-4">

                                                    <h2>Delivery Address</h2>

                                                    <cfform name="cf_form_address" id="cf_form_address">

                                                        <cfset SESSION.repeat=true>
                                                            <div class="form-group">
                                                                <cfinput class="form-control" type="text" name="country" id="country" placeholder="country" required>
                                                            </div>

                                                            <div class="form-group">
                                                                <cfinput class="form-control" type="text" name="state" id="state" placeholder="state" required>
                                                            </div>

                                                            <div class="form-group">
                                                                <cfinput class="form-control" name="city" id="city" type="text" required placeholder="city">
                                                            </div>

                                                            <div class="form-group">
                                                                <cftextarea class="form-control" name="address" id="address" placeholder="Address" required />
                                                            </div>

                                                            <div class="form-group">
                                                                <cftextarea class="form-control" name="address2" id="address2" placeholder="Address2" />
                                                            </div>

                                                            <div class="form-group">
                                                                <cfinput class="form-control" type="text" name="pincode" id="pincode" placeholder="pincode" required>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-md-1 col-sm-12" style="margin-right:40px ">
                                                                    <div class="form-group">
                                                                        <cfinput class="btn btn-success" type="submit" name="submit" value="Done">
                                                                    </div>
                                                                </div>

                                                                <!---<cfif StructKeyExists(URL,"addressAll") AND StructKeyExists(URL, "linkAddress")>--->
                                                                <cfif StructKeyExists(URL, "linkAddress")>
                                                                <div class="col-md-1 col-sm-12">
                                                                    <div class="form-group">
                                                                        <cfinput class="btn btn-primary" type="submit" name="setDefault" value="Set Default">
                                                                    </div>
                                                                </div>
                                                              </cfif>
                                                            </div>
                                                    </cfform>

                                                </div>

                                            </div>
                                        </div>
                                </cfif>
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
            <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
            <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
            <script src="/assets/script/autoSuggestion.js"></script>
            <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
            <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>

            <script src="/assets/script/addressValidate.js"></script>
    </body>

    </html>
