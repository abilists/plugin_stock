package com.abilists.plugins.stock.bean;

import java.util.List;
import java.util.Map;

import com.abilists.plugins.stock.bean.model.PluginsMStockCompanyModel;
import com.abilists.plugins.stock.bean.model.PluginsUserStockModel;

import base.bean.model.CommonModel;

public class PluginsModel extends CommonModel {

	private PluginsMStockCompanyModel mStockCompany;
	private List<PluginsMStockCompanyModel> mStockCompanyList;

	private PluginsUserStockModel userStock;
	private List<PluginsUserStockModel> userStockList;
	private Map<String, StockCountChartsBean> mapStockChart;

	public PluginsMStockCompanyModel getmStockCompany() {
		return mStockCompany;
	}
	public void setmStockCompany(PluginsMStockCompanyModel mStockCompany) {
		this.mStockCompany = mStockCompany;
	}
	public List<PluginsMStockCompanyModel> getmStockCompanyList() {
		return mStockCompanyList;
	}
	public void setmStockCompanyList(List<PluginsMStockCompanyModel> mStockCompanyList) {
		this.mStockCompanyList = mStockCompanyList;
	}
	public PluginsUserStockModel getUserStock() {
		return userStock;
	}
	public void setUserStock(PluginsUserStockModel userStock) {
		this.userStock = userStock;
	}
	public List<PluginsUserStockModel> getUserStockList() {
		return userStockList;
	}
	public void setUserStockList(List<PluginsUserStockModel> userStockList) {
		this.userStockList = userStockList;
	}
	public Map<String, StockCountChartsBean> getMapStockChart() {
		return mapStockChart;
	}
	public void setMapStockChart(Map<String, StockCountChartsBean> mapStockChart) {
		this.mapStockChart = mapStockChart;
	}

}
