package com.abilists.plugins.stock.bean;

import java.util.List;
import java.util.Map;

import com.abilists.plugins.stock.bean.model.PluginsUserStockCompanyModel;
import com.abilists.plugins.stock.bean.model.PluginsUserStockModel;

import base.bean.model.CommonModel;

public class PluginsModel extends CommonModel {

	private PluginsUserStockCompanyModel mStockCompany;
	private List<PluginsUserStockCompanyModel> mStockCompanyList;

	private PluginsUserStockModel userStock;
	private List<PluginsUserStockModel> userStockList;
	private Map<String, StockCountChartsBean> mapStockChart;

	public PluginsUserStockCompanyModel getmStockCompany() {
		return mStockCompany;
	}
	public void setmStockCompany(PluginsUserStockCompanyModel mStockCompany) {
		this.mStockCompany = mStockCompany;
	}
	public List<PluginsUserStockCompanyModel> getmStockCompanyList() {
		return mStockCompanyList;
	}
	public void setmStockCompanyList(List<PluginsUserStockCompanyModel> mStockCompanyList) {
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
