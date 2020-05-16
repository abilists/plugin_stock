package com.abilists.plugins.stock.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.abilists.core.service.AbilistsAbstractService;
import com.abilists.plugins.stock.admin.service.AdminStockService;
import com.abilists.plugins.stock.bean.model.PluginsUserStockModel;
import com.abilists.plugins.stock.dao.SStockDao;

import base.bean.para.CommonPara;

@Service
public class AdminStockServiceImpl extends AbilistsAbstractService implements AdminStockService {

	final Logger logger = LoggerFactory.getLogger(AdminStockServiceImpl.class);

	@Autowired
	private SqlSession sAbilistsDao;
	@Autowired
    private Configuration configuration;

	@Override
	public List<PluginsUserStockModel> sltStockList(CommonPara commonPara) throws Exception {
		List<PluginsUserStockModel> stockList = null;

		// Get now page
		int nowPage = commonPara.getNowPage();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nowPage", (nowPage - 1) * configuration.getInt("paging.row.ten"));
		map.put("row", configuration.getInt("paging.row.ten"));

		try {
			sqlSessionSlaveFactory.setDataSource(getDispersionDb());
			stockList = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStockList(map);

		} catch (Exception e) {
			logger.error("sltOptions Exception error", e);
		}

		return stockList;
	}

	@Override
	public int sltStockSum(CommonPara commonPara) throws Exception {
		int sum = 0;

		Map<String, Object> map = new HashMap<String, Object>();

		try {
			sum = sAbilistsDao.getMapper(SStockDao.class).sltPluginsUserStockSum(map);
		} catch (Exception e) {
			logger.error("Exception error", e);
		}

		return sum;
	}

}
