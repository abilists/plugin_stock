package com.abilists.plugins.stock.dao;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface MStockDao {

	public int istStock(Map<String, Object> map) throws SQLException;
	public int udtStock(Map<String, Object> map) throws SQLException;
	public int dltStock(Map<String, Object> map) throws SQLException;

}