$(document).ready(function() {
    $("input[name='submitData']").click(function(event) {
        //  alert($("#thumbNailText").val());
        if ($("#formOption").valid())
            ajaxAddCall();
    });
})

function ajaxAddCall() {
    $("#formData").empty();
    var productName = $("#productName").val();
    var brandID = $("#brand").val();
    var categoryID = $("#category").val();
    var shippingID = $("#shipping").val();
    var supplierID = $("#supplier").val();
    var subcategoryID = $("#subcategory").val();
    var price = $("#price").val();
    var quantity = $("#quantity").val();
    var discount = $("#discount").val();
    var rating = $("#rating").val();
    var thumbNail = $("#thumbNailText").val();
    var largePhoto = $("#largePhotoText").val();
    var productDesc = $("#productDesc").val();
    var thumbNailType = $("#thumbNailType").val();
    var largePhotoType = $("#largePhotoType").val();

    $.ajax({
        url: "/Controller/adminData.cfc?method=addToDatabase",
        data: {
            productName: productName,
            productDesc: productDesc,
            supplierID: supplierID,
            subCategoryID: subcategoryID,
            unitPrice: price,
            thumbNail: thumbNail,
            thumbNailType: thumbNailType,
            largePhotoType: largePhotoType,
            largePhoto: largePhoto,
            quantity: quantity,
            discount: discount,
            rating: rating,
            brandID: brandID
        },
        success: function(responseText) {
            $("#formData").append("<div class='alert alert-success'>New Product added to Database</div>").delay(4000).fadeOut();
        },
        error: function(e) {
            $("#formData").append("<div class='alert alert-success'>Error</div>")
        }
    });
}
