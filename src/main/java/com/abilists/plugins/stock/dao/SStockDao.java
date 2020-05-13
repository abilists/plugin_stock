package com.abilists.plugins.stock.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.abilists.plugins.stock.bean.model.StockModel;

@Repository
public interface SStockDao {

	public List<StockModel> sltStockList(Map<String, Object> map) throws SQLException;
	public List<StockModel> srhStockList(Map<String, Object> map) throws SQLException;
	public List<StockModel> srhStockCompanyList(Map<String, Object> map) throws SQLException;
	public StockModel sltStock(Map<String, Object> map) throws SQLException;
	public int sltStockSum(Map<String, Object> map) throws SQLException;

}