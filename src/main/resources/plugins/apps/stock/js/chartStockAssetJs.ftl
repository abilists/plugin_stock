<#import "/spring.ftl" as spring/>
var color = Chart.helpers.color;
var data4 = {
	labels: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>
		"${key?if_exists}"<#if key?has_next>,</#if>
	    </#list>
		</#if>
		],
	datasets: [{
		label: '매수금액',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderWidth: 2,
		data: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>

		<#assign buyMoney = -plugins.mapStockChart[key].saleBuyCost * plugins.mapStockChart[key].saleBuyCount>
		"${buyMoney?c?if_exists}"<#if key?has_next>,</#if>

	    </#list>
		</#if>
		]
	}, {
		label: '매도금액',
		backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
		borderWidth: 2,
		data: [
	    <#if plugins.mapStockChart??>
		<#list plugins.mapStockChart?keys as key>

		<#assign sellMoney = -plugins.mapStockChart[key].saleSellCost * plugins.mapStockChart[key].saleSellCount>
		"${sellMoney?c?if_exists}"<#if key?has_next>,</#if>

	    </#list>
		</#if>
		]
	}]
};

var option4 = {
	responsive: true,
	legend: {
		position: 'top',
	},
	title: {
		display: true,
		text: '현금기준 매매금액'
	},
	tooltips: {
		mode: 'index',
		intersect: false
	},
	scales: {
		xAxes: [{
			barThickness: 50,
			scaleLabel: {
				display: true,
				labelString: '매매날짜'
			}
		}],
		yAxes: [{
			barThickness: 50,
			scaleLabel: {
				display: true,
				labelString: '매매금액'
			},
		    ticks: {
		        beginAtZero: true,
		        callback: function(value, index) {
		        	if(value.toString().length > 8) { 
		        		return (Math.floor(value / 100000000)).toLocaleString("ko-KR") + "억";
		        	} else if(value.toString().length > 4) { 
		            	return (Math.floor(value / 10000)).toLocaleString("ko-KR") + "만";
		        	} else { 
		            	return value.toLocaleString("ko-KR");
		        	}
		        }
		    }
		}]
	}
};

var ctx = document.getElementById("canvas4").getContext("2d");
var myReportsBar = new Chart(ctx, {
    type: 'bar',
    data: data4,
    options: option4
});

