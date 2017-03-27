    select  Brands.brandName,OrderDetails.detailProductID,Products.supplierID,OrderDetails.detailID,ProductPhoto.thumbNailPhoto,Products.afterDiscount,Products.productName,OrderDetails.supplierID,Supplier.supplierName,OrderDetails.status from OrderDetails
      inner join Products
      on
      Products.productID=OrderDetails.detailProductID
      inner join ProductPhoto
      on
      Products.photoID=ProductPhoto.photoID
      inner join Supplier
      on
      Products.productID=Supplier.supplierID
      inner join Brands
      on
      Products.brandID=Brands.brandID
       where OrderDetails.userID=1 
        AND
        OrderDetails.status='addedToCart'