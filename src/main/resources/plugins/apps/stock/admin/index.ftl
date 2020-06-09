<#import "/apps/admin/layout/abilistsAdminLayout.ftl" as layout>
<#import "/spring.ftl" as spring/>
<@layout.myLayout>

<style>

</style>

<div class="item-box" style="margin-top: 15px;">
<div class="row">
	<div class="col-md-8">
		<h3>
			<ol class="breadcrumb-std">
			  <li><a href="/admin/"><@spring.message "admin.menu.plugins"/></a></li>
			  <li class="active">주식 관리자 화면</li>
			</ol>
		</h3>
	</div>
	<div class="col-md-4">

	</div>
</div>
</div>

<div class="row">
  <div class="col-md-12">
	<#include "/apps/common/errorMessage.ftl"/>
	<#include "/apps/common/abilistsSuccess.ftl"/>

<!-- Start to write code ---->
	<div id="userSampleId" style="margin: 10px;">
		<div id="timeTableId" style="border: 1px solid #CDCDCD;">
		<div>
	    <ul class="table-ul table-ul-header">
	    	<li style="width: 30px;">No</li>
	        <li style="width: 150px;">종목코드</li>
	    	<li style="width: 150px;">종목이름</li>
	        <li style="width: 100px;">당기순이익(억원)</li>
	        <li style="width: 100px;">주당배당금(원)</li>
	        <li style="width: 100px;">배당성향(%)</li>
	        <li style="width: 100px;">입력한 날짜</li>
	    </ul>
	    <#if plugins??>
	    <#if plugins.stockCompanyList?has_content>
	    <#list plugins.stockCompanyList as stockCompany>
		    <ul class="table-ul bg-color ul-hover ul-table" onmouseover="overChangeColor(this);" onmouseout="outChangeColor(this);" onclick="selectStockCompany(this, '${stockCompany.uscNo?if_exists}');">
		    	<li style="width: 30px;">${stockCompany.uscNo?if_exists}</li>
		    	<li style="width: 150px;">${stockCompany.uscCode?if_exists}</li>
		    	<li style="width: 150px;">${stockCompany.uscName?if_exists}</li>
		    	<li style="width: 100px;"><#if stockCompany.uscProfit??>${stockCompany.uscProfit?if_exists}</#if></li>
	        	<li style="width: 100px;"><#if stockCompany.uscDividend??>${stockCompany.uscDividend?if_exists}</#if></li>
	        	<li style="width: 100px;"><#if stockCompany.uscPayoutRatio??>${stockCompany.uscPayoutRatio?if_exists}</#if></li>
		        <li style="width: 100px;"><#if stockCompany.updateTime??>${stockCompany.updateTime?string('yyyy-MM-dd hh:mm:ss')?if_exists}</#if></li>
		    </ul>
		</#list>
		</#if>
		</#if>
		</div>
		</div>
	</div>
<!-- Stop to write code ---->

	<nav class="text-center">
    <ul class="pagination">
	    <#if model?exists>
	  	<#if model.paging?exists>
			<#if model.paging.prevPage?exists>
			<li><a href="/admin/plugins/stock?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="/admin/plugins/stock?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="/admin/plugins/stock?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
		</#if>
	</ul>
	</nav><!-- end #nav -->

  </div><!-- #col-md-12 -->
</div><!-- #row -->

<#include "/apps/common/abilistsAdminLoadJs.ftl"/>

</@layout.myLayout>