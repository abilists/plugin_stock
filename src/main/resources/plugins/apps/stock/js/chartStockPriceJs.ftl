<#import "/spring.ftl" as spring/>

var data1 = {
	labels: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${key?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		],
	datasets: [{
		type: 'line',
		label: '매수 가격',
		borderWidth: 3,
		fill: false,
		backgroundColor: window.chartColors.red,
		borderColor: window.chartColors.red,
		data: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${plugins.mapStockChart[key].saleBuyCost?c?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		]
	}, {
		type: 'line',
		label: '매도 가격',
		borderWidth: 3,
		fill: false,
		backgroundColor: window.chartColors.blue,
		borderColor: window.chartColors.blue,
		data: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${plugins.mapStockChart[key].saleSellCost?c?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		]
	}]
};

var option1 = {
	responsive: true,
	title: {
		display: true,
		text: '매수와 매도(1주 가격)'
	},
	tooltips: {
		mode: 'index',
		intersect: true,
	},
	hover: {
		mode: 'nearest',
		intersect: true
	},
	scales: {
		xAxes: [{
			display: true,
			scaleLabel: {
				display: true,
				labelString: '주식수'
			}
		}],
		yAxes: [{
			display: true,
			scaleLabel: {
				display: true,
				labelString: '1주당 가격'
			},
			ticks: {
				min: 0
			}
		}]
	}
};

var ctx = document.getElementById("canvas1").getContext("2d");
var myReportsBar = new Chart(ctx, {
    type: 'line',
    data: data1,
    options: option1
});
