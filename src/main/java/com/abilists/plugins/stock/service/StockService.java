package com.abilists.plugins.stock.service;

import java.util.List;

import com.abilists.core.service.PagingService;
import com.abilists.plugins.stock.bean.model.PluginsMStockCompanyModel;
import com.abilists.plugins.stock.bean.model.PluginsUserStockModel;
import com.abilists.plugins.stock.bean.para.DltMStockCompanyPara;
import com.abilists.plugins.stock.bean.para.DltStockPara;
import com.abilists.plugins.stock.bean.para.IstMStockCompanyPara;
import com.abilists.plugins.stock.bean.para.IstStockPara;
import com.abilists.plugins.stock.bean.para.SltMStockCompanyPara;
import com.abilists.plugins.stock.bean.para.SltStockPara;
import com.abilists.plugins.stock.bean.para.UdtMStockCompanyPara;
import com.abilists.plugins.stock.bean.para.UdtStockPara;

import base.bean.para.CommonPara;

public interface StockService extends PagingService {

	// Company List
	public List<PluginsMStockCompanyModel> sltMStockCompanyList(CommonPara commonPara) throws Exception;
	public PluginsMStockCompanyModel sltMStockCompany(SltMStockCompanyPara sltMStockCompanyPara) throws Exception;

	// Stock List
	public List<PluginsUserStockModel> sltStockList(SltStockPara sltStockPara) throws Exception;
	public PluginsUserStockModel sltStock(SltStockPara sltStockPara) throws Exception;

//	public List<PluginsUserStockModel> srhUserStockList(SrhAutoCompletePara srhAutoCompletePara) throws Exception;
//	public List<StockModel> srhStockCompanyList(SrhAutoCompletePara srhAutoCompletePara) throws Exception;

	public int sltMasterStockCompanySum(CommonPara commonPara) throws Exception;
	public int sltStockSum(CommonPara commonPara) throws Exception;
	
	public boolean istMStockCompany(IstMStockCompanyPara istMasterStockCompanyPara) throws Exception;
	public boolean istStock(IstStockPara istStockPara) throws Exception;

	public boolean udtMStockCompany(UdtMStockCompanyPara udtMasterStockCompanyPara) throws Exception;
	public boolean udtStock(UdtStockPara udtStockPara) throws Exception;

	public boolean dltMStockCompany(DltMStockCompanyPara dltMasterStockCompanyPara) throws Exception;
	public boolean dltStock(DltStockPara dltStockPara) throws Exception;

}
