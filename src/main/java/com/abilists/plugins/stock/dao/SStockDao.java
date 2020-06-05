package com.abilists.plugins.stock.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.abilists.plugins.stock.bean.model.PluginsUserStockCompanyModel;
import com.abilists.plugins.stock.bean.model.PluginsUserStockModel;

@Repository
public interface SStockDao {

	public List<PluginsUserStockCompanyModel> sltPluginsUserStockCompanyList(Map<String, Object> map) throws SQLException;
	public PluginsUserStockCompanyModel sltPluginsUserStockCompany(Map<String, Object> map) throws SQLException;

	public List<PluginsUserStockModel> sltPluginsUserStockList(Map<String, Object> map) throws SQLException;
	public PluginsUserStockModel sltPluginsUserStock(Map<String, Object> map) throws SQLException;

	public List<PluginsUserStockModel> sltStockForChartList(Map<String, Object> map) throws SQLException;
	public List<PluginsUserStockCompanyModel> srhUserStockCompanyList(Map<String, Object> map) throws SQLException;

	public int sltPluginsUserStockCompanySum(Map<String, Object> map) throws SQLException;
	public int sltPluginsUserStockSum(Map<String, Object> map) throws SQLException;

}