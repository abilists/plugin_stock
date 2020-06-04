<#import "/spring.ftl" as spring/>

var data2 = {
	labels: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${key?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		],
	datasets: [{
		label: '매수 수',
		backgroundColor: window.chartColors.red,
		data: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${plugins.mapStockChart[key].saleBuyCount?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		]
	}, {
		label: '매도 수',
		backgroundColor: window.chartColors.blue,
		data: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${plugins.mapStockChart[key].saleSellCount?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		]
	}]
};

var option2 = {
	responsive: true,
	title: {
		display: true,
		text: '매수와 매도(주식 수)'
	},
	tooltips: {
		mode: 'index',
		intersect: false
	},
	scales: {
		xAxes: [{
			barThickness: 50,
			stacked: true,
			scaleLabel: {
				display: true,
				labelString: '매매날짜'
			}
		}],
		yAxes: [{
			stacked: true,
			scaleLabel: {
				display: true,
				labelString: '주식수'
			},
		}]
	}
};

var ctx = document.getElementById("canvas2").getContext("2d");
var myReportsBar = new Chart(ctx, {
    type: 'bar',
    data: data2,
    options: option2
});

