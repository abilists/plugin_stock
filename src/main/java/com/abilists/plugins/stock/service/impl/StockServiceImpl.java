package com.abilists.plugins.stock.service.impl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.configuration.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.abilists.bean.para.admin.SrhAutoCompletePara;
import com.abilists.core.service.AbilistsAbstractService;
import com.abilists.plugins.stock.bean.StockCountChartsBean;
import com.abilists.plugins.stock.bean.model.PluginsUserStockCompanyModel;
import com.abilists.plugins.stock.bean.model.PluginsUserStockModel;
import com.abilists.plugins.stock.bean.model.StockCompanyForChartModel;
import com.abilists.plugins.stock.bean.para.DltStockCompanyPara;
import com.abilists.plugins.stock.bean.para.DltStockPara;
import com.abilists.plugins.stock.bean.para.IstStockCompanyPara;
import com.abilists.plugins.stock.bean.para.IstStockPara;
import com.abilists.plugins.stock.bean.para.SltStockCompanyPara;
import com.abilists.plugins.stock.bean.para.SltStockPara;
import com.abilists.plugins.stock.bean.para.UdtStockCompanyPara;
import com.abilists.plugins.stock.bean.para.UdtStockPara;
import com.abilists.plugins.stock.dao.MStockDao;
import com.abilists.plugins.stock.dao.SStockDao;
import com.abilists.plugins.stock.service.StockService;

import base.bean.para.CommonPara;
import io.utility.letter.DateUtility;

@Service
public class StockServiceImpl extends AbilistsAbstractService implements StockService {

	final Logger logger = LoggerFactory.getLogger(StockServiceImpl.class);

	@Autowired
	private SqlSession sAbilistsDao;
	@Autowired
    private Configuration configuration;

	@Override
	public List<PluginsUserStockCompanyModel> sltStockCompanyList(CommonPara commonPara) throws Exception {
		List<PluginsUserStockCompanyModel> masterStockCompanyList = null;

		// Get now page
		int nowPage = commonPara.getNowPage();
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", commonPara.getUserId());
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.ten"));
		map.put("row", configuration.getInt("paging.row.ten"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			masterStockCompanyList = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStockCompanyList(map);
		} catch (Exception e) {
			logger.error("sltStockList Exception error", e);
		}

		return masterStockCompanyList;
	}

	@Override
	public PluginsUserStockCompanyModel sltStockCompany(SltStockCompanyPara sltMStockCompanyPara) throws Exception {
		PluginsUserStockCompanyModel masterStockCompany = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uscNo", sltMStockCompanyPara.getUscNo());
		map.put("userId", sltMStockCompanyPara.getUserId());

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			masterStockCompany = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStockCompany(map);
		} catch (Exception e) {
			logger.error("sltMStockCompany Exception error", e);
		}
		return masterStockCompany;
	}

	@Override
	public List<StockCompanyForChartModel> sltStockCompanyForChartList(CommonPara commonPara) throws Exception {
		List<StockCompanyForChartModel> stockCompanyForChartList = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", commonPara.getUserId());
		map.put("nowPage", 0);
		map.put("row", configuration.getInt("paging.row.twenty"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			stockCompanyForChartList = sAbilistsDao.getMapper(SStockDao.class).sltStockCompanyForChartList(map);
		} catch (Exception e) {
			logger.error("sltMStockCompany Exception error", e);
		}
		return stockCompanyForChartList;
	}

	@Override
	public Map<String, StockCountChartsBean> sltStockChartMap(SltStockPara sltStockPara) throws CloneNotSupportedException {

		List<PluginsUserStockModel> stockForChartList = null;

		// ustSaleDay
		SimpleDateFormat format	= new SimpleDateFormat("yyyy-MM-dd");
		String beforeOneYear = format.format(DateUtility.getEndDayOfMonth(-12));

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ustSaleDay", beforeOneYear);
		map.put("uscNo", sltStockPara.getMscNo());
		map.put("userId", sltStockPara.getUserId());

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			stockForChartList = sAbilistsDao.getMapper(SStockDao.class).sltStockForChartList(map);
		} catch (Exception e) {
			logger.error("sltStockList Exception error", e);
		}

		Map<String, StockCountChartsBean> mapStockCountCharts = new TreeMap<String, StockCountChartsBean>();
		format = new SimpleDateFormat("yy/MM/dd");
		int intSaleLeftCount = 0;
		for(PluginsUserStockModel pluginsUserStock : stockForChartList) {
			String keySaleDay = format.format(pluginsUserStock.getUstSaleDay());

			if(mapStockCountCharts.containsKey(keySaleDay)) {
				StockCountChartsBean stockCountCharts = (StockCountChartsBean)mapStockCountCharts.get(keySaleDay);
				if(pluginsUserStock.getUstClassify().equals("1")) {
					// If there is the data with the key, Plus with the previous data
					stockCountCharts.setSaleBuyCost(pluginsUserStock.getUstSaleCost() + stockCountCharts.getSaleBuyCost());
					stockCountCharts.setSaleBuyCount(pluginsUserStock.getUstSaleCnt() + stockCountCharts.getSaleBuyCount());
				}  else if(pluginsUserStock.getUstClassify().equals("2")) {
					// If there is the data with the key, Plus with the previous data
					stockCountCharts.setSaleSellCost(pluginsUserStock.getUstSaleCost() + stockCountCharts.getSaleSellCost());
					stockCountCharts.setSaleSellCount(pluginsUserStock.getUstSaleCnt() + stockCountCharts.getSaleSellCount());
				} else {
					stockCountCharts.setSaleBuyCost(0);
					stockCountCharts.setSaleBuyCount(0);
					stockCountCharts.setSaleSellCost(0);
					stockCountCharts.setSaleSellCount(0);
					logger.warn("There is a worng data, please check the data. ustSaleDay = " + pluginsUserStock.getUstSaleDay());
				}
				intSaleLeftCount = intSaleLeftCount + pluginsUserStock.getUstSaleCnt();
				stockCountCharts.setSaleLeftCount(intSaleLeftCount);

				mapStockCountCharts.put(keySaleDay, stockCountCharts);
			} else {
				StockCountChartsBean stockCountChartsBean = new StockCountChartsBean();

				if(pluginsUserStock.getUstClassify().equals("1")) {
					stockCountChartsBean.setSaleBuyCost(pluginsUserStock.getUstSaleCost());
					stockCountChartsBean.setSaleBuyCount(pluginsUserStock.getUstSaleCnt());
				}  else if(pluginsUserStock.getUstClassify().equals("2")) {
					stockCountChartsBean.setSaleSellCost(pluginsUserStock.getUstSaleCost());
					stockCountChartsBean.setSaleSellCount(pluginsUserStock.getUstSaleCnt());
				} else {
					stockCountChartsBean.setSaleBuyCost(0);
					stockCountChartsBean.setSaleBuyCount(0);
					stockCountChartsBean.setSaleSellCost(0);
					stockCountChartsBean.setSaleSellCount(0);
					stockCountChartsBean.setSaleLeftCount(stockCountChartsBean.getSaleLeftCount());
					logger.warn("There is a worng data, please check the data. ustSaleDay = " + pluginsUserStock.getUstSaleDay());
				}
				intSaleLeftCount = intSaleLeftCount + pluginsUserStock.getUstSaleCnt();
				stockCountChartsBean.setSaleLeftCount(intSaleLeftCount);
				mapStockCountCharts.put(keySaleDay, stockCountChartsBean);
			}

			// Set a data for asset
			StockCountChartsBean stockCountChartsBean = mapStockCountCharts.get(keySaleDay);
			stockCountChartsBean.setSaleLeftAsset((stockCountChartsBean.getSaleSellCost() * (stockCountChartsBean.getSaleSellCount() * -1)) 
					- (stockCountChartsBean.getSaleBuyCost() * stockCountChartsBean.getSaleBuyCount()));

			// mapStockCountCharts.put(keySaleDay, stockCountChartsBean);
		}

		return mapStockCountCharts;
	}

	@Override
	public List<PluginsUserStockModel> sltStockList(SltStockPara sltStockPara) throws Exception {
		List<PluginsUserStockModel> pluginsUserStockList = null;

		// Get now page
		int nowPage = sltStockPara.getNowPage();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uscNo", sltStockPara.getMscNo());
		map.put("userId", sltStockPara.getUserId());
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.ten"));
		map.put("row", configuration.getInt("paging.row.ten"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			pluginsUserStockList = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStockList(map);
		} catch (Exception e) {
			logger.error("sltStockList Exception error", e);
		}

		return pluginsUserStockList;
	}

	@Override
	public PluginsUserStockModel sltStock(SltStockPara sltStockPara) throws Exception {
		PluginsUserStockModel userStockModel = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ustNo", sltStockPara.getUstNo());
		map.put("userId", sltStockPara.getUserId());

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			userStockModel = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStock(map);
		} catch (Exception e) {
			logger.error("sltOptions Exception error", e);
		}

		return userStockModel;
	}

	@Override
	public int sltStockCompanySum(CommonPara commonPara) throws Exception {
		int sum = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", commonPara.getUserId());

		try {
			sum = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStockCompanySum(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public int sltStockSum(SltStockPara sltStockPara) throws Exception {
		int sum = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", sltStockPara.getUserId());
		map.put("uscNo", sltStockPara.getMscNo());

		try {
			sum = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStockSum(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public List<PluginsUserStockCompanyModel> srhStockCompanyList(SrhAutoCompletePara srhAutoCompletePara) throws Exception {
		
		List<PluginsUserStockCompanyModel> masterStockCompanyList = null;

		// Get now page
		int nowPage = srhAutoCompletePara.getNowPage();
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", srhAutoCompletePara.getUserId());
		map.put("uscName", srhAutoCompletePara.getSrhContents());
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.ten"));
		map.put("row", configuration.getInt("paging.row.ten"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			masterStockCompanyList = sAbilistsDao.getMapper(SStockDao.class).srhUserStockCompanyList(map);
		} catch (Exception e) {
			logger.error("sltStockList Exception error", e);
		}

		return masterStockCompanyList;
	}

	@Override
	public List<PluginsUserStockCompanyModel> srhStockCompany(SrhAutoCompletePara srhAutoCompletePara) throws Exception {
	
		List<PluginsUserStockCompanyModel> masterStockCompanyList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("userId", srhAutoCompletePara.getUserId());
		// Key is title, Value is Contents.
		map.put("uscName", srhAutoCompletePara.getSrhContents());
		map.put("nowPage", 0);
		map.put("row", configuration.getInt("paging.row.ten"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			masterStockCompanyList = sAbilistsDao.getMapper(SStockDao.class).srhUserStockCompanyList(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
			throw e;
		}
	
		return masterStockCompanyList;
	}

	@Transactional(rollbackFor = {IllegalArgumentException.class, Exception.class}, propagation = Propagation.REQUIRES_NEW)
	@Override
	public boolean istStockCompany(IstStockCompanyPara istStockCompanyPara) throws Exception {
		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("uscCode", istStockCompanyPara.getUscCode());
		map.put("uscName", istStockCompanyPara.getUscName());
		map.put("uscProfit", istStockCompanyPara.getUscProfit());
		map.put("uscDividend", istStockCompanyPara.getUscDividend());
		map.put("uscPayoutRatio", istStockCompanyPara.getUscPayoutRatio());
		map.put("uscComment", istStockCompanyPara.getUscComment());
		map.put("userId", istStockCompanyPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).istPluginsUserStockCompany(map);

		} catch (IndexOutOfBoundsException ie) {
			logger.error("IndexOutOfBoundsException error", ie);
			return false;
		} catch (Exception e) {
			logger.error("Exception error", e);
			return false;
		}

		if(intResult < 1) {
			logger.error("istStock error, userId={}", map.get("userId"));
			return false;
		}

		return true;	
	}

	@Transactional(rollbackFor = {IllegalArgumentException.class, Exception.class}, propagation = Propagation.REQUIRES_NEW)
	@Override
	public boolean istStock(IstStockPara istStockPara) throws Exception {
		int intResult = 0;

		int intSaleCnt = istStockPara.getUstSaleCnt();
		if(istStockPara.getUstClassify().equals("2") && intSaleCnt > 0) {
			intSaleCnt = istStockPara.getUstSaleCnt() * -1;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ustSaleDay", istStockPara.getUstSaleDay());
		map.put("ustClassify", istStockPara.getUstClassify());
		map.put("ustSaleCost", istStockPara.getUstSaleCost());
		map.put("ustSaleCnt", intSaleCnt);
		map.put("ustSaleFee", istStockPara.getUstSaleFee());
		map.put("ustComment", istStockPara.getUstComment());
		map.put("uscNo", istStockPara.getUscNo());
		map.put("uscName", istStockPara.getUscName());
		map.put("userId", istStockPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).istPluginsUserStock(map);

		} catch (IndexOutOfBoundsException ie) {
			logger.error("IndexOutOfBoundsException error", ie);
			return false;
		} catch (Exception e) {
			logger.error("Exception error", e);
			return false;
		}

		if(intResult < 1) {
			logger.error("istStock error, userId={}", map.get("userId"));
			return false;
		}

		return true;	
	}

	@Transactional(rollbackFor = {IllegalArgumentException.class, Exception.class}, propagation = Propagation.REQUIRES_NEW)
	@Override
	public boolean udtStockCompany(UdtStockCompanyPara udtStockCompanyPara) throws Exception {

		int intResult = 0;

		//
		//int intMscProfit = udtMasterStockCompanyPara.getMscProfit();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uscNo", udtStockCompanyPara.getUscNo());
		map.put("uscCode", udtStockCompanyPara.getUscCode());
		map.put("uscName", udtStockCompanyPara.getUscName());
		map.put("uscProfit", udtStockCompanyPara.getUscProfit());
		map.put("uscDividend", udtStockCompanyPara.getUscDividend());
		map.put("uscPayoutRatio", udtStockCompanyPara.getUscPayoutRatio());
		map.put("uscComment", udtStockCompanyPara.getUscComment());
		map.put("userId", udtStockCompanyPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).udtPluginsUserStockCompany(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		if(intResult < 1) {
			logger.error("udtPluginsUserStockCompany error, userId={}", udtStockCompanyPara.getUserId());
			return false;
		}

		return true;
	}

	@Transactional(rollbackFor = {IllegalArgumentException.class, Exception.class}, propagation = Propagation.REQUIRES_NEW)
	@Override
	public boolean udtStock(UdtStockPara udtStockPara) throws Exception {

		int intResult = 0;

		int intSaleCnt = udtStockPara.getUstSaleCnt();
		if(udtStockPara.getUstClassify().equals("2") && intSaleCnt > 0) {
			intSaleCnt = udtStockPara.getUstSaleCnt() * -1;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ustNo", udtStockPara.getUstNo());
		map.put("ustSaleDay", udtStockPara.getUstSaleDay());
		map.put("ustClassify", udtStockPara.getUstClassify());
		map.put("ustSaleCost", udtStockPara.getUstSaleCost());
		map.put("ustSaleCnt", intSaleCnt);
		map.put("ustSaleFee", udtStockPara.getUstSaleFee());
		map.put("ustComment", udtStockPara.getUstComment());
		map.put("uscNo", udtStockPara.getUscNo());
		map.put("uscName", udtStockPara.getUscName());
		map.put("userId", udtStockPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).udtPluginsUserStock(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		if(intResult < 1) {
			logger.error("udtStock error, uscNo={}, ustNo={}, ustComment={},  userId={}", 
					udtStockPara.getUscNo(), udtStockPara.getUstNo(), udtStockPara.getUstComment(), udtStockPara.getUserId());
			return false;
		}

		return true;
	}

	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	@Override
	public boolean dltStockCompany(DltStockCompanyPara dltMasterStockCompanyPara) throws Exception {
		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uscNo", dltMasterStockCompanyPara.getUscNo());
		map.put("userId", dltMasterStockCompanyPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).dltPluginsUserStockCompany(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		if(intResult < 1) {
			logger.error("dltMasterStockCompany error, uscNo={}, userId={}", dltMasterStockCompanyPara.getUscNo(), dltMasterStockCompanyPara.getUserId());
			return false;
		}

		return true;
	}

	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	@Override
	public boolean dltStock(DltStockPara dltStockPara) throws Exception {

		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ustNo", dltStockPara.getUstNo());
		map.put("userId", dltStockPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).dltPluginsUserStock(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		if(intResult < 1) {
			logger.error("dltStock error, ustNo={}, userId={}", dltStockPara.getUstNo(), dltStockPara.getUserId());
			return false;
		}

		return true;
	}

}