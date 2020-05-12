package com.abilists.plugins.stock.bean.model;

import java.io.Serializable;

import base.bean.model.BasicModel;

public class StockCompanyModel extends BasicModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private String ustName;
	private int sumSaleCost;
	private int sumSaleCnt;

	public String getUstName() {
		return ustName;
	}
	public void setUstName(String ustName) {
		this.ustName = ustName;
	}
	public int getSumSaleCost() {
		return sumSaleCost;
	}
	public void setSumSaleCost(int sumSaleCost) {
		this.sumSaleCost = sumSaleCost;
	}
	public int getSumSaleCnt() {
		return sumSaleCnt;
	}
	public void setSumSaleCnt(int sumSaleCnt) {
		this.sumSaleCnt = sumSaleCnt;
	}

}