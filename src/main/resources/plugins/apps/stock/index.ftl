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
	<div class="caption mittle-size-title middle-works-bg">

		<ul class="stock-title">
		  <li class="stock-title" style="width: 100px;">
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
		  	<span id="newToggleId" class="glyphicon glyphicon-chevron-down right-symbol-works-button" style="top: 5px;font-size: 22px;" aria-hidden="true" onClick="newFormToggle();"></span>
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
	  	  	<div class="col-sm-3 col-md-2">	
	  			<label class="control-label">당기순이익(억원)</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="number" name="uscProfit" maxlength="10" size="10" placeholder="2000" value="0" />
			  	</div>
		  	</div>
	  	  	<div class="col-sm-3 col-md-2">	
	  			<label class="control-label">주당배당금(원)</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="number" name="uscDividend" maxlength="10" size="10" placeholder="100" value="0" />
			  	</div>
		  	</div>
	  	  	<div class="col-sm-3 col-md-2">	
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
	<form id="udtFormId" name="udtForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/udtStockCompany" method="post" onkeypress="return captureReturnKey(event);">
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
	  	<div class="col-sm-3 col-md-2">	
			<label class="control-label">당기순이익(억원)</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="uscProfitId" class="form-control" type="number" name="uscProfit" maxlength="10" size="10" placeholder="2000"/>
		  	</div>
	  	</div>
	  	<div class="col-sm-3 col-md-2">	
			<label class="control-label">주당배당금(원)</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="uscDividendId" class="form-control" type="number" name="uscDividend" maxlength="10" size="10" placeholder="100"/>
		  	</div>
	  	</div>
	  	<div class="col-sm-3 col-md-2">	
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
	  </p>
	</form>
	</div>

	<div id="userStockId">
		<div id="stockTableId" style="border: 1px solid #CDCDCD;">
		<div>
	    <ul class="table-ul table-ul-header ul-table ul-thead">
	    	<li style="width: 30px;">No</li>
	        <li style="width: 150px;">종목코드</li>
	    	<li style="width: 150px;">종목이름</li>
	        <li style="width: 100px;">당기순이익(억원)</li>
	        <li style="width: 100px;">주당배당금(원)</li>
	        <li style="width: 100px;">배당성향(%)</li>
	        <li style="width: 100px;">입력한 날짜</li>
	    </ul>
	    <#if plugins??>
	    <#if plugins.mStockCompanyList?has_content>
	    <#list plugins.mStockCompanyList as mStockCompany>
		    <ul class="table-ul bg-color ul-hover ul-table" onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);" onclick="selectStockCompany(this, '${mStockCompany.uscNo?if_exists}');">
		    	<li style="width: 30px;">${mStockCompany.uscNo?if_exists}</li>
		    	<li style="width: 150px;">${mStockCompany.uscCode?if_exists}</li>
		    	<li style="width: 150px;">${mStockCompany.uscName?if_exists}</li>
		    	<li style="width: 100px;"><#if mStockCompany.uscProfit??>${mStockCompany.uscProfit?if_exists}</#if></li>
	        	<li style="width: 100px;"><#if mStockCompany.uscDividend??>${mStockCompany.uscDividend?if_exists}</#if></li>
	        	<li style="width: 100px;"><#if mStockCompany.uscPayoutRatio??>${mStockCompany.uscPayoutRatio?if_exists}</#if></li>
		        <li style="width: 100px;"><#if mStockCompany.updateTime??>${mStockCompany.updateTime?string('yyyy-MM-dd hh:mm:ss')?if_exists}</#if></li>
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
<script src="${configBean.contextPath?if_exists}/static/apps/js/abilists.js?201706212202"></script>
<#include "/apps/stock/js/indexJs.ftl"/>
<#include "/apps/stock/js/stockSearchJs.ftl"/>

</@layout.myLayout>