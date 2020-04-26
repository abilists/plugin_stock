package com.abilists.plugins.stock.admin.service;

import java.util.List;

import com.abilists.core.service.PagingService;
import com.abilists.plugins.stock.bean.model.StockModel;

import base.bean.para.CommonPara;

public interface AdminStockService extends PagingService {

	public List<StockModel> sltStockList(CommonPara commonPara) throws Exception;
	public int sltStockSum(CommonPara commonPara) throws Exception;

}