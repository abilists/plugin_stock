package com.abilists.plugins.stock.service;

import java.util.List;

import com.abilists.core.service.PagingService;
import com.abilists.plugins.stock.bean.model.StockModel;
import com.abilists.plugins.stock.bean.para.DltStockPara;
import com.abilists.plugins.stock.bean.para.IstStockPara;
import com.abilists.plugins.stock.bean.para.SltStockPara;
import com.abilists.plugins.stock.bean.para.UdtStockPara;

import base.bean.para.CommonPara;

public interface StockService extends PagingService {

	public StockModel sltStock(SltStockPara sltStockPara) throws Exception;
	public List<StockModel> sltStockList(SltStockPara sltStockPara) throws Exception;
	public int sltStockSum(CommonPara commonPara) throws Exception;

	public boolean istStock(IstStockPara istStockPara) throws Exception;
	public boolean udtStock(UdtStockPara udtStockPara) throws Exception;
	public boolean dltStock(DltStockPara dltStockPara) throws Exception;

}
