package com.abilists.plugins.stock.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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

import com.abilists.core.service.AbilistsAbstractService;
import com.abilists.plugins.stock.bean.StockCountChartsBean;
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
	public List<PluginsMStockCompanyModel> sltMStockCompanyList(CommonPara commonPara) throws Exception {
		List<PluginsMStockCompanyModel> masterStockCompanyList = null;

		// Get now page
		int nowPage = commonPara.getNowPage();
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", commonPara.getUserId());
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.ten"));
		map.put("row", configuration.getInt("paging.row.ten"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			masterStockCompanyList = sAbilistsDao.getMapper(SStockDao.class).sltPluginsMStockCompanyList(map);	
		} catch (Exception e) {
			logger.error("sltStockList Exception error", e);
		}

		return masterStockCompanyList;
	}

	@Override
	public PluginsMStockCompanyModel sltMStockCompany(SltMStockCompanyPara sltMStockCompanyPara) throws Exception {
		PluginsMStockCompanyModel masterStockCompany = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mscNo", sltMStockCompanyPara.getMscNo());
		map.put("userId", sltMStockCompanyPara.getUserId());

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			masterStockCompany = sAbilistsDao.getMapper(SStockDao.class).sltPluginsMStockCompany(map);
		} catch (Exception e) {
			logger.error("sltMStockCompany Exception error", e);
		}
		return masterStockCompany;
	}

	@Override
	public Map<String, StockCountChartsBean> sltStockChartMap(SltStockPara sltStockPara) throws CloneNotSupportedException {

		List<PluginsUserStockModel> stockForChartList = null;

		// ustSaleDay
		SimpleDateFormat format	= new SimpleDateFormat("yyyy-MM-dd");
		String beforeOneYear = format.format(DateUtility.getEndDayOfMonth(-12));

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ustSaleDay", beforeOneYear);
		map.put("userId", sltStockPara.getUserId());

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			stockForChartList = sAbilistsDao.getMapper(SStockDao.class).sltStockForChartList(map);
		} catch (Exception e) {
			logger.error("sltStockList Exception error", e);
		}

		// Just backu-up source
//		List<PluginsUserStockModel> pluginsUserStockClone = new ArrayList<>();
//		Iterator<PluginsUserStockModel> iterator = stockForChartList.iterator();
//      while(iterator.hasNext()){
//      	pluginsUserStockClone.add((PluginsUserStockModel)iterator.next().clone());
//      }

		Map<String, StockCountChartsBean> mapStockCountCharts = new TreeMap<String, StockCountChartsBean>();
		format = new SimpleDateFormat("MM/dd");
		int intSaleLeftCount = 0;
		for(PluginsUserStockModel pluginsUserStock : stockForChartList) {
			String keySaleDay = format.format(pluginsUserStock.getUstSaleDay());

			logger.info("saleDay = " + keySaleDay);

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

		}

		return mapStockCountCharts;
	}

	@Override
	public List<PluginsUserStockModel> sltStockList(SltStockPara sltStockPara) throws Exception {
		List<PluginsUserStockModel> pluginsUserStockList = null;

		// Get now page
		int nowPage = sltStockPara.getNowPage();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mscNo", sltStockPara.getMscNo());
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

//	@Override
//	public List<StockModel> srhStockCompanyList(SrhAutoCompletePara srhAutoCompletePara) throws Exception {
//
//		List<StockModel> stockList = null;
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//
//		map.put("userId", srhAutoCompletePara.getUserId());
//		// Key is title, Value is Contents.
//		map.put("ustName", srhAutoCompletePara.getSrhContents());
//		map.put("nowPage", 0);
//		map.put("row", configuration.getInt("paging.row.ten"));
//
//		try {
//			stockList = sAbilistsDao.getMapper(SStockDao.class).srhStockCompanyList(map);
//		} catch (Exception e) {
//			logger.error("Exception error", e);
//			throw e;
//		}
//
//		return stockList;
//	}

	@Override
	public int sltMasterStockCompanySum(CommonPara commonPara) throws Exception {
		int sum = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", commonPara.getUserId());

		try {
			sum = sAbilistsDao.getMapper(SStockDao.class).sltPluginsMStockCompanySum(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public int sltStockSum(CommonPara commonPara) throws Exception {
		int sum = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", commonPara.getUserId());

		try {
			sum = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStockSum(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Transactional(rollbackFor = {IllegalArgumentException.class, Exception.class}, propagation = Propagation.REQUIRES_NEW)
	@Override
	public boolean istMStockCompany(IstMStockCompanyPara istMasterStockCompanyPara) throws Exception {
		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mscCode", istMasterStockCompanyPara.getMscCode());
		map.put("mscName", istMasterStockCompanyPara.getMscName());
		map.put("mscProfit", istMasterStockCompanyPara.getMscProfit());
		map.put("mscDividend", istMasterStockCompanyPara.getMscDividend());
		map.put("mscPayoutRatio", istMasterStockCompanyPara.getMscPayoutRatio());
		map.put("mscComment", istMasterStockCompanyPara.getMscComment());
		map.put("userId", istMasterStockCompanyPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).istPluginsMStockCompany(map);

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
		map.put("mscName", istStockPara.getMscName());
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
	public boolean udtMStockCompany(UdtMStockCompanyPara udtMasterStockCompanyPara) throws Exception {

		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mscNo", udtMasterStockCompanyPara.getMscNo());
		map.put("mscCode", udtMasterStockCompanyPara.getMscCode());
		map.put("mscName", udtMasterStockCompanyPara.getMscName());
		map.put("mscProfit", udtMasterStockCompanyPara.getMscProfit());
		map.put("mscDividend", udtMasterStockCompanyPara.getMscDividend());
		map.put("mscPayoutRatio", udtMasterStockCompanyPara.getMscPayoutRatio());
		map.put("mscComment", udtMasterStockCompanyPara.getMscComment());
		map.put("userId", udtMasterStockCompanyPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).udtPluginsMStockCompany(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		if(intResult < 1) {
			logger.error("udtStock error, userId={}", udtMasterStockCompanyPara.getUserId());
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
		map.put("mscName", udtStockPara.getMscName());
		map.put("userId", udtStockPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).udtPluginsUserStock(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		if(intResult < 1) {
			logger.error("udtStock error, userId={}", udtStockPara.getUserId());
			return false;
		}

		return true;
	}

	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	@Override
	public boolean dltMStockCompany(DltMStockCompanyPara dltMasterStockCompanyPara) throws Exception {
		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mscNo", dltMasterStockCompanyPara.getMscNo());
		map.put("userId", dltMasterStockCompanyPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).dltPluginsUserStock(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		if(intResult < 1) {
			logger.error("dltMasterStockCompany error, mscNo={}, userId={}", dltMasterStockCompanyPara.getMscNo(), dltMasterStockCompanyPara.getUserId());
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