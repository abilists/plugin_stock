package com.abilists.plugins.stock.bean.para;

import base.bean.para.CommonPara;

public class SltStockPara extends CommonPara {

	private String mscNo;
	private String ustNo;
	private String ustSaleDay;
	
	public String getMscNo() {
		return mscNo;
	}

	public void setMscNo(String mscNo) {
		this.mscNo = mscNo;
	}

	public String getUstNo() {
		return ustNo;
	}

	public void setUstNo(String ustNo) {
		this.ustNo = ustNo;
	}

	public String getUstSaleDay() {
		return ustSaleDay;
	}

	public void setUstSaleDay(String ustSaleDay) {
		this.ustSaleDay = ustSaleDay;
	}

}
