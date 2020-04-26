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

var usmNoInput = document.getElementById("usmNoId");
var usmSampleInput = document.getElementById("usmSampleId");
var tokenInput = document.getElementById("tokenId");

function selectSample(x, usmNo) {

	$("#udtMdataFormId").insertAfter($(x));

	$(document).ready(function() {
        $.ajax({
            type: 'POST',
            url: 'sample/sltSampleAjax',
            contentType: "application/json",
            dataType: "json",
            data: '{ "usmNo" : "' + usmNo + '", "token" : "' + tokenInput.value + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {
            	console.log("before send");
            },
            success: function(data, textStatus, request) {
            	if(!isBlank(data)) {		
            		usmNoInput.value = data.usmNo;
            		usmSampleInput.value = data.usmSample;
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

	usmNoInput.value = "";
	usmSampleInput.value = "";

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
	document.updateForm.action = "/plugins/sample/dltSample";
	document.updateForm.submit();
}

</script>