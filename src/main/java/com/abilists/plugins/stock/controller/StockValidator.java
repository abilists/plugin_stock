package com.abilists.plugins.stock.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.validation.Errors;

import com.abilists.core.controller.BaseValidator;
import com.abilists.plugins.stock.bean.para.IstStockPara;
import com.abilists.plugins.stock.bean.para.UdtStockPara;

public class StockValidator implements BaseValidator {

	final Logger logger = LoggerFactory.getLogger(StockValidator.class);

	@Override
	public <T> Map<String, String> validateBusiness(T para, MessageSource message, Locale locale) throws IOException {
		Map<String, String> mapErrorMessage = new HashMap<>();

		if (para instanceof UdtStockPara) {
			UdtStockPara udtStockPara = (UdtStockPara)para;

		} else if(para instanceof IstStockPara) {
			IstStockPara istStockPara = (IstStockPara)para;

		}

		return mapErrorMessage;
	}

	@Override
	public <T> Map<String, String> validateBusiness(T para, HttpSession session) throws IOException {
		return null;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		
	}

}
