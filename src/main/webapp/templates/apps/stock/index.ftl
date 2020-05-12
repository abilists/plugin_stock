<#import "/apps/layout/plugins/abilistsPluginsLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<div class="row">
<div class="col-sm-12">
	<div class="item-box">
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">매매 가격</a></li>
		  <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">남은 주식</a></li>
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
	    	<li style="width: 50px;">구분</li>
	        <li style="width: 150px;">종목 이름</li>
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
			<#if stock.ustClassify??>
			  <#if stock.ustClassify == "1">
				<li style="width: 50px;">매수</li>
			  <#elseif stock.ustClassify == "2">
				<li style="width: 50px;">매도</li>
			  <#else>
				<li style="width: 50px;">기타</li>
			  </#if>
			</#if>
	        	<li style="width: 150px;"><#if stock.ustName??>${stock.ustName?if_exists}</#if></li>
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
<#include "/apps/stock/js/indexJs.ftl"/>

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
</script>
</@layout.myLayout>