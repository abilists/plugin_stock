package com.abilists.plugins.stock.bean;

import java.util.Map;

public class UserStockChartsBean {

	private Map<String, Integer> saleBuyMap;
	private Map<String, Integer> saleSellMap;

	public Map<String, Integer> getSaleBuyMap() {
		return saleBuyMap;
	}
	public void setSaleBuyMap(Map<String, Integer> saleBuyMap) {
		this.saleBuyMap = saleBuyMap;
	}
	public Map<String, Integer> getSaleSellMap() {
		return saleSellMap;
	}
	public void setSaleSellMap(Map<String, Integer> saleSellMap) {
		this.saleSellMap = saleSellMap;
	}

}
