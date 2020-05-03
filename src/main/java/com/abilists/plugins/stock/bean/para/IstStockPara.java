package com.abilists.plugins.stock.bean.para;

import base.bean.para.CommonPara;

public class IstStockPara extends CommonPara {

	private String ustClassify;
	private String ustCode;
	private String ustName;
	private int ustSaleCost;
	private int ustSaleCnt;
	private String ustComment;
	private String ustStatus;

	public String getUstClassify() {
		return ustClassify;
	}
	public void setUstClassify(String ustClassify) {
		this.ustClassify = ustClassify;
	}
	public String getUstCode() {
		return ustCode;
	}
	public void setUstCode(String ustCode) {
		this.ustCode = ustCode;
	}
	public String getUstName() {
		return ustName;
	}
	public void setUstName(String ustName) {
		this.ustName = ustName;
	}
	public int getUstSaleCost() {
		return ustSaleCost;
	}
	public void setUstSaleCost(int ustSaleCost) {
		this.ustSaleCost = ustSaleCost;
	}
	public int getUstSaleCnt() {
		return ustSaleCnt;
	}
	public void setUstSaleCnt(int ustSaleCnt) {
		this.ustSaleCnt = ustSaleCnt;
	}
	public String getUstComment() {
		return ustComment;
	}
	public void setUstComment(String ustComment) {
		this.ustComment = ustComment;
	}
	public String getUstStatus() {
		return ustStatus;
	}
	public void setUstStatus(String ustStatus) {
		this.ustStatus = ustStatus;
	}

}
