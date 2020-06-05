package com.abilists.plugins.stock.dao;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface MStockDao {
	
	public int istPluginsUserStockCompany(Map<String, Object> map) throws SQLException;
	public int istPluginsUserStock(Map<String, Object> map) throws SQLException;

	public int udtPluginsUserStockCompany(Map<String, Object> map) throws SQLException;
	public int udtPluginsUserStock(Map<String, Object> map) throws SQLException;
	
	public int dltPluginsUserStockCompany(Map<String, Object> map) throws SQLException;
	public int dltPluginsUserStock(Map<String, Object> map) throws SQLException;

}