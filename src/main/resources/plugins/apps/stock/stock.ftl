<#import "/apps/layout/plugins/abilistsPluginsLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>

a.a-button {
	color:#d3ffd3;
}
a.a-button:hover {
	color:#ffffff;
}

div.ui-datepicker {
	width: 270px;
}

</style>
<div class="caption mittle-size-title" style="background: #4a9c4a !important;">
<h5>
	<b><a class="a-button" href="${configBean.contextPath?if_exists}/plugins/stock" role="button"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span></a></b> 종목 회사
</h5>
</div>

<ul class="table-ul table-ul-header ul-table">
	<li style="width: 30px;">No</li>
	<li style="width: 80px;">종목코드</li>
	<li style="width: 15%;">종목이름</li>
	<li style="width: 15%;">당기순이익(억원)</li>
	<li style="width: 15%;">주당배당금(원)</li>
	<li style="width: 15%;">배당성향(%)</li>
	<li>입력한 날짜</li>
</ul>

<#if plugins.mStockCompany??>
<ul class="table-ul ul-table" style="background-color: #f1f1f1;">
	<li style="width: 30px;">${plugins.mStockCompany.uscNo?if_exists}</li>
	<li style="width: 80px;">${plugins.mStockCompany.uscCode?if_exists}</li>
	<li style="width: 15%;">${plugins.mStockCompany.uscName?if_exists}</li>
	<li style="width: 15%;">${plugins.mStockCompany.uscProfit?if_exists}</li>
	<li style="width: 15%;">${plugins.mStockCompany.uscDividend?if_exists}</li>
	<li style="width: 15%;">${plugins.mStockCompany.uscPayoutRatio?if_exists}</li>
    <li>${plugins.mStockCompany.updateTime?string('yyyy-MM-dd hh:mm:ss')?if_exists}</li>
</ul>
</#if>

<div class="row">
<div class="col-sm-12">
	<div class="item-box">
		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">매매 가격</a></li>
		  <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">매매 주식수</a></li>
		  <li role="presentation"><a href="#works" aria-controls="profile" role="tab" data-toggle="tab">남은 주식수</a></li>
		  <li role="presentation"><a href="#money" aria-controls="money" role="tab" data-toggle="tab">수익 실현</a></li>
		  <li style="float: right;"></li>
		</ul>
		<div class="tab-content">
		  <div role="tabpanel" class="tab-pane active" id="home">
		  	<canvas id="canvas1" height="100px"></canvas>
		  </div>
		  <div role="tabpanel" class="tab-pane" id="profile">
		  	<canvas id="canvas2" height="100px"></canvas>
		  </div>
		  <div role="tabpanel" class="tab-pane" id="works">
		  	<canvas id="canvas3" height="100px"></canvas>
		  </div>
		  <div role="tabpanel" class="tab-pane" id="money">
		  	<canvas id="canvas4" height="100px"></canvas>
		  </div>
		</div>
	</div>
</div>
</div>

<div class="row">
<div class="col-sm-12">
	<div class="caption mittle-size-title" style="background: #12ad12 !important;">
		<h5>
			<b>주식 관리</b>
			<span id="newToggleId" class="glyphicon glyphicon-chevron-down right-symbol-works-button" style="color: #ffffff;" aria-hidden="true" onClick="newFormToggle();"></span>
		</h5>
	</div>

	<#include "/apps/common/errorMessage.ftl"/>
	<#include "/apps/common/abilistsSuccess.ftl"/>

	<div id="newMdataFormId" class="item-box" style="display: none;">
		<form id="newFormId" name="newForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/istStock" method="post" onkeypress="return captureReturnKey(event);">
	  	  <div class="row">
	  	  	<div class="col-sm-3 col-md-3">
	  	  		<label class="control-label">매매 날짜</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  	    <span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
			  		<input type="text" class="form-control" id="newUstSaleDayId" name="ustSaleDay" placeholder="2020-02-22" autocomplete="off">
			  	</div>
	  	  	</div>
	  	  	<div class="col-sm-3 col-md-3">
	  	  		<label class="control-label">구분</label>
	  	  		<div class="input-group" style="float:right; width: 100%;">
				  	<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
					<select class="form-control" name="ustClassify">
						<option value="0">매매선택</option>
						<option value="1">매수</option>
						<option value="2">매도</option>
						<option value="3">기타</option>
				    </select>
			  	</div>
	  	  	</div>
	  	  	<div class="col-sm-3 col-md-3">	
	  			<label class="control-label">1주당 가격</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-usd" aria-hidden="true"></span></span>
			  		<input class="form-control" type="number" name="ustSaleCost" maxlength="12" size="12" placeholder="2000" onkeypress="return isNumber(event)"/>
			  	</div>
		  	</div>
	  	  	<div class="col-sm-3 col-md-3">	
	  			<label class="control-label">매매 주식수</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="number" name="ustSaleCnt" maxlength="12" size="12" placeholder="100" onkeypress="return isNumber(event)"/>
			  	</div>
		  	</div>
	  	  </div>
		  <div class="row">
		  	<div class="col-sm-3 col-md-3">
	  	  		<label class="control-label">수수료</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-usd" aria-hidden="true"></span></span>
			  		<input class="form-control" type="number" name="ustSaleFee" placeholder="10" autocomplete="off" onkeypress="return isNumber(event)" value="0"/>
			  	</div>
		  	</div>
		  	<div class="col-sm-9 col-md-9">
	  			<label class="control-label">코멘트</label> <span id="idUstComment">0</span>/200
	  			<textarea class="taForm" style="height: 35px;" name="ustComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUstComment', 200)" onfocus="checkByteLength(this, 'idUstComment', 200)"></textarea>
		  	</div>
	  	  </div>
	  	  <input type="hidden" id="uscNoId" name="uscNo" value="<#if plugins.mStockCompany??>${plugins.mStockCompany.uscNo?if_exists}</#if>" />
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
  	  		<label class="control-label">매매 날짜</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  	    <span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
		  		<input type="text" class="form-control" id="udtUstSaleDayId" name="ustSaleDay" placeholder="2020-02-22" autocomplete="off">
		  	</div>
  	  	</div>
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
	  		<label class="control-label">1주당 가격</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="ustSaleCostId" class="form-control" type="number" name="ustSaleCost" maxlength="12" size="12" placeholder="2000" onkeypress="return isNumber(event)" />
		  	</div>
		</div>
	  	<div class="col-sm-3 col-md-3">	
	  		<label class="control-label">매매 주식수</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="ustSaleCntId" class="form-control" type="number" name="ustSaleCnt" maxlength="12" size="12" placeholder="100" onkeypress="return isNumber(event)" />
		  	</div>
		</div>
	  </div>
	  <div class="row">
	  	<div class="col-sm-3 col-md-3">
	  	  	<label class="control-label">수수료</label>
	  		<div class="input-group" style="float:right; width: 100%;">
		 		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-usd" aria-hidden="true"></span></span>
		  		<input id="ustSaleFeeId" class="form-control" type="number" name="ustSaleFee" placeholder="10" autocomplete="off" onkeypress="return isNumber(event)"/>
		  	</div>
	  	</div>
		<div class="col-sm-9 col-md-9">
	  		<label class="control-label">코멘트</label> <span id="idUstComment">0</span>/200
	  		<textarea id="ustCommentId" class="taForm" style="height: 35px;" name="ustComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUstComment', 200)" onfocus="checkByteLength(this, 'idUstComment', 200)"></textarea>
		</div>
	  </div>
	  <input type="hidden" id="uscNoId" name="uscNo" value="<#if plugins.mStockCompany??>${plugins.mStockCompany.uscNo?if_exists}</#if>" />
	  <input type="hidden" id="ustNoId" name="ustNo" />
	  <input type="hidden" id="tokenId" name="token" />
	  <br/>
	  <p align="center">
			<button type="button" class="btn btn-primary" onclick="return confirmData('udtFormId');">저장</button>
			<button type="button" class="btn btn-primary" onClick="udtFormCancel();">취소</button>
			<button type="button" class="btn btn-danger" style="width: 80px;" onclick="javascript: dltStock();">삭제</button>
	  </p>
	</form>
	</div>

	<div id="userStockId">
		<div id="stockTableId" style="border: 1px solid #CDCDCD;">
		<div>
	    <ul class="table-ul table-ul-header ul-table ul-thead">
	    	<li style="width: 30px;">No</li>
	    	<li style="width: 100px;">매매 날짜</li>
	    	<li style="width: 50px;">구분</li>
	        <li style="width: 20%;">1주당 가격</li>
	        <li style="width: 20%;">주식수</li>
	        <li style="width: 20%;">수수료</li>
	        <li style="width: 60px;">코멘트</li>
	    </ul>
	    <#if plugins.userStockList??>
	    <#if plugins.userStockList?has_content>
	    <#list plugins.userStockList as userStock>
		    <ul class="table-ul bg-color ul-hover ul-table"
			<#if userStock.ustClassify??><#if userStock.ustClassify == "1">
				style="width: 100%;background-color: #ffefef;color: red;" 
			  <#elseif userStock.ustClassify == "2">
				style="width: 100%;background-color: #eff0ff;color: blue;"
			  <#else>
				style="width: 100%;background-color: #f7f7f7;color: #737373;"
			  </#if></#if>onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);" onclick="selectStock(this, '${userStock.ustNo?if_exists}');">

		    	<li style="width: 30px;">${userStock.ustNo?if_exists}</li>
		    	<li style="width: 100px;">${userStock.ustSaleDay?string('yyyy-MM-dd')?if_exists}</li>
		    <#if userStock.ustClassify??>
			  <#if userStock.ustClassify == "1">
				<li style="width: 50px;">매수</li>
			  <#elseif userStock.ustClassify == "2">
				<li style="width: 50px;">매도</li>
			  <#else>
				<li style="width: 50px;">기타</li>
			  </#if>
			</#if>
	        	<li style="width: 20%;"><#if userStock.ustSaleCost??>${userStock.ustSaleCost?if_exists}</#if></li>
	        	<li style="width: 20%;"><#if userStock.ustSaleCnt??>${userStock.ustSaleCnt?if_exists}</#if></li>
				<li style="width: 20%;"><#if userStock.ustSaleFee??>${userStock.ustSaleFee?if_exists}</#if></li>
				<li style="width: 60px;"><#if userStock.ustComment?has_content>*</#if></li>
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

<!-- Delete Modal -->
<div class="modal fade" id="sbtFormDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <h4 class="modal-title">삭제 확인</h4>
    </div>

    <div id="confirmMessage" class="modal-body">
    		선택한 매매 정보를 삭제하시겠습니까?
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      <button id="submitForm" type="button" class="btn btn-danger" onclick="javascript: sbtDeleteFormStock();">삭제하기</button>
    </div>
  </div>
</div>
</div>

<#include "/apps/common/abilistsPluginsLoadJs.ftl"/>
<#include "/apps/stock/js/stockJs.ftl"/>

<!-- Chart.js -->
<script src="/static/apps/lib/chart-2.7/Chart.bundle.min.js?2017092301"></script>
<script src="/static/apps/lib/chart-2.7/Chart.min.js?2017092301"></script>

<script type="text/javascript">
<#include "/apps/stock/js/chartStockPriceJs.ftl"/>
<#include "/apps/stock/js/chartStockCountJs.ftl"/>
<#include "/apps/stock/js/chartStockLeftJs.ftl"/>
<#include "/apps/stock/js/chartStockAssetJs.ftl"/>
</script>

</@layout.myLayout>