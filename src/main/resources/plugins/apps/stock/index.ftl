<#import "/apps/layout/plugins/abilistsPluginsLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>
a.a-button {
	color:#ece2e2;
}
a.a-button:hover {
	color:#ffffff;
}

ul.stock-title {
	list-style: none; 
	width: 100%; 
	display: table;
	padding: 0px;
	margin-bottom: 0px;
}

li.stock-title {
	display: table-cell;
}

</style>

<div class="row">
<div class="col-sm-12">

	<div class="caption mittle-size-title" style="background: #4a9c4a !important;">
		<ul class="stock-title">
		  <li class="stock-title" style="width: 70px;">
		  	<h5>
			  	<#if model??><#if model.subMenu??><#if model.subMenu == "srhStockCompanyList">
			  	<b><a class="a-button" href="${configBean.contextPath?if_exists}/plugins/stock" role="button"><span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span></a></b>
			  	</#if></#if></#if>
			  	주식 관리
		  	</h5>
		  </li>
		  <li class="stock-title">
			<form id="searchForm" action="${configBean.contextPath?if_exists}/plugins/stock/srhStockCompanyList" method="post" onkeydown="return captureReturnKey(event)">
		    <div id="search0" style="display: table;">
			    <input name="srhContents" type="text" class="form-control" value="" autocomplete="off" autocorrect="off" autocapitilize="off"
			    		data-toggle="popover" data-trigger="manual" data-placement="top" 
			    			title="Popover title" data-content="Default popover"
			    				placeholder="Search for Name" onkeydown="interverKeystroke(event, 0, '/plugins/stock/srhStockCompanyAjax', this);">
			    <span class="input-group-btn" style="width:10%;">
			      <button class="btn btn-default" style="padding: 9px;" type="submit">
			      	<i class="glyphicon glyphicon-search" style="top: 1px;"></i>
			      </button>
			    </span>
		    </div>
		    </form>
		  </li>
		  <li class="stock-title" style="float: right;">
		  	<span id="newToggleId" class="glyphicon glyphicon-chevron-down right-symbol-works-button" style="top: 5px;font-size: 22px;color: #ffffff;" aria-hidden="true" onClick="newFormToggle();"></span>
		  </li>
		</ul>
	</div>

	<#include "/apps/common/errorMessage.ftl"/>
	<#include "/apps/common/abilistsSuccess.ftl"/>

	<div id="newMdataFormId" class="item-box" style="display: none;">
		<form id="newFormId" name="newForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/istStockCompany" method="post" onkeypress="return captureReturnKey(event);">
	  	  <div class="row">
	  	  	<div class="col-sm-3 col-md-3">
				<label class="control-label">종목코드</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="uscCode" placeholder="005930" autocomplete="off" onkeypress="return isAllNumber(event)"/>
			  	</div>
			</div>
	  	  	<div class="col-sm-3 col-md-3">
	  	  		<label class="control-label">종목이름</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="uscName" placeholder="삼성전자" autocomplete="off" />
			  	</div>
	  	  	</div>
	  	  	<div class="col-sm-2 col-md-2">	
	  			<label class="control-label">당기순이익(억원)</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="number" name="uscProfit" maxlength="10" size="10" placeholder="2000" value="0" />
			  	</div>
		  	</div>
	  	  	<div class="col-sm-2 col-md-2">	
	  			<label class="control-label">주당배당금(원)</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="number" name="uscDividend" maxlength="10" size="10" placeholder="100" value="0" />
			  	</div>
		  	</div>
	  	  	<div class="col-sm-2 col-md-2">	
	  			<label class="control-label">배당성향(%)</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="number" name="uscPayoutRatio" maxlength="10" size="10" placeholder="100" value="0" />
			  	</div>
		  	</div>
	  	  </div>
		  <div class="row">
		  	<div class="col-sm-12 col-md-12">
	  			<label class="control-label">코멘트</label> <span id="idUstComment">0</span>/200
	  			<textarea class="taForm" style="height: 50px;" name="uscComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUstComment', 200)" onfocus="checkByteLength(this, 'idUstComment', 200)"></textarea>
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
	<form id="udtFormId" name="udtForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/udtStockCompany?nowPage=<#if model.paging.nowPage?exists>${model.paging.nowPage}</#if>&allCount=${model.paging.allCount?c}" method="post" onkeypress="return captureReturnKey(event);">
	  <div class="row">
	  	<div class="col-sm-3 col-md-3">
			<label class="control-label">종목코드</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
		  		<input id="uscCodeId" class="form-control" type="text" name="uscCode" placeholder="005930" autocomplete="off" onkeypress="return isAllNumber(this)"/>
		  	</div>
		</div>
	  	<div class="col-sm-3 col-md-3">
	  		<label class="control-label">종목이름</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
		  		<input id="uscNameId" class="form-control" type="text" name="uscName" placeholder="삼성전자" autocomplete="off" />
		  	</div>
	  	</div>
	  	<div class="col-sm-2 col-md-2">	
			<label class="control-label">당기순이익(억원)</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="uscProfitId" class="form-control" type="number" name="uscProfit" maxlength="10" size="10" placeholder="2000"/>
		  	</div>
	  	</div>
	  	<div class="col-sm-2 col-md-2">	
			<label class="control-label">주당배당금(원)</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="uscDividendId" class="form-control" type="number" name="uscDividend" maxlength="10" size="10" placeholder="100"/>
		  	</div>
	  	</div>
	  	<div class="col-sm-2 col-md-2">	
			<label class="control-label">배당성향(%)</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="uscPayoutRatioId" class="form-control" type="number" name="uscPayoutRatio" maxlength="10" size="10" placeholder="100"/>
		  	</div>
	  	</div>
	  </div>
	  <div class="row">
		<div class="col-sm-12 col-md-12">
	  		<label class="control-label">코멘트</label> <span id="idUstComment">0</span>/200
	  		<textarea id="uscCommentId" class="taForm" style="height: 50px;" name="uscComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUstComment', 200)" onfocus="checkByteLength(this, 'idUstComment', 200)"></textarea>
		</div>
	  </div>
	  <input type="hidden" id="uscNoId" name="uscNo" />
	  <input type="hidden" id="tokenId" name="token" />
	  <br/>
	  <p align="center">
			<button type="button" class="btn btn-primary" onclick="return confirmData('udtFormId');">저장</button>
			<a id="companyStockId" href="#" class="btn btn-success" style="width: 90px;" role="button">주식매매</a>
			<button type="button" class="btn btn-primary" onClick="udtFormCancel();">취소</button>
			<button type="button" class="btn btn-danger" style="width: 80px;" onclick="javascript: dltStockCompany();">삭제</button>
	  </p>
	</form>
	</div>

	<div id="userStockId">
		<div id="stockTableId" style="border: 1px solid #CDCDCD;">

		<div class="row">
		<div class="col-sm-12">
			<div class="item-box">
				<canvas id="canvas1" height="100px"></canvas>
			</div>
		</div>
		</div>

		<div class="item-box">
	    <ul class="table-ul table-ul-header ul-table ul-thead">
	    	<li style="width: 30px;">No</li>
	        <li style="width: 80px;">종목코드</li>
	    	<li style="width: 15%;">종목이름</li>
	        <li style="width: 15%;">당기순이익(억원)</li>
	        <li style="width: 15%;">주당배당금(원)</li>
	        <li style="width: 15%;">배당성향(%)</li>
	        <li style="width: 15%;">입력한 날짜</li>
	        <li style="width: 60px;">코멘트</li>
	    </ul>
	    <#if plugins??>
	    <#if plugins.stockCompanyList?has_content>
	    <#list plugins.stockCompanyList as stockCompany>
		    <ul class="table-ul bg-color ul-hover ul-table" onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);" onclick="selectStockCompany(this, '${stockCompany.uscNo?if_exists}');">
		    	<li style="width: 30px;">${stockCompany.uscNo?if_exists}</li>
		    	<li style="width: 80px;">${stockCompany.uscCode?if_exists}</li>
		    	<li style="width: 15%;">${stockCompany.uscName?if_exists}</li>
		    	<li style="width: 15%;"><#if stockCompany.uscProfit??>${stockCompany.uscProfit?if_exists}</#if></li>
	        	<li style="width: 15%;"><#if stockCompany.uscDividend??>${stockCompany.uscDividend?if_exists}</#if></li>
	        	<li style="width: 15%;"><#if stockCompany.uscPayoutRatio??>${stockCompany.uscPayoutRatio?if_exists}</#if></li>
		        <li style="width: 15%;"><#if stockCompany.updateTime??>${stockCompany.updateTime?string('yyyy-MM-dd')?if_exists}</#if></li>
		        <li style="width: 60px;"><#if stockCompany.uscComment?has_content>*</#if></li>
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
      <button id="submitForm" type="button" class="btn btn-danger" onclick="javascript: sbtDeleteForStockCompany();">삭제하기</button>
    </div>
  </div>
</div>
</div>

<#include "/apps/common/abilistsPluginsLoadJs.ftl"/>
<#include "/apps/stock/js/indexJs.ftl"/>
<#include "/apps/stock/js/stockSearchJs.ftl"/>
<!-- Chart.js -->
<script src="/static/apps/lib/chart-2.7/Chart.bundle.min.js?2017092301"></script>
<script src="/static/apps/lib/chart-2.7/Chart.min.js?2017092301"></script>

<script type="text/javascript">
<#include "/apps/stock/js/chartIndexAssetJs.ftl"/>
</script>

</@layout.myLayout>