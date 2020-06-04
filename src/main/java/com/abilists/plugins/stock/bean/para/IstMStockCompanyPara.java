package com.abilists.plugins.stock.bean.para;

import base.bean.para.CommonPara;

public class IstMStockCompanyPara extends CommonPara {

	private String mscCode;
	private String mscName;
	private int mscProfit;
	private int mscDividend;
	private int mscPayoutRatio;
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
	public int getMscProfit() {
		return mscProfit;
	}
	public void setMscProfit(int mscProfit) {
		this.mscProfit = mscProfit;
	}
	public int getMscDividend() {
		return mscDividend;
	}
	public void setMscDividend(int mscDividend) {
		this.mscDividend = mscDividend;
	}
	public int getMscPayoutRatio() {
		return mscPayoutRatio;
	}
	public void setMscPayoutRatio(int mscPayoutRatio) {
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
