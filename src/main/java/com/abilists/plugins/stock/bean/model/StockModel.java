package com.abilists.plugins.stock.bean.model;

import java.io.Serializable;
import java.util.Date;

import base.bean.model.BasicModel;

public class StockModel extends BasicModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private long usmNo;
	private String usmStock;
  	private String usmStatus;
	private String userId;
	private Date insertTime;
	private Date updateTime;

	public long getUsmNo() {
		return usmNo;
	}
	public void setUsmNo(long usmNo) {
		this.usmNo = usmNo;
	}
	public String getUsmStock() {
		return usmStock;
	}
	public void setUsmStock(String usmStock) {
		this.usmStock = usmStock;
	}
	public String getUsmStatus() {
		return usmStatus;
	}
	public void setUsmStatus(String usmStatus) {
		this.usmStatus = usmStatus;
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