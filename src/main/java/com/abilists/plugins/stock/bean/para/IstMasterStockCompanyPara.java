package com.abilists.plugins.stock.bean.para;

import java.util.Date;

import base.bean.para.CommonPara;

public class IstMasterStockCompanyPara extends CommonPara {

	private String mscCode;
	private String mscName;
	private String mscProfit;
	private String mscDividend;
	private String mscPayoutRatio;
	private String mscComment;
	private String mscStatus;

	public String getMscCode() {
		return mscCode;
	}
	public void setMscCode(String mscCode) {
		this.mscCode = mscCode;
	}
	public String getMscName() {
		return mscName;
	}
	public void setMscName(String mscName) {
		this.mscName = mscName;
	}
	public String getMscProfit() {
		return mscProfit;
	}
	public void setMscProfit(String mscProfit) {
		this.mscProfit = mscProfit;
	}
	public String getMscDividend() {
		return mscDividend;
	}
	public void setMscDividend(String mscDividend) {
		this.mscDividend = mscDividend;
	}
	public String getMscPayoutRatio() {
		return mscPayoutRatio;
	}
	public void setMscPayoutRatio(String mscPayoutRatio) {
		this.mscPayoutRatio = mscPayoutRatio;
	}
	public String getMscComment() {
		return mscComment;
	}
	public void setMscComment(String mscComment) {
		this.mscComment = mscComment;
	}
	public String getMscStatus() {
		return mscStatus;
	}
	public void setMscStatus(String mscStatus) {
		this.mscStatus = mscStatus;
	}

}
