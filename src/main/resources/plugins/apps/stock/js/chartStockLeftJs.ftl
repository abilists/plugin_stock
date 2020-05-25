<#import "/spring.ftl" as spring/>
var data3 = {
	title: {
		display: true,
		text: 'Bar Chart'
	},
	labels: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${key?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		],
	datasets: [{
		label: '주식수',
		fill: false,
		backgroundColor: window.chartColors.red,
		borderColor: window.chartColors.red,
		data: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${plugins.mapStockChart[key].saleLeftCount?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		]
	}],
	borderWidth: 1
};
var option3 = {
	responsive: true,
	title: {
		display: true,
		text: '나머지 주식수'
	},
	tooltips: {
		mode: 'index',
		intersect: false,
	},
	hover: {
		mode: 'nearest',
		intersect: true
	},
	scales: {
        yAxes: [{
			stacked: true,
			scaleLabel: {
				display: true,
				labelString: '주식 수'
			}
		}],
        xAxes: [{
        	barThickness: 50,
			gridLines: {
				display: true
			},
			scaleLabel: {
				display: true,
				labelString: '주식 수'
			}
		}]
	}
};
var ctx = document.getElementById("canvas3").getContext("2d");
var myReportsBar = new Chart(ctx, {
    type: 'bar',
    data: data3,
    options: option3
});
