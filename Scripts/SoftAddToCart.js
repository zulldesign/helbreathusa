function softAddToCart(productID, productName) {
    $.ajax({
        type: 'GET',
        cache: false,
        url: '../data/SoftAddToCart.ashx',
        data: {
            ProductID: productID
        },
        success: function (entries) {
            if (entries[0].Redirect != null) {
                if (entries[0].Redirect == "Product")
                    window.location = '../Product/' + encodeURIComponent(productName);
                else if (entries[0].Redirect == "Cart") {
                    var page = "../QuickCheckout.aspx?ProductID=" + productID;
                    var $dialog = $('<div style="display:inline; height:350px width: 600px"></div>')
                                   .html('<iframe style="border: 0px; " src="' + page + '" width="600" height="350" scrolling="no"></iframe>')
                                   .dialog({
                                       autoOpen: false,
                                       modal: true,
                                       height: 'auto',
                                       width: 'auto',
                                       title: "Express Checkout"
                                   });
                    $dialog.dialog('open');
                }
                else if (entries[0].Redirect == "Custom") {
                    window.location = entries[0].To;
                }
            } else if (entries[0].Error != null) {
                alert(entries[0].Error);
            }
        },
        error: function () {

        },
        dataType: 'json'
    });
    return false;
}