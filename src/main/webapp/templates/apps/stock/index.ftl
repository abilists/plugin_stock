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

	<#include "/apps/common/errorMessage.ftl"/>
	<#include "/apps/common/abilistsSuccess.ftl"/>

	<div id="newMdataFormId" class="item-box" style="display: none;">
		<form id="newFormId" name="newForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/istMasterStockCompany" method="post" onkeypress="return captureReturnKey(event);">
	  	  <div class="row">
	  	  	<div class="col-sm-3 col-md-3">
				<label class="control-label">종목코드</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="mscCode" placeholder="삼성전자" autocomplete="off" />
			  	</div>
			</div>
	  	  	<div class="col-sm-3 col-md-3">
	  	  		<label class="control-label">종목이름</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="mscName" placeholder="삼성전자" autocomplete="off" />
			  	</div>
	  	  	</div>
	  	  	<div class="col-sm-3 col-md-2">	
	  			<label class="control-label">당기순이익(억원)</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="mscProfit" maxlength="10" size="10" placeholder="2000" onkeypress="return isNumber(event)"/>
			  	</div>
		  	</div>
	  	  	<div class="col-sm-3 col-md-2">	
	  			<label class="control-label">주당배당금(원)</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="mscDividend" maxlength="10" size="10" placeholder="100" onkeypress="return isNumber(event)"/>
			  	</div>
		  	</div>
	  	  	<div class="col-sm-3 col-md-2">	
	  			<label class="control-label">배당성향(%)</label>
			  	<div class="input-group" style="float:right; width: 100%;">
			  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
			  		<input class="form-control" type="text" name="mscPayoutRatio" maxlength="10" size="10" placeholder="100" onkeypress="return isNumber(event)"/>
			  	</div>
		  	</div>
	  	  </div>
		  <div class="row">
		  	<div class="col-sm-12 col-md-12">
	  			<label class="control-label">코멘트</label> <span id="idUstComment">0</span>/200
	  			<textarea class="taForm" style="height: 50px;" name="mscComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUstComment', 200)" onfocus="checkByteLength(this, 'idUstComment', 200)"></textarea>
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
	<form id="udtFormId" name="udtForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/udtMasterStockCompany" method="post" onkeypress="return captureReturnKey(event);">
	  <div class="row">
	  	<div class="col-sm-3 col-md-3">
			<label class="control-label">종목코드</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
		  		<input id="mscCodeId" class="form-control" type="text" name="mscCode" placeholder="삼성전자" autocomplete="off" />
		  	</div>
		</div>
	  	<div class="col-sm-3 col-md-3">
	  		<label class="control-label">종목이름</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-th-list" aria-hidden="true"></span></span>
		  		<input id="mscNameId" class="form-control" type="text" name="mscName" placeholder="삼성전자" autocomplete="off" />
		  	</div>
	  	</div>
	  	<div class="col-sm-3 col-md-2">	
			<label class="control-label">당기순이익(억원)</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="mscProfitId" class="form-control" type="text" name="mscProfit" maxlength="10" size="10" placeholder="2000" onkeypress="return isNumber(event)"/>
		  	</div>
	  	</div>
	  	<div class="col-sm-3 col-md-2">	
			<label class="control-label">주당배당금(원)</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="mscDividendId" class="form-control" type="text" name="mscDividend" maxlength="10" size="10" placeholder="100" onkeypress="return isNumber(event)"/>
		  	</div>
	  	</div>
	  	<div class="col-sm-3 col-md-2">	
			<label class="control-label">배당성향(%)</label>
		  	<div class="input-group" style="float:right; width: 100%;">
		  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-edit" aria-hidden="true"></span></span>
		  		<input id="mscPayoutRatioId" class="form-control" type="text" name="mscPayoutRatio" maxlength="10" size="10" placeholder="100" onkeypress="return isNumber(event)"/>
		  	</div>
	  	</div>
	  </div>
	  <div class="row">
		<div class="col-sm-12 col-md-12">
	  		<label class="control-label">코멘트</label> <span id="idUstComment">0</span>/200
	  		<textarea id="mscCommentId" class="taForm" style="height: 50px;" name="ustComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUstComment', 200)" onfocus="checkByteLength(this, 'idUstComment', 200)"></textarea>
		</div>
	  </div>
	  <input type="hidden" id="mscNoId" name="mscNo" />
	  <input type="hidden" id="tokenId" name="token" />
	  <br/>
	  <p align="center">
			<button type="button" class="btn btn-primary" onclick="return confirmData('udtFormId');">재무정보</button>
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
	    <#if plugins.masterStockCompanyList?has_content>
	    <#list plugins.masterStockCompanyList as masterStockCompany>
		    <ul class="table-ul bg-color ul-hover ul-table" onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);" onclick="selectMasterStockCompany(this, '${masterStockCompany.mscNo?if_exists}');">
		    	<li style="width: 30px;">${masterStockCompany.mscNo?if_exists}</li>
		    	<li style="width: 150px;">${masterStockCompany.mscCode?if_exists}</li>
		    	<li style="width: 150px;">${masterStockCompany.mscName?if_exists}</li>
		    	<li style="width: 100px;"><#if masterStockCompany.mscProfit??>${masterStockCompany.mscProfit?if_exists}</#if></li>
	        	<li style="width: 100px;"><#if masterStockCompany.mscDividend??>${masterStockCompany.mscDividend?if_exists}</#if></li>
	        	<li style="width: 100px;"><#if masterStockCompany.mscPayoutRatio??>${masterStockCompany.mscPayoutRatio?if_exists}</#if></li>
		        <li style="width: 100px;"><#if masterStockCompany.updateTime??>${masterStockCompany.insertTime?string('yyyy-MM-dd hh:mm:ss')?if_exists}</#if></li>
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


</@layout.myLayout>