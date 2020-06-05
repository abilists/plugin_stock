package com.abilists.plugins.stock.bean.para;

import base.bean.para.CommonPara;

public class DltStockPara extends CommonPara {

	private int uscNo;
	private int ustNo;

	public int getMscNo() {
		return uscNo;
	}
	public void setMscNo(int uscNo) {
		this.uscNo = uscNo;
	}
	public int getUstNo() {
		return ustNo;
	}
	public void setUstNo(int ustNo) {
		this.ustNo = ustNo;
	}

}
