package com.abilists.plugins.stock.bean.model;

import java.io.Serializable;
import java.util.Date;

import base.bean.model.BasicModel;

public class PluginsUserStockModel extends BasicModel implements Cloneable, Serializable {

	private static final long serialVersionUID = 1L;

	private long ustNo;
	private Date ustSaleDay;
	private String ustClassify;
	private int ustSaleCost;
	private int ustSaleCnt;
	private int ustSaleFee;
	private long ustStockCnt;
	private String ustComment;
	private String ustStatus;
	private String ustDelete;
	private String userId;
	private Date insertTime;
	private Date updateTime;

	public long getUstNo() {
		return ustNo;
	}
	public void setUstNo(long ustNo) {
		this.ustNo = ustNo;
	}
	public Date getUstSaleDay() {
		return ustSaleDay;
	}
	public void setUstSaleDay(Date ustSaleDay) {
		this.ustSaleDay = ustSaleDay;
	}
	public String getUstClassify() {
		return ustClassify;
	}
	public void setUstClassify(String ustClassify) {
		this.ustClassify = ustClassify;
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
	public long getUstStockCnt() {
		return ustStockCnt;
	}
	public void setUstStockCnt(long ustStockCnt) {
		this.ustStockCnt = ustStockCnt;
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
	public String getUstDelete() {
		return ustDelete;
	}
	public void setUstDelete(String ustDelete) {
		this.ustDelete = ustDelete;
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

    @Override
    public Object clone() throws CloneNotSupportedException {
    	//CloneNotSupportedException 처리
    	return super.clone();
    }
}