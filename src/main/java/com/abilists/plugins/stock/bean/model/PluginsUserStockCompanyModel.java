package com.abilists.plugins.stock.bean.model;

import java.io.Serializable;
import java.util.Date;

import base.bean.model.BasicModel;

public class PluginsUserStockCompanyModel extends BasicModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private long uscNo;
	private String uscCode;
	private String uscName;
	private String uscProfit;
	private String uscDividend;
	private String uscPayoutRatio;
	private String uscComment;
	private String uscStatus;
	private String uscDelete;
	private String userId;
	private Date insertTime;
	private Date updateTime;

	public long getUscNo() {
		return uscNo;
	}
	public void setUscNo(long uscNo) {
		this.uscNo = uscNo;
	}
	public String getUscCode() {
		return uscCode;
	}
	public void setUscCode(String uscCode) {
		this.uscCode = uscCode;
	}
	public String getUscName() {
		return uscName;
	}
	public void setUscName(String uscName) {
		this.uscName = uscName;
	}
	public String getUscProfit() {
		return uscProfit;
	}
	public void setUscProfit(String uscProfit) {
		this.uscProfit = uscProfit;
	}
	public String getUscDividend() {
		return uscDividend;
	}
	public void setUscDividend(String uscDividend) {
		this.uscDividend = uscDividend;
	}
	public String getUscPayoutRatio() {
		return uscPayoutRatio;
	}
	public void setUscPayoutRatio(String uscPayoutRatio) {
		this.uscPayoutRatio = uscPayoutRatio;
	}
	public String getUscComment() {
		return uscComment;
	}
	public void setUscComment(String uscComment) {
		this.uscComment = uscComment;
	}
	public String getUscStatus() {
		return uscStatus;
	}
	public void setUscStatus(String uscStatus) {
		this.uscStatus = uscStatus;
	}
	public String getUscDelete() {
		return uscDelete;
	}
	public void setUscDelete(String uscDelete) {
		this.uscDelete = uscDelete;
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

}