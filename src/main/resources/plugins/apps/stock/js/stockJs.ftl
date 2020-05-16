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

var ustNoInput = document.getElementById("ustNoId");
var ustClassifyInput = document.getElementById("ustClassifyId");
var ustSaleCostInput = document.getElementById("ustSaleCostId");
var ustSaleCntInput = document.getElementById("ustSaleCntId");
var ustSaleFeeInput = document.getElementById("ustSaleFeeId");
var ustCommentInput = document.getElementById("ustCommentId");

var tokenInput = document.getElementById("tokenId");

function selectStock(x, ustNo) {

	$("#udtMdataFormId").insertAfter($(x));

	$(document).ready(function() {
        $.ajax({
            type: 'POST',
            url: '${configBean.contextPath?if_exists}/plugins/stock/sltStockAjax',
            contentType: "application/json",
            dataType: "json",
            data: '{ "ustNo" : "' + ustNo + '", "token" : "' + tokenInput.value + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data)) {
            		ustNoInput.value = data.ustNo;
            		ustClassifyInput.value = data.ustClassify;
            		ustSaleCostInput.value = data.ustSaleCost;
            		ustSaleCntInput.value = data.ustSaleCnt;
            		ustSaleFeeInput.value = data.ustSaleFee;
            		ustCommentInput.value = data.ustComment;

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

	ustSaleCostInput.value = "";
	ustSaleCntInput.value = "";
	ustSaleFeeInput.value = "";
	ustCommentInput.value = "";

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

function dltStock() {
	// Call the modal for deleting
	$(window).ready(function(){
		$('#sbtFormDelete').modal('show')
	});
}

function sbtDeleteFormStock() {
	document.udtForm.action = "${configBean.contextPath?if_exists}/plugins/stock/dltStock";
	document.udtForm.submit();
}

</script>