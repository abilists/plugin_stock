package com.abilists.plugins.stock.bean.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import base.bean.model.BasicModel;

public class PluginsMStockCompanyStockMapModel extends BasicModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private long mscNo;
	private String mscCode;
	private String mscName;
	private int mscProfit;
	private int mscDividend;
	private int mscPayoutRatio;
	private String mscComment;
	private String mscStatus;
	private String mscDelete;
	private String userId;
	private Date insertTime;
	private Date updateTime;

	private List<UserStockModel> subUserStockList;
	
	public long getMscNo() {
		return mscNo;
	}
	public void setMscNo(long mscNo) {
		this.mscNo = mscNo;
	}
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
	public String getMscDelete() {
		return mscDelete;
	}
	public void setMscDelete(String mscDelete) {
		this.mscDelete = mscDelete;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getInsertTime() {
		return insertTime;
	}
	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public List<UserStockModel> getSubUserStockList() {
		return subUserStockList;
	}
	public void setSubUserStockList(List<UserStockModel> subUserStockList) {
		this.subUserStockList = subUserStockList;
	}

}