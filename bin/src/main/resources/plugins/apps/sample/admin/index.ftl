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
			  <li class="active">출퇴근 관리</li>
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
	    	<li class="time-li1">근무 종류</li>
	        <li class="time-li2">출근 날</li>
	        <li class="time-li3">출근 시간</li>
	        <li class="time-li4">퇴근 시간</li>
	        <li class="time-li5">근무한 시간</li>
	    </ul>
	    <#if plugins??>
	    <#if plugins.SampleList?has_content>
	    <#list plugins.SampleList as Sample>
		    <ul class="table-ul bg-color ul-hover"">
		    	<li class="time-li6">${Sample.userId?if_exists}</li>
			    <li class="time-li1">
			    <#if Sample.utrKind??>
				    <#if Sample.utrKind == "0">
				    		상근
				    <#elseif Sample.utrKind == "3">
				    		외근
				    <#elseif Sample.utrKind == "4">
				    		출장
				    <#elseif Sample.utrKind == "5">
				    		연수
				    <#elseif Sample.utrKind == "6">
				    		파견
				    <#elseif Sample.utrKind == "7">
				    		자택근무
				    <#elseif Sample.utrKind == "8">
				    		결근
				    <#elseif Sample.utrKind == "9">
				    		휴무
				    <#elseif Sample.utrKind == "10">
				    		휴가
				    <#elseif Sample.utrKind == "11">
				    		생리휴가
				    <#elseif Sample.utrKind == "12">
				    		대기
				    <#else>
				    		기타
				    </#if>
				<#else>
			    </#if>
			    </li>
			    <li class="time-li2"><#if Sample.utrWorkDay??>${Sample.utrWorkDay?string('yyyy-MM-dd')?if_exists}</#if></li>
		        <li class="time-li3"><#if Sample.utrStartTime??>${Sample.utrStartTime?string('HH:mm:ss')?if_exists}</#if></li>
		        <li class="time-li4"><#if Sample.utrEndTime??>${Sample.utrEndTime?string('HH:mm:ss')?if_exists}</#if></li>
		        <li class="time-li5"><#if Sample.utrWorkHour??>${Sample.utrWorkHour?if_exists}</#if></li>
		    </ul>
		    <ul style="list-style: none; padding: 0px;">
		    	<li style="padding: 10px;">
		    		${Sample.utrComment?if_exists}
		    	</li>
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
			<li><a href="/admin/plugins/Sample?nowPage=${model.paging.prevPage.nowPage}&allCount=${model.paging.allCount?c}" title="Prev" accesskey="*">Prev</span></a></li>
			</#if>
			<#if model.paging.pagingInfoList?has_content>
				<#list model.paging.pagingInfoList as pageList>
					<#if model.paging.nowPage?if_exists == pageList.pageNumber?if_exists>
					<li class="active"><a href="#">${pageList.pageNumber} <span class="sr-only">(current)</span></a></li>
					<#else>
					<li><a href="/admin/plugins/Sample?nowPage=${pageList.pageNumber}&allCount=${model.paging.allCount?c}">${pageList.pageNumber}</a></li>
					</#if>
				</#list>
			</#if>
			<#if model.paging.nextPage?exists>
			<li><a href="/admin/plugins/Sample?nowPage=${model.paging.nextPage.nowPage}&allCount=${model.paging.allCount?c}" accesskey="#" title="Next">Next</a></li>
			</#if>
		</#if>
		</#if>
	</ul>
	</nav><!-- end #nav -->

<!-- End to write code ---->

  </div><!-- #col-md-12 -->
</div><!-- #row -->

<#include "/apps/common/abilistsAdminLoadJs.ftl"/>

</@layout.myLayout>