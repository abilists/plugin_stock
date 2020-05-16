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

var mscNoInput = document.getElementById("mscNoId");
var mscCodeInput = document.getElementById("mscCodeId");
var mscNameInput = document.getElementById("mscNameId");
var mscProfitInput = document.getElementById("mscProfitId");
var mscDividendInput = document.getElementById("mscDividendId");
var mscPayoutRatioInput = document.getElementById("mscPayoutRatioId");
var mscCommentInput = document.getElementById("mscCommentId");

var tokenInput = document.getElementById("tokenId");

function selectMasterStockCompany(x, mscNo) {

	$("#udtMdataFormId").insertAfter($(x));

	$(document).ready(function() {
        $.ajax({
            type: 'POST',
            url: '${configBean.contextPath?if_exists}/plugins/stock/sltMStockCompanyAjax',
            contentType: "application/json",
            dataType: "json",
            data: '{ "mscNo" : "' + mscNo + '", "token" : "' + tokenInput.value + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data)) {
            		mscNoInput.value = data.mscNo;
            		mscCodeInput.value = data.mscCode;
            		mscNameInput.value = data.mscName;
            		mscProfitInput.value = data.mscProfit;
            		mscDividendInput.value = data.mscDividend;
            		mscPayoutRatioInput.value = data.mscPayoutRatio;
            		mscCommentInput.value = data.mscComment;
            		
            		companyStockInput.href = "${configBean.contextPath?if_exists}/plugins/stock/sltStockList/" + data.mscNo;

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

	mscNoInput = "";
	mscCodeInput = "";
	mscNameInput = "";
	mscProfitInput = "";
	mscDividendInput = "";
	mscPayoutRatioInput = "";
	mscCommentInput = "";

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