package com.abilists.plugins.stock.bean;

import java.util.List;

import com.abilists.plugins.stock.bean.model.PluginsMStockCompanyModel;
import com.abilists.plugins.stock.bean.model.UserStockModel;

import base.bean.model.CommonModel;

public class PluginsModel extends CommonModel {

	private UserStockModel Stock;
	private List<UserStockModel> StockList;
	
	private PluginsMStockCompanyModel masterStockCompany;
	private List<PluginsMStockCompanyModel> masterStockCompanyList;

	public UserStockModel getStock() {
		return Stock;
	}
	public void setStock(UserStockModel Stock) {
		this.Stock = Stock;
	}
	public List<UserStockModel> getStockList() {
		return StockList;
	}
	public void setStockList(List<UserStockModel> StockList) {
		this.StockList = StockList;
	}
	public PluginsMStockCompanyModel getMasterStockCompany() {
		return masterStockCompany;
	}
	public void setMasterStockCompany(PluginsMStockCompanyModel masterStockCompany) {
		this.masterStockCompany = masterStockCompany;
	}
	public List<PluginsMStockCompanyModel> getMasterStockCompanyList() {
		return masterStockCompanyList;
	}
	public void setMasterStockCompanyList(List<PluginsMStockCompanyModel> masterStockCompanyList) {
		this.masterStockCompanyList = masterStockCompanyList;
	}

}
