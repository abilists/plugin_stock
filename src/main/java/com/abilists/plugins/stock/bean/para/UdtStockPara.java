package com.abilists.plugins.stock.bean.para;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import base.bean.para.CommonPara;
import io.utility.validate.annotation.DateFormat;

public class UdtStockPara extends CommonPara {

	private String uscNo;

	@NotNull(message = "parameter.error.null.message")
	@Size(min = 9, max = 10, message = "parameter.error.size.max10.message")
	@DateFormat(format = "yyyy-MM-dd", message = "parameter.error.date.format.message")
	private String ustSaleDay;

	private String ustNo;
	private String ustClassify;
	private String uscName;
	private int ustSaleCost;
	private int ustSaleCnt;
	private int ustSaleFee;
	private String ustComment;
	private String ustStatus;

	public String getUscNo() {
		return uscNo;
	}
	public void setUscNo(String uscNo) {
		this.uscNo = uscNo;
	}
	public String getUstSaleDay() {
		return ustSaleDay;
	}
	public void setUstSaleDay(String ustSaleDay) {
		this.ustSaleDay = ustSaleDay;
	}
	public String getUstNo() {
		return ustNo;
	}
	public void setUstNo(String ustNo) {
		this.ustNo = ustNo;
	}
	public String getUstClassify() {
		return ustClassify;
	}
	public void setUstClassify(String ustClassify) {
		this.ustClassify = ustClassify;
	}
	public String getUscName() {
		return uscName;
	}
	public void setUscName(String uscName) {
		this.uscName = uscName;
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
	public int getUstSaleFee() {
		return ustSaleFee;
	}
	public void setUstSaleFee(int ustSaleFee) {
		this.ustSaleFee = ustSaleFee;
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
