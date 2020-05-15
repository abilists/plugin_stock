<#import "/apps/layout/plugins/abilistsPluginsLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<div class="row">
<div class="col-sm-12">
	<div class="caption mittle-size-title middle-works-bg">
		<h5>
			<b>주식 관리</b>
			<span id="newToggleId" class="glyphicon glyphicon-chevron-down right-symbol-works-button" aria-hidden="true" onClick="newFormToggle();"></span>
		</h5>
	</div>

	<div class="item-box">
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">매매 가격</a></li>
		  <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">남은 주식</a></li>

		  <li style="float: right;">
			<form id="searchForm" action="${configBean.contextPath?if_exists}/plugins/stock/srhForStock" method="post" onkeydown="return captureReturnKey(event)">
		    <div id="search0" style="display: table;">
			    <input name="srhContents" type="text" class="form-control" value="" autocomplete="off" autocorrect="off" autocapitilize="off"
			    		data-toggle="popover" data-trigger="manual" data-placement="top" 
			    			title="Popover title" data-content="Default popover"
			    				placeholder="Search for Name" onkeydown="interverKeystroke(event, 0, '/plugins/stock/srhForStockAjax', this);">
			    <span class="input-group-btn" style="width:10%;">
			      <button class="btn btn-default" style="padding: 9px;" type="submit">
			      	<i class="glyphicon glyphicon-search" style="top: 1px;"></i>
			      </button>
			    </span>
		    </div><!-- /input-group -->
		    </form>
	      </li>

		</ul>
		<div class="tab-content">
		  <div role="tabpanel" class="tab-pane active" id="home">
		  	<canvas id="canvas1" height="100px"></canvas>
		  </div>
		  <div role="tabpanel" class="tab-pane" id="profile">
		  	<canvas id="canvas2" height="100px"></canvas>
		  </div>
		</div>
	</div>
</div>
</div>

<div class="row">
<div class="col-sm-12">
	<div class="caption mittle-size-title middle-works-bg">
		<h5>
			<b>주식 관리</b>
			<span id="newToggleId" class="glyphicon glyphicon-chevron-down right-symbol-works-button" aria-hidden="true" onClick="newFormToggle();"></span>
		</h5>
	</div>

	<#include "/apps/common/errorMessage.ftl"/>
	<#include "/apps/common/abilistsSuccess.ftl"/>

	<div id="newMdataFormId" class="item-box" style="display: none;">
		<form id="newFormId" name="newForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/istStock" method="post" onkeypress="return captureReturnKey(event);">
	  	  <div class="row">
	  	  	<div class="col-sm-3 col-md-3">
	  	  		<label class="control-label">구분</label>
				<select id="ustClassifyId" class="form-control" name="ustClassify">
					<option value="0">매매선택</option>
					<option value="1">매수</option>
					<option value="2">매도</option>
					<option value="3">기타</option>
			    </select>
	  	  	</div>
	  	  	<div class="col-sm-3 col-md-3">
	  	  		<label class="control-label">종목이름</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="ustName" placeholder="삼성전자" autocomplete="off" />
			  	</div>
	  	  	</div>
	  	  	<div class="col-sm-3 col-md-3">	
	  			<label class="control-label">1주당 가격</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="ustSaleCost" maxlength="12" size="12" placeholder="2000" onkeypress="return isNumber(event)"/>
			  	</div>
		  	</div>
	  	  	<div class="col-sm-3 col-md-3">	
	  			<label class="control-label">매매 주식수</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="ustSaleCnt" maxlength="12" size="12" placeholder="100" onkeypress="return isNumber(event)"/>
			  	</div>
		  	</div>
	  	  </div>
		  <div class="row">
		  	<div class="col-sm-12 col-md-12">
	  			<label class="control-label">코멘트</label> <span id="idUstComment">0</span>/200
	  			<textarea class="taForm" style="height: 50px;" name="ustComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUstComment', 200)" onfocus="checkByteLength(this, 'idUstComment', 200)"></textarea>
		  	</div>
	  	  </div>
	  	  <input type="hidden" name="token" value="<#if model??>${model.token?if_exists}</#if>" />
		  <br/>
			<p align="center">
		      <button type="button" class="btn btn-primary" onclick="return confirmData('newFormId');">저장</button>
		      <button type="button" class="btn btn-primary" onClick="newFormCancel();">취소</button>
			</p>
		</form>
	</div>

	<div id="udtMdataFormId" class="item-box" style="background-color: #efebe7;margin: 10px; display: none;">
	<form id="udtFormId" name="udtForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/udtStock" method="post" onkeypress="return captureReturnKey(event);">
  	  <div class="row">
  	  	<div class="col-sm-3 col-md-3">
  	  		<label class="control-label">구분</label>
			<select id="ustClassifyId" class="form-control" name="ustClassify">
				<option value="0">매매선택</option>
				<option value="1">매수</option>
				<option value="2">매도</option>
				<option value="3">기타</option>
		    </select>
	  	</div>
	  	<div class="col-sm-3 col-md-3">
	  	  	<label class="control-label">종목이름</label>
	  		<div class="input-group" style="float:right; width: 100%;">
		 		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
		  		<input id="ustNameId" class="form-control" type="text" name="ustName" placeholder="삼성전자" autocomplete="off" />
		  	</div>
	  	</div>
	  	<div class="col-sm-3 col-md-3">	
	  		<label class="control-label">1주당 가격</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="ustSaleCostId" class="form-control" type="text" name="ustSaleCost" maxlength="12" size="12" placeholder="2000" onkeypress="return isNumber(event)" />
		  	</div>
		</div>
	  	<div class="col-sm-3 col-md-3">	
	  		<label class="control-label">매매 주식수</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="ustSaleCntId" class="form-control" type="text" name="ustSaleCnt" maxlength="12" size="12" placeholder="100" onkeypress="return isNumber(event)" />
		  	</div>
		</div>
	  </div>
	  <div class="row">
		<div class="col-sm-12 col-md-12">
	  		<label class="control-label">코멘트</label> <span id="idUstComment">0</span>/200
	  		<textarea id="ustCommentId" class="taForm" style="height: 50px;" name="ustComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUstComment', 200)" onfocus="checkByteLength(this, 'idUstComment', 200)"></textarea>
		</div>
	  </div>
	  <input type="hidden" id="ustNoId" name="ustNo" />
	  <input type="hidden" id="tokenId" name="token" />
	  <br/>
	  <p align="center">
			<button type="button" class="btn btn-primary" onclick="return confirmData('udtFormId');">저장</button>
			<button type="button" class="btn btn-primary" onClick="udtFormCancel();">취소</button>
	  </p>
	</form>
	</div>

	<div id="userStockId">
		<div id="stockTableId" style="border: 1px solid #CDCDCD;">
		<div>
	    <ul class="table-ul table-ul-header ul-table ul-thead">
	    	<li style="width: 20px;">No</li>
	        <li style="width: 150px;">종목 이름</li>
	    	<li style="width: 50px;">구분</li>
	        <li style="width: 150px;">1주당 가격</li>
	        <li style="width: 150px;">매매 주식수</li>
	        <li style="width: 150px;">입력한 날짜</li>
	    </ul>
	    <#if plugins??>
	    <#if plugins.stockList?has_content>
	    <#list plugins.stockList as stock>
		    <ul class="table-ul bg-color ul-hover ul-table"
			<#if stock.ustClassify??><#if stock.ustClassify == "1">
				style="width: 100%;background-color: #ffefef;color: red;" 
			  <#elseif stock.ustClassify == "2">
				style="width: 100%;background-color: #eff0ff;color: blue;"
			  <#else>
				style="width: 100%;background-color: #f7f7f7;color: #737373;"
			  </#if></#if>onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);" onclick="selectStock(this, '${stock.ustNo?if_exists}');">
		    	<li style="width: 20px;"><#if stock.ustNo??>${stock.ustNo?if_exists}</#if></li>
	        	<li style="width: 150px;"><#if stock.ustName??>${stock.ustName?if_exists}</#if></li>			
		    <#if stock.ustClassify??>
			  <#if stock.ustClassify == "1">
				<li style="width: 50px;">매수</li>
			  <#elseif stock.ustClassify == "2">
				<li style="width: 50px;">매도</li>
			  <#else>
				<li style="width: 50px;">기타</li>
			  </#if>
			</#if>
	        	<li style="width: 150px;"><#if stock.ustSaleCost??>${stock.ustSaleCost?if_exists}</#if></li>
	        	<li style="width: 150px;"><#if stock.ustSaleCnt??>${stock.ustSaleCnt?if_exists}</#if></li>
		        <li style="width: 150px;"><#if stock.ustName??>${stock.insertTime?string('yyyy-MM-dd hh:mm:ss')?if_exists}</#if></li>
		    </ul>
		</#list>
		</#if>
		</#if>
		</div>
		</div>
	</div>
	<br/>
	<nav class="text-center">
    <ul class="pagination">
	    <#if model?exists>
	  	<#if model.paging?exists>
			<#if model.paging.prevPage?exists>
			<li><a href="/plugins/stock?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="/plugins/stock?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="/plugins/stock?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
		</#if>
	</ul>
	</nav><!-- end #nav -->
  </div>

</div>
</div>


<#include "/apps/common/abilistsPluginsLoadJs.ftl"/>
<#include "/apps/stock/js/stockJs.ftl"/>

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
/* start - Autocomplete   */
</script>


</@layout.myLayout>