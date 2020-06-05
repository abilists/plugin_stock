<script type="text/javascript">

function validateForm(table) {

	var blnPopover = true;
	var isError = true;

	var inputTag = table.getElementsByTagName("input");
	if(!validateField(inputTag)) {
		return false;
	}

	return true;
}

/*
 * Make the table on the Modal for confirming the data.
 */
function confirmData(tableName) {

	var table = document.getElementById(tableName);
	if(!validateForm(table)) {
		return;
	}

	table.submit();
}

var companyStockInput = document.getElementById("companyStockId");

var uscNoInput = document.getElementById("uscNoId");
var uscCodeInput = document.getElementById("uscCodeId");
var uscNameInput = document.getElementById("uscNameId");
var uscProfitInput = document.getElementById("uscProfitId");
var uscDividendInput = document.getElementById("uscDividendId");
var uscPayoutRatioInput = document.getElementById("uscPayoutRatioId");
var uscCommentInput = document.getElementById("uscCommentId");

var tokenInput = document.getElementById("tokenId");

function selectStockCompany(x, uscNo) {

	$("#udtMdataFormId").insertAfter($(x));

	$(document).ready(function() {
        $.ajax({
            type: 'POST',
            url: '${configBean.contextPath?if_exists}/plugins/stock/sltStockCompanyAjax',
            contentType: "application/json",
            dataType: "json",
            data: '{ "uscNo" : "' + uscNo + '", "token" : "' + tokenInput.value + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data)) {
            		uscNoInput.value = data.uscNo;
            		uscCodeInput.value = data.uscCode;
            		uscNameInput.value = data.uscName;
            		uscProfitInput.value = data.uscProfit;
            		uscDividendInput.value = data.uscDividend;
            		uscPayoutRatioInput.value = data.uscPayoutRatio;
            		uscCommentInput.value = data.uscComment;
            		
            		console.log("--- start --- ");
            		companyStockInput.href = "${configBean.contextPath?if_exists}/plugins/stock/sltStockList/" + data.uscNo;
            		console.log("--- end --- ");
            		
            		tokenInput.value = data.token;
            	}
            },
            complete: function(xhr, textStatus) {
            	console.log("complete");
            	formSlideDown();
            },
            error: function(xhr, status) {
            	console.log("error >> " + xhr.responseText);
                var contentType = xhr.getResponseHeader("Content-Type");
                if (xhr.status === 200 && contentType.toLowerCase().indexOf("text/html") >= 0) {
                    // Login has expired - reload our current page
                    window.location.reload();
                }
            }
        });
	});
}

function newFormToggle() {
	$("#newMdataFormId").slideToggle("slow");
	$("#newToggleId").toggleClass('glyphicon-chevron-down glyphicon-chevron-up');

	uscNoInput = "";
	uscCodeInput = "";
	uscNameInput = "";
	uscProfitInput = "";
	uscDividendInput = "";
	uscPayoutRatioInput = "";
	uscCommentInput = "";

	udtFormCancel();
}

function formSlideDown() {
	$("#udtMdataFormId").slideDown("slow");
}

function newFormCancel() {
	$("#newMdataFormId").slideUp("slow");
	$("#newToggleId").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
}

function udtFormCancel() {
	$("#udtMdataFormId").slideUp("slow");
}

function submitNewFormUserReports() {
	document.newForm.submit();
}

function submitUpdateFormUserReports() {
	document.updateForm.submit();
}

/*
 * Remove a survey
 */
function submitDeleteFormReports() {
	document.updateForm.action = "${configBean.contextPath?if_exists}/plugins/stock/dltMasterStock";
	document.updateForm.submit();
}

</script>