package com.abilists.plugins.stock.bean.model;

import java.io.Serializable;

import base.bean.model.BasicModel;

public class StockCompanyForChartModel extends BasicModel implements Cloneable, Serializable {

	private static final long serialVersionUID = 1L;

	private String uscName;
	private String ustClassify;
	private int costCnt;
	private int saleCost;
	private int saleCnt;
	private int cnt;

    public String getUscName() {
		return uscName;
	}


	public void setUscName(String uscName) {
		this.uscName = uscName;
	}


	public String getUstClassify() {
		return ustClassify;
	}


	public void setUstClassify(String ustClassify) {
		this.ustClassify = ustClassify;
	}


	public int getCostCnt() {
		return costCnt;
	}


	public void setCostCnt(int costCnt) {
		this.costCnt = costCnt;
	}


	public int getSaleCost() {
		return saleCost;
	}


	public void setSaleCost(int saleCost) {
		this.saleCost = saleCost;
	}


	public int getSaleCnt() {
		return saleCnt;
	}


	public void setSaleCnt(int saleCnt) {
		this.saleCnt = saleCnt;
	}


	public int getCnt() {
		return cnt;
	}


	public void setCnt(int cnt) {
		this.cnt = cnt;
	}


	@Override
    public Object clone() throws CloneNotSupportedException {
    	//CloneNotSupportedException 처리
    	return super.clone();
    }
}