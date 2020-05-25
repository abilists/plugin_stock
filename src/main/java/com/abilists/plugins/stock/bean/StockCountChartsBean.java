package com.abilists.plugins.stock.bean;

public class StockCountChartsBean {

	private int saleBuyCost;
	private int saleBuyCount;
	
	private int saleSellCost;
	private int saleSellCount;
	
	private int saleLeftCount;

	public int getSaleBuyCost() {
		return saleBuyCost;
	}
	public void setSaleBuyCost(int saleBuyCost) {
		this.saleBuyCost = saleBuyCost;
	}
	public int getSaleSellCost() {
		return saleSellCost;
	}
	public void setSaleSellCost(int saleSellCost) {
		this.saleSellCost = saleSellCost;
	}
	public int getSaleBuyCount() {
		return saleBuyCount;
	}
	public void setSaleBuyCount(int saleBuyCount) {
		this.saleBuyCount = saleBuyCount;
	}
	public int getSaleSellCount() {
		return saleSellCount;
	}
	public void setSaleSellCount(int saleSellCount) {
		this.saleSellCount = saleSellCount;
	}
	public int getSaleLeftCount() {
		return saleLeftCount;
	}
	public void setSaleLeftCount(int saleLeftCount) {
		this.saleLeftCount = saleLeftCount;
	}

}
