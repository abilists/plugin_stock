package com.abilists.plugins.stock.bean.para;

import base.bean.para.CommonPara;

public class SltStockPara extends CommonPara {

	private String uscNo;
	private String ustNo;
	private String ustSaleDay;
	
	public String getMscNo() {
		return uscNo;
	}

	public void setMscNo(String uscNo) {
		this.uscNo = uscNo;
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
