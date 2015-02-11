function GetProductHistory() {
    jQuery.ajax({
        url: "../data/ViewHistory.ashx",
        data: {
            operationType: 3
        },

        success: function (data) {
            GetProductHistorySucceeded(data);
        }
    });
}

function GetProductHistorySucceeded(result) {
    if (result.length == 0 || result.length == undefined)
        return;
    var historyHTML = "";
    for (var i = 0; i < result.length; i++) {
        historyHTML += "<a href='../Product/" + encodeURIComponent(result[i].ProductName).replace(/'/g, "%27") + "'><img src='../ProductImages/" + result[i].Thumbnail + "' alt='" + result[i].ProductName + "' /></a>";
    }
    $("#viewHistory").html(historyHTML);
}

function AddProductToViewHistory(product) {
    jQuery.ajax({
        url: "../data/ViewHistory.ashx",
        data: {
            operationType: 1,
            ProductID: product
        },

        success: function (data) {
            
        }
    });
}

function ChangeHistorySettings(historyOn) {
    jQuery.ajax({
        url: "../data/ViewHistory.ashx",
        data: {
            operationType: 2,
            HistoryOn: historyOn
        },

        success: function (data) {
           
        }
    });
}
