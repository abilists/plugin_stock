package com.abilists.plugins;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.abilists.core.service.AbilistsAbstractService;
import com.abilists.plugins.service.PluginService;

@Service
@Component
public class InitiativeServiceImpl extends AbilistsAbstractService implements PluginService {

	final Logger logger = LoggerFactory.getLogger(InitiativeServiceImpl.class);
	final String INITIATIVE_SQL = "/sqlMap/plugins/initiativeSql.txt";
	final String MY_DRIVER = "org.h2.Driver";

	@Override
	public String createTables(HashMap<String, String> mapHash) throws Exception {
		logger.info("====================================Start to create======================================");
		String strReadResult = null;
	    StringBuffer sbSql = new StringBuffer();

		try (InputStream is = this.getClass().getResourceAsStream(INITIATIVE_SQL)) {
			if(is == null) {
				logger.error("The initiative SQL file has not been loaded. please check the file path or format.");
				return "false";
			}
			BufferedReader bfReader = new BufferedReader(new InputStreamReader(is));
			while((strReadResult = bfReader.readLine()) != null) {
				sbSql.append(strReadResult);
			}
		} catch (IOException e) {
			logger.error("IOException.", e);
			return "false";
		}
		logger.info("====================================End to create========================================");

		Connection conn = null;
		PreparedStatement preparedStmt = null;
	    try {
	      Class.forName(MY_DRIVER);
	      conn = DriverManager.getConnection(mapHash.get(PluginService.DB_URL),  mapHash.get(PluginService.DB_USERNAME), mapHash.get(PluginService.DB_PASSWORD));

	      preparedStmt = conn.prepareStatement(sbSql.toString());
	      preparedStmt.execute();
	    }
	    catch (Exception e) {
	      logger.error("Exception", e);
	      logger.error("DB URL=" + mapHash.get(PluginService.DB_URL) + ", username=" + mapHash.get(PluginService.DB_USERNAME));
	      return "false";
	    } finally {
	    	if(preparedStmt != null) {
	    		preparedStmt.close();
	    	}
	    	if(conn != null) {
	    		conn.close();
	    	}
		}
		return "true";
	}

	@Override
	public String dropTables(String arg0) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}