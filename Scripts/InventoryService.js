var inventoryChecked = false;


function GetProductStockStatus(ProductID, Quantity) {
    // Get the selected options
    var ProductOptions = $("select");
    var options = new Array(0);
    var j = 0;
    for (var i = 0; i < ProductOptions.length; i++) {
        if (ProductOptions[i].id.indexOf("OptionDropDownList") > -1) {
            options[j] = ProductOptions[i].options[ProductOptions[i].selectedIndex].value;
            j++;
        }
    }

    jQuery.ajax({
        url: "../data/InventoryService.ashx",
        data: {
            ProductID: ProductID,
            ProductOptions: JSON.stringify(options),
            quantity: Quantity
        },

        success: function (data) {
            GetProductStockStatusSucceeded(data);
        }
    });
}

function GetProductStockStatusSucceeded(result) {
    //Submit the form or show a message and then submit the form
    inventoryChecked = true;
    if (result == 0) {
        // Cannot sell this product
        $("#messageDiv").html("We are sorry, but, this combination of options is currently not available or has a lower quantity in stock then the amount you specified. Please change the current option selection or quantity.");
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

        inventoryChecked = false;
    } else if (result == 2) {
        // Pre order
        $("#messageDiv").html("We are sorry, but, this combination of options is currently not available or has a lower quantity in stock then the amount you specified. Your order will be placed in a Pre-Order status and will be fulfilled as soon as this product is back in stock.");

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
            },
            close: function () {
                $('#AddButton').click();
            }
        });
    } else {
        $('#AddButton').click();
    }
}
