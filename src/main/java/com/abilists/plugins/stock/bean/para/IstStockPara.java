package com.abilists.plugins.stock.bean.para;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import base.bean.para.CommonPara;
import io.utility.validate.annotation.DateFormat;

public class IstStockPara extends CommonPara {

	private String mscNo;
	private String mscName;

	@NotNull(message = "ustSaleDay")
	@Size(min = 9, max = 10, message = "It is different String size")
	@DateFormat(format = "yyyy-MM-dd", message = "Not right format for start of date")
	private String ustSaleDay;
	private String ustClassify;
	private int ustSaleCost;
	private int ustSaleCnt;
	private int ustSaleFee;
	private String ustComment;
	private String ustStatus;

	public String getMscNo() {
		return mscNo;
	}
	public void setMscNo(String mscNo) {
		this.mscNo = mscNo;
	}
	public String getUstSaleDay() {
		return ustSaleDay;
	}
	public void setUstSaleDay(String ustSaleDay) {
		this.ustSaleDay = ustSaleDay;
	}
	public String getUstClassify() {
		return ustClassify;
	}
	public void setUstClassify(String ustClassify) {
		this.ustClassify = ustClassify;
	}
	public String getMscName() {
		return mscName;
	}
	public void setMscName(String mscName) {
		this.mscName = mscName;
	}
	public int getUstSaleFee() {
		return ustSaleFee;
	}
	public void setUstSaleFee(int ustSaleFee) {
		this.ustSaleFee = ustSaleFee;
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
