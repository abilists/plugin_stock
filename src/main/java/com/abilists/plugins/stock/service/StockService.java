package com.abilists.plugins.stock.service;

import java.util.List;
import java.util.Map;

import com.abilists.bean.para.admin.SrhAutoCompletePara;
import com.abilists.core.service.PagingService;
import com.abilists.plugins.stock.bean.StockCountChartsBean;
import com.abilists.plugins.stock.bean.model.PluginsUserStockCompanyModel;
import com.abilists.plugins.stock.bean.model.PluginsUserStockModel;
import com.abilists.plugins.stock.bean.para.DltStockCompanyPara;
import com.abilists.plugins.stock.bean.para.DltStockPara;
import com.abilists.plugins.stock.bean.para.IstStockCompanyPara;
import com.abilists.plugins.stock.bean.para.IstStockPara;
import com.abilists.plugins.stock.bean.para.SltStockCompanyPara;
import com.abilists.plugins.stock.bean.para.SltStockPara;
import com.abilists.plugins.stock.bean.para.UdtStockCompanyPara;
import com.abilists.plugins.stock.bean.para.UdtStockPara;

import base.bean.para.CommonPara;

public interface StockService extends PagingService {

	// Company List
	public List<PluginsUserStockCompanyModel> sltStockCompanyList(CommonPara commonPara) throws Exception;
	public PluginsUserStockCompanyModel sltStockCompany(SltStockCompanyPara sltMStockCompanyPara) throws Exception;

	public Map<String, StockCountChartsBean> sltStockChartMap(SltStockPara sltStockPara) throws CloneNotSupportedException;

	// Stock List
	public List<PluginsUserStockModel> sltStockList(SltStockPara sltStockPara) throws Exception;
	public PluginsUserStockModel sltStock(SltStockPara sltStockPara) throws Exception;

	public int sltStockCompanySum(CommonPara commonPara) throws Exception;
	public int sltStockSum(SltStockPara sltStockPara) throws Exception;

	public List<PluginsUserStockCompanyModel> srhStockCompany(SrhAutoCompletePara srhAutoCompletePara) throws Exception;
	public List<PluginsUserStockCompanyModel> srhStockCompanyList(SrhAutoCompletePara srhAutoCompletePara) throws Exception;

	public boolean istStockCompany(IstStockCompanyPara istMasterStockCompanyPara) throws Exception;
	public boolean istStock(IstStockPara istStockPara) throws Exception;

	public boolean udtStockCompany(UdtStockCompanyPara udtMasterStockCompanyPara) throws Exception;
	public boolean udtStock(UdtStockPara udtStockPara) throws Exception;

	public boolean dltStockCompany(DltStockCompanyPara dltMasterStockCompanyPara) throws Exception;
	public boolean dltStock(DltStockPara dltStockPara) throws Exception;

}
