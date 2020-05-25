<#import "/spring.ftl" as spring/>
var barChartData = {
	labels: [
		<#if model??>
		<#if model.userTasksBeanList?has_content>
			<#list model.userTasksBeanList[0].userTasksStatusMap?keys as key>
				'${userStock.insertTime?string('yyyy/MM/dd')?if_exists}'<#if key?has_next>,</#if>
			</#list>
		</#if>
		</#if>
		],
	datasets: [
		<#if model??>
		<#if model.userTasksBeanList?has_content>
			<#list model.userTasksBeanList as userTasksBean>
			{
				label: '${userTasksBean.statusName?if_exists}',
				backgroundColor: ${userTasksBean.color?if_exists},
				data: [
					<#list userTasksBean.userTasksStatusMap?keys as key>
						${userTasksBean.userTasksStatusMap[key]?if_exists?c} <#if key?has_next>,</#if>
					</#list>
				]
			}<#if userTasksBean?has_next>,</#if>
			</#list>
		</#if>
		</#if>
	]
};

var option = {
		maintainAspectRatio: false,
		spanGaps: false,
		responsive: true,
	    title:{
	        display:false,
	        text:"Stacked Chart"
	    },
	    tooltips: {
	    	mode: 'index',
			intersect: false
	    },
		scales: {
			xAxes: [{
				barThickness: 50,
				stacked: true,
			}],
			yAxes: [{
				stacked: true
			}]
		}

	};

var ctx = document.getElementById("myTasksBar").getContext("2d");
var myProjectsBar = new Chart(ctx, {
    type: 'bar',
    data: barChartData,
    options: option
});
