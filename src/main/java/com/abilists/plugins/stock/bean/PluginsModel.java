package com.abilists.plugins.stock.bean;

import java.util.List;

import com.abilists.plugins.stock.bean.model.StockModel;

import base.bean.model.CommonModel;

public class PluginsModel extends CommonModel {

	private StockModel Stock;
	private List<StockModel> StockList;

	public StockModel getStock() {
		return Stock;
	}
	public void setStock(StockModel Stock) {
		this.Stock = Stock;
	}
	public List<StockModel> getStockList() {
		return StockList;
	}
	public void setStockList(List<StockModel> StockList) {
		this.StockList = StockList;
	}

}
