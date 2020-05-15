package com.abilists.plugins.stock.service;

import java.util.List;

import com.abilists.bean.para.admin.SrhAutoCompletePara;
import com.abilists.core.service.PagingService;
import com.abilists.plugins.stock.bean.model.PluginsMStockCompanyModel;
import com.abilists.plugins.stock.bean.model.UserStockModel;
import com.abilists.plugins.stock.bean.para.DltMasterStockCompanyPara;
import com.abilists.plugins.stock.bean.para.DltStockPara;
import com.abilists.plugins.stock.bean.para.IstMasterStockCompanyPara;
import com.abilists.plugins.stock.bean.para.IstStockPara;
import com.abilists.plugins.stock.bean.para.SltMasterStockCompanyPara;
import com.abilists.plugins.stock.bean.para.SltStockPara;
import com.abilists.plugins.stock.bean.para.UdtMasterStockCompanyPara;
import com.abilists.plugins.stock.bean.para.UdtStockPara;

import base.bean.para.CommonPara;

public interface StockService extends PagingService {

	public List<PluginsMStockCompanyModel> sltMasterStockCompanyList(CommonPara commonPara) throws Exception;
	public PluginsMStockCompanyModel sltMasterStockCompany(SltMasterStockCompanyPara sltMasterStockCompanyPara) throws Exception;

	public UserStockModel sltStock(SltStockPara sltStockPara) throws Exception;
	public List<UserStockModel> sltStockList(SltStockPara sltStockPara) throws Exception;
	public List<UserStockModel> srhStockList(SrhAutoCompletePara srhAutoCompletePara) throws Exception;
//	public List<StockModel> srhStockCompanyList(SrhAutoCompletePara srhAutoCompletePara) throws Exception;

	public int sltMasterStockCompanySum(CommonPara commonPara) throws Exception;
	public int sltStockSum(CommonPara commonPara) throws Exception;
	
	public boolean istMasterStockCompany(IstMasterStockCompanyPara istMasterStockCompanyPara) throws Exception;
	public boolean istStock(IstStockPara istStockPara) throws Exception;

	public boolean udtMasterStockCompany(UdtMasterStockCompanyPara udtMasterStockCompanyPara) throws Exception;
	public boolean udtStock(UdtStockPara udtStockPara) throws Exception;

	public boolean dltMasterStockCompany(DltMasterStockCompanyPara dltMasterStockCompanyPara) throws Exception;
	public boolean dltStock(DltStockPara dltStockPara) throws Exception;

}
