package com.abilists.plugins.stock.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.abilists.core.service.AbilistsAbstractService;
import com.abilists.plugins.stock.bean.model.StockModel;
import com.abilists.plugins.stock.bean.para.DltStockPara;
import com.abilists.plugins.stock.bean.para.IstStockPara;
import com.abilists.plugins.stock.bean.para.SltStockPara;
import com.abilists.plugins.stock.bean.para.UdtStockPara;
import com.abilists.plugins.stock.dao.MStockDao;
import com.abilists.plugins.stock.dao.SStockDao;
import com.abilists.plugins.stock.service.StockService;

import base.bean.para.CommonPara;

@Service
public class StockServiceImpl extends AbilistsAbstractService implements StockService {

	final Logger logger = LoggerFactory.getLogger(StockServiceImpl.class);

	@Autowired
	private SqlSession sAbilistsDao;
	@Autowired
    private Configuration configuration;

	@Override
	public List<StockModel> sltStockList(SltStockPara sltStockPara) throws Exception {
		List<StockModel> StockList = null;
	
		// Get now page
		int nowPage = sltStockPara.getNowPage();
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", sltStockPara.getUserId());
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.ten"));
		map.put("row", configuration.getInt("paging.row.ten"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			StockList = sAbilistsDao.getMapper(SStockDao.class).sltStockList(map);	
		} catch (Exception e) {
			logger.error("sltStockList Exception error", e);
		}

		return StockList;
	}

	public StockModel sltStock(SltStockPara sltStockPara) throws Exception {
		StockModel Stock = null;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usmNo", sltStockPara.getUsmNo());
		map.put("userId", sltStockPara.getUserId());

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			Stock = sAbilistsDao.getMapper(SStockDao.class).sltStock(map);
		} catch (Exception e) {
			logger.error("sltOptions Exception error", e);
		}
		return Stock;
	}

	@Override
	public int sltStockSum(CommonPara commonPara) throws Exception {
		int sum = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", commonPara.getUserId());

		try {
			sum = sAbilistsDao.getMapper(SStockDao.class).sltStockSum(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

	@Override
	public boolean istStock(IstStockPara istStockPara) throws Exception {
		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usmStock", istStockPara.getUsmStock());
		map.put("userId", istStockPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).istStock(map);

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
	public boolean udtStock(UdtStockPara udtStockPara) throws Exception {

		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usmNo", udtStockPara.getUsmNo());
		map.put("usmStock", udtStockPara.getUsmStock());
		map.put("userId", udtStockPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).udtStock(map);
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
	public boolean dltStock(DltStockPara dltStockPara) throws Exception {

		int intResult = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usmNo", dltStockPara.getUsmNo());
		map.put("userId", dltStockPara.getUserId());

		try {
			intResult = mAbilistsDao.getMapper(MStockDao.class).dltStock(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		if(intResult < 1) {
			logger.error("dltStock error, usmNo={}, userId={}", dltStockPara.getUsmNo(), dltStockPara.getUserId());
			return false;
		}

		return true;
	}

}