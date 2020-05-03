<#import "/apps/layout/plugins/abilistsPluginsLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<div class="row">
<div class="col-sm-12">
	<div class="caption mittle-size-title middle-works-bg">
		<h5>
			<b>샘플 제목</b>
			<span id="newToggleId" class="glyphicon glyphicon-chevron-down right-symbol-works-button" aria-hidden="true" onClick="newFormToggle();"></span>
		</h5>
	</div>
	<div class="item-box" style="overflow: hidden;">

		<#include "/apps/common/errorMessage.ftl"/>
		<#include "/apps/common/abilistsSuccess.ftl"/>

		<div id="newMdataFormId" class="item-box">
			<form name="newForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/istStock" method="post" id="newFormId" onkeypress="return captureReturnKey(event);">
		  	  <div class="row">
		  	  	<div class="col-sm-3 col-md-3">
		  	  		<label class="control-label">구분</label>
					<select id="utrKindId" class="form-control" name="ustClassify" >
						<option value="1">매수</option>
						<option value="2">매도</option>
						<option value="3">기타</option>
				    </select>
		  	  	</div>
		  	  	<div class="col-sm-3 col-md-3">
		  	  		<label class="control-label">종목이름</label>
				  	<div class="input-group" style="float:right; width: 100%;">
				  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
				  		<input class="form-control" type="text" name="ustName" placeholder="삼성전자" autocomplete="off" />
				  	</div>
		  	  	</div>
		  	  	<div class="col-sm-3 col-md-3">	
		  			<label class="control-label">1주당 가격</label>
				  	<div class="input-group" style="float:right; width: 100%;">
				  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-time" aria-hidden="true"></span></span>
				  		<input class="form-control" type="text" name="ustSaleCost" maxlength="12" size="12" placeholder="2000" />
				  	</div>
			  	</div>
		  	  	<div class="col-sm-3 col-md-3">	
		  			<label class="control-label">매매 주식수</label>
				  	<div class="input-group" style="float:right; width: 100%;">
				  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-time" aria-hidden="true"></span></span>
				  		<input class="form-control" type="text" name="ustSaleCnt" maxlength="12" size="12" placeholder="100" />
				  	</div>
			  	</div>
		  	  </div>
			  <div class="row">
			  	<div class="col-sm-12 col-md-12">
		  			<label class="control-label">코멘트</label> <span id="idUtrComment">0</span>/200
		  			<textarea class="taForm" style="height: 50px;" name="ustComment" placeholder="Add the detail information" rows="3" onkeyup="checkByteLength(this, 'idUtrComment', 200)" onfocus="checkByteLength(this, 'idUtrComment', 200)"></textarea>
			  	</div>
		  	  </div>
			  <input type="hidden" id="utrNoId" name="utrNo" />
			  <input type="hidden" id="tokenId" name="token" />
			  <br/>
				<p align="center">
			      <button type="button" class="btn btn-primary" onclick="return confirmData('updateFormId');">저장</button>
			      <button type="button" class="btn btn-primary" onClick="updateFormCancel();">취소</button>
				</p>
			</form>
		</div>

		<div id="udtMdataFormId" class="item-box" style="background-color: #efebe7;margin: 10px; display: none;">
		<form id="udtFormId" name="udtForm" class="form-horizontal" action="${configBean.contextPath?if_exists}/plugins/stock/udtStock" method="post" onkeypress="return captureReturnKey(event);">
			<div class="row">
		  	  	<div class="col-sm-12 col-md-12">	
		  			<label class="control-label">샘플 내용</label>
				  	<div class="input-group" style="float:right; width: 100%;">
				  		<span class="input-group-addon"><span id="calendarId" class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
				  		<input class="form-control" type="text" id="usmStockId" name="usmStock" placeholder="stock" autocomplete="off" />
				  	</div>
				</div>
				<input type="hidden" id="usmNoId" name="usmNo" />
				<input type="hidden" id="tokenId" name="token" />
				<br/>
				<p align="center">
			      <button type="button" class="btn btn-primary" onclick="return confirmData('udtFormId');">저장</button>
			      <button type="button" class="btn btn-primary" onClick="udtFormCancel();">취소</button>
			    </p>
			</div>
		</form>
		</div>

		<div id="userStockId" style="margin: 10px;">
			<div id="stockTableId" style="border: 1px solid #CDCDCD;">
			<div>
		    <ul class="table-ul table-ul-header ul-table ul-thead">
		    	<li style="width: 50px;">No</li>
		    	<li style="width: 500px;">샘플 내용</li>
		        <li style="width: 150px;">입력한 날짜</li>
		    </ul>
		    <#if plugins??>
		    <#if plugins.stockList?has_content>
		    <#list plugins.stockList as stock>
			    <ul class="table-ul bg-color ul-hover ul-table" style="width: 100%;" onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);" onclick="selectStock(this, '${stock.usmNo?if_exists}');">
			    	<li style="width: 50px;"><#if stock.usmNo??>${stock.usmNo?if_exists}</#if></li>
		        	<li style="width: 500px;"><#if stock.usmStock??>${stock.usmStock?if_exists}</#if></li>
			        <li style="width: 150px;"><#if stock.utrEndTime??>${stock.insertTime?string('yyyy-MM-dd hh:mm:ss')?if_exists}</#if></li>
			    </ul>
			</#list>
			</#if>
			</#if>
			</div>
			</div>
		</div>

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