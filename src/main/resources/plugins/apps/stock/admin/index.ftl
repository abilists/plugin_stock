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
			  <li class="active">샘플 관리자 화면</li>
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
	    	<li class="time-li6">아이디</li>
	    	<li class="time-li1">번호</li>
	        <li class="time-li2">쌤플</li>
	        <li class="time-li3">날짜</li>
	    </ul>
	    <#if plugins??>
	    <#if plugins.sampleList?has_content>
	    <#list plugins.sampleList as sample>
		    <ul class="table-ul bg-color ul-hover"">
		    	<li class="time-li6">${sample.userId?if_exists}</li>
			    <li class="time-li1">${sample.usmNo?if_exists}</li>
			    <li class="time-li2">${sample.usmSample?if_exists}</li>
			    <li class="time-li3">${sample.insertTime?string('yyyy-MM-dd HH:mm:ss')?if_exists}</li>
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
			<li><a href="/admin/plugins/sample?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="/admin/plugins/sample?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="/admin/plugins/sample?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
		</#if>
	</ul>
	</nav><!-- end #nav -->

  </div><!-- #col-md-12 -->
</div><!-- #row -->

<#include "/apps/common/abilistsAdminLoadJs.ftl"/>

</@layout.myLayout>