function showReviewMethod() {
    $("#messageDiv").html("In order to keep reviews real this store will only accept reviews from verified customers that have purchased this product. If you wish to review this product, please log in to your account and use the review form on this page.");
    $("#dialog-modal").dialog({
        modal: true,
        buttons: {
            Ok: function () {
                $(this).dialog("close");
            }
        },
        show: {
            duration: 200
        },
        hide: {
            duration: 200
        }
    });
}

var lastRowIndex = 0;
var pageSize = 5;
var reviewCount = 0

function RenderProductReviews(productID) {
    jQuery.ajax({
        url: "../data/ProductReviews.ashx",
        data: {
            ProductID: productID,
            startRowIndex: lastRowIndex,
            maximumRows: pageSize
        },

        success: function (data) {

            reviewCount = data[0].total;

            $.each(data[0].items, function (key, val) {

                var reviewCategoriesString = "";
                $.each(val.Ratings, function (i, item) {
                    reviewCategoriesString += "<div class='reviewAtt'>";
                    reviewCategoriesString += item.Key;
                    reviewCategoriesString += ":<br/>";
                    reviewCategoriesString += "<img src='../images/stars/" + item.Value + ".png'>";
                    reviewCategoriesString += "</div>";
                });

                $("#productReviews").append("<div class='reviewTd'>Reviewd on " +
                    new Date(val.ReviewDate).toDateString() +
                    " by a customer that have purchased this product on " +
                    new Date(val.OrderDate).toDateString() +
                    "<br/>" +
                    reviewCategoriesString +
                    "<br/>" +
                    val.ReviewText +
                    "</div>");

                reviewCategoriesString = "";
            });

            if (lastRowIndex >= pageSize)
                $("#productReviews").scrollTop($("#productReviews")[0].scrollHeight);
            lastRowIndex = lastRowIndex + pageSize;
            if (lastRowIndex < reviewCount)
                $("#loadMoreReviews").show();
            else
                $("#loadMoreReviews").hide();
        }
    });
}