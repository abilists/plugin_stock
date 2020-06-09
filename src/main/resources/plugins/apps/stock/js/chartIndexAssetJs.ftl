<#import "/spring.ftl" as spring/>
var color = Chart.helpers.color;
var data1 = {
	labels: [
	    <#if plugins.stockCompanyForChartList?has_content>
	    <#list plugins.stockCompanyForChartList as stockCompanyForChart>
	    <#if stockCompanyForChart.ustClassify == "1">
		"${stockCompanyForChart.uscName?if_exists}"<#if stockCompanyForChart?has_next>,</#if>
		</#if>
	    </#list>
		</#if>
		],
	datasets: [{
		label: '매수 총가격',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderWidth: 2,
		borderColor: window.chartColors.red,
		data: [
		    <#if plugins.stockCompanyForChartList?has_content>
		    <#list plugins.stockCompanyForChartList as stockCompanyForChart>
		    <#if stockCompanyForChart.ustClassify == "1">
			"${stockCompanyForChart.costCnt?c?if_exists}"<#if stockCompanyForChart?has_next>,</#if>
			</#if>
		    </#list>
			</#if>
		]
	}, {
		label: '매도 총가격',
		backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
		borderWidth: 2,
		borderColor: window.chartColors.blue,
		data: [
		    <#if plugins.stockCompanyForChartList?has_content>
		    <#list plugins.stockCompanyForChartList as stockCompanyForChart>
		    <#if stockCompanyForChart.ustClassify == "2">
			"${stockCompanyForChart.costCnt?c?if_exists}"<#if stockCompanyForChart?has_next>,</#if>
			</#if>
		    </#list>
			</#if>
		]
	}]
};

var option1 = {
	responsive: true,
	legend: {
		position: 'top',
	},
	title: {
		display: true,
		text: '각 종목의 매매금액'
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
				labelString: '종목이름'
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

var ctx = document.getElementById("canvas1").getContext("2d");
var myReportsBar = new Chart(ctx, {
    type: 'bar',
    data: data1,
    options: option1
});
