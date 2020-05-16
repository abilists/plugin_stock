
<!-- Chart.js -->
<script src="/static/apps/lib/chart-2.7/Chart.bundle.min.js?2017092301"></script>
<script src="/static/apps/lib/chart-2.7/Chart.min.js?2017092301"></script>

<script>
	var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

	var data1 = {
		labels: ['10', '20', '5', '8', '12'],
		datasets: [{
			type: 'line',
			label: '매수',
			fill: false,
			backgroundColor: window.chartColors.red,
			borderColor: window.chartColors.red,
			data: [
				3000,
				2500,
				2200,
				2000,
				0
			]
		}, {
			type: 'line',
			label: '매도',
			fill: false,
			backgroundColor: window.chartColors.blue,
			borderColor: window.chartColors.blue,
			data: [
				1500,
				0,
				0,
				1000,
				1500
			]
		}]
	};

	var option1 = {
		responsive: true,
		title: {
			display: true,
			text: '나의 주식 관리'
		},
		tooltips: {
			mode: 'index',
			intersect: false,
		},
		hover: {
			mode: 'nearest',
			intersect: true
		},
		scales: {
			xAxes: [{
				display: true,
				scaleLabel: {
					display: true,
					labelString: '주식수'
				}
			}],
			yAxes: [{
				display: true,
				scaleLabel: {
					display: true,
					labelString: '가격'
				},
				ticks: {
					min: 0
				}
			}]
		}
	};
	
	var ctx = document.getElementById("canvas1").getContext("2d");
	var myReportsBar = new Chart(ctx, {
	    type: 'line',
	    data: data1,
	    options: option1
	});
	
	

	var data2 = {
		title: {
			display: true,
			text: 'Bar Chart'
		},
		labels: ['10', '20', '5', '8', '12'],
		datasets: [{
			label: '매수',
			fill: false,
			backgroundColor: window.chartColors.red,
			borderColor: window.chartColors.red,
			data: [
				2000,
				1500,
				1200,
				1000,
				0
			]
		}],
		borderWidth: 1
	};

	var option2 = {
		responsive: true,
		title: {
			display: true,
			text: '나의 주식 관리'
		},
		tooltips: {
			mode: 'index',
			intersect: false,
		},
		hover: {
			mode: 'nearest',
			intersect: true
		},
		scales: {
	        yAxes: [{
		            type: "linear",
		            display: true,
		            position: "left",
					gridLines: {
						display: true,
						color: "rgba(239,239,239,0.7)"
					}
	        	}, {
		            type: "linear",
		            display: false,
		            gridLines: {
		                drawOnChartArea: true
		            }
		        }],
	        xAxes: [{
				gridLines: {
					display: true,
				}
			}]
		}
	};

	var ctx = document.getElementById("canvas2").getContext("2d");
	var myReportsBar = new Chart(ctx, {
	    type: 'bar',
	    data: data2,
	    options: option2
	});
	
/* start - Autocomplete   */
	function exceptionKeyByObj(e) {
	    if(e.keyCode==37 || e.keyCode==38 || 
	    		e.keyCode==39 || e.keyCode==40 ) {
	        return false;
	    }
	    return true;
	}
	
	var timeout;
	var ajaxLastNum = 0;
	
	function interverKeystroke(e, num, url, ojb) {
	
		clearTimeout(timeout);
		timeout = setTimeout(function() {
			autoSrhItem(e, num, url, ojb);
		}, 500);
	
	}

	/*
	// Multi search function
	// 1, Local object
	// 2. Array number
	// 3. Url for the local object
	// 4. This
	*/
	function autoSrhItem(e, num, url, ojb) {

		if(!exceptionKeyByObj(e)) {
			return false;
		}

		$(document).ready(function() {
			// Make a object
			var $inputSname = $('#searchForm').find('input[name=' + ojb.name + ']:eq(' + num + ')');
			// Validate value's length
			if($inputSname.val().length < 2) {
				return false;
			}
			$inputSname.popover('destroy');

			var availableTags = [];
			var currentAjaxNum = ajaxLastNum;

	        $.ajax({
	            type: 'POST',
	            url: url,
	            contentType: "application/json",
	            dataType: "json",
	            data: '{"' + $inputSname.attr("name") + '" : "' + $inputSname.val() + '"}',
	            cache: false,
	            beforeSend: function(xhr, settings) {
	            	ajaxLastNum = ajaxLastNum + 1;
	            	$('#search' + num).addClass('input-spinner');
	            },
	            success: function(data, textStatus, request) {
	            	$('#search' + num).removeClass('input-spinner');
	            	if(currentAjaxNum == ajaxLastNum - 1) {
	                	if(!isBlank(data)) {
	                		console.log(data);
	                		availableTags = data;
	                		$('#statuses').html('<li>' + data + '</li>');
	                	}
	                	var availableNames = [];
	                	for (var i in availableTags) {
	                		availableNames[i] = availableTags[i].map1;
	                	}
	                	$inputSname.autocomplete();
	                    // Close if already visible
	                	if ($inputSname.autocomplete("widget").is(":visible")) {
	                		$inputSname.autocomplete("close");
	                		return false;
	                	}
	                	$inputSname.autocomplete({source: availableTags, 
	                		autoFocus: false, 
	                		minLength: 0,
	                		create: function( event, ui ) {
	                		    if($(this).autocomplete('widget').is(':visible')) {
	                		    	console.log(" create >> visible");
	                		    } else {
	                		    	console.log(" create >> desable");
	                		    }
	                			return true;
	                		},
	                		close: function( event, ui ) {},
	                		open: function( event, ui ) {return true;},
	                		search: function( event, ui ) {return true;},
	                		focus: function( event, ui ) {return false;},
	                		select: function( event, ui ) {
	                    		if(ojb.name == "srhContents") {
	                				var str = ui.item.ustName;
	                				$inputSname.val( str );
	                    		} else {
	                    			console.log("Error search in select");
	                    		}
	                			return false;
	                		}
	                	}).data( "ui-autocomplete" )._renderItem = function( ul, item ) {
	                		var uiAuto;
	                		if(ojb.name == "srhContents") {
	                			var uiAuto = $( "<li>" ).attr( "data-value", item.userId );
	            				var str = item.ustName;
	            				uiAuto.append('<span>' + str + '</span>');

	                		} else {
	                			console.log("Error search in data");
	                		}
	            			uiAuto.append('</li>');
	            			dataValue = uiAuto.appendTo( ul );

	                        return dataValue;
	                    };

	    	            // fire search event
	                	$inputSname.autocomplete("search", "");
	                	$inputSname.focus();

	            	}
	            },
	            complete: function(xhr, textStatus) {
	            	//$inputSname.attr('disabled', false);
	            },
	            error: function(xhr, status) {
	                var contentType = xhr.getResponseHeader("Content-Type");
	                if (xhr.status === 200 && contentType.toLowerCase().indexOf("text/html") >= 0) {
	                    // Login has expired - reload our current page
	                    window.location.reload();
	                }
	            }
	        });
		});
	}
/* end - Autocomplete   */
</script>
