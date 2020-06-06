package com.abilists.plugins.stock.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.abilists.bean.AbilistsModel;
import com.abilists.bean.para.admin.SrhAutoCompletePara;
import com.abilists.core.common.bean.CommonBean;
import com.abilists.core.controller.AbstractBaseController;
import com.abilists.core.controller.CommonAbilistsController;
import com.abilists.plugins.stock.bean.PluginsModel;
import com.abilists.plugins.stock.bean.StockCountChartsBean;
import com.abilists.plugins.stock.bean.model.PluginsUserStockCompanyModel;
import com.abilists.plugins.stock.bean.model.PluginsUserStockModel;
import com.abilists.plugins.stock.bean.para.DltStockCompanyPara;
import com.abilists.plugins.stock.bean.para.DltStockPara;
import com.abilists.plugins.stock.bean.para.IstStockCompanyPara;
import com.abilists.plugins.stock.bean.para.IstStockPara;
import com.abilists.plugins.stock.bean.para.SltStockCompanyPara;
import com.abilists.plugins.stock.bean.para.SltStockPara;
import com.abilists.plugins.stock.bean.para.UdtStockCompanyPara;
import com.abilists.plugins.stock.bean.para.UdtStockPara;
import com.abilists.plugins.stock.service.StockService;

import io.utility.security.TokenUtility;

@Controller
@RequestMapping("/plugins/stock")
public class StockController extends CommonAbilistsController {
	final Logger logger = LoggerFactory.getLogger(StockController.class);

	@Autowired
	private StockService stockService;
	@Autowired
	private CommonBean commonBean;

	/*
	 * Get a company information
	 */
	@RequestMapping(value = {"/", "", "index"}, method = RequestMethod.GET)
	public String sltStockCompanyList(@Validated SltStockCompanyPara sltMasterStockCompanyPara, HttpServletRequest request, ModelMap model) throws Exception {
		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");

		PluginsModel pluginsModel = new PluginsModel();

		// Set user id
		this.handleSessionInfo(request.getSession(), sltMasterStockCompanyPara);

		// Set Paging list
		int intSum = stockService.sltStockCompanySum(sltMasterStockCompanyPara);
		abilistsModel.setPaging(stockService.makePaging(sltMasterStockCompanyPara, intSum));
		// Get stock list
		pluginsModel.setmStockCompanyList(stockService.sltStockCompanyList(sltMasterStockCompanyPara));

		// Get key and token
		String token = TokenUtility.generateToken(TokenUtility.SHA_256);
		String key = this.makeKey(sltMasterStockCompanyPara.getUserId(), AbstractBaseController.PREFIX_IST_KEY);
		commonBean.addTokenExpireMap(key, token);
		abilistsModel.setToken(token);

		model.addAttribute("model", abilistsModel);
		model.addAttribute("plugins", pluginsModel);

		return "apps/stock/index";
	}

	/*
	 * Get stock of informations from a company
	 */
	@RequestMapping(value = {"/sltStockList/{uscNo}"}, method = RequestMethod.GET)
	public String sltStockList(@PathVariable String uscNo, HttpServletRequest request, ModelMap model) throws Exception {
		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");

		PluginsModel pluginsModel = new PluginsModel();

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = new HashMap<String, String>();
		if (!StringUtils.isNumeric(uscNo)) {
			logger.error("uscNo is null");
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.token.message", null, locale));
			model.addAttribute("errorMessage", mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		SltStockCompanyPara sltMStockCompanyPara = new SltStockCompanyPara();
		sltMStockCompanyPara.setUscNo(uscNo);

		// Set user id
		this.handleSessionInfo(request.getSession(), sltMStockCompanyPara);

		// Get a company information
		pluginsModel.setmStockCompany(stockService.sltStockCompany(sltMStockCompanyPara));

		// Get the stock information from the company
		SltStockPara sltStockPara = new SltStockPara();
		sltStockPara.setUserId(sltMStockCompanyPara.getUserId());
		sltStockPara.setMscNo(uscNo);
		
		// Get informations for chart.
		Map<String, StockCountChartsBean> mapStockChart = stockService.sltStockChartMap(sltStockPara);
		pluginsModel.setMapStockChart(mapStockChart);

		// Get traded information of a company
		pluginsModel.setUserStockList(stockService.sltStockList(sltStockPara));

		// Get key and token
		String token = TokenUtility.generateToken(TokenUtility.SHA_256);
		String key = this.makeKey(sltStockPara.getUserId(), AbstractBaseController.PREFIX_IST_KEY);
		commonBean.addTokenExpireMap(key, token);
		abilistsModel.setToken(token);

		model.addAttribute("model", abilistsModel);
		model.addAttribute("plugins", pluginsModel);

		return "apps/stock/stock";
	}

	@RequestMapping(value = { "/srhStockCompanyList" })
	public String srhStockCompanyList(@Valid SrhAutoCompletePara srhAutoCompletePara, 
			BindingResult bindingResult, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");
		abilistsModel.setSubMenu("srhStockCompanyList");

		PluginsModel pluginsModel = new PluginsModel();

		// Set user id
		this.handleSessionInfo(request.getSession(), srhAutoCompletePara);

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		// If it occurs a error, set the default value.
		Map<String, String> mapErrorMessage = null;
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("srhForMemo - There are parameter errors.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Get user information
		List<PluginsUserStockCompanyModel> mStockCompanyList = stockService.srhStockCompanyList(srhAutoCompletePara);
		pluginsModel.setmStockCompanyList(mStockCompanyList);

		// Get key and token
		String token = TokenUtility.generateToken(TokenUtility.SHA_256);
		String key = this.makeKey(srhAutoCompletePara.getUserId(), AbstractBaseController.PREFIX_UDT_KEY);
		commonBean.addTokenExpireMap(key, token);
		abilistsModel.setToken(token);

		model.addAttribute("model", abilistsModel);
		model.addAttribute("plugins", pluginsModel);

		return "apps/stock/index";
	}

    @RequestMapping(value = "/sltStockCompanyAjax")
	public @ResponseBody PluginsUserStockCompanyModel sltStockCompanyAjax(@RequestBody SltStockCompanyPara sltMStockCompanyPara,
			HttpSession session) throws Exception {

		// Set user id
		this.handleSessionInfo(session, sltMStockCompanyPara);

		// Get user Reports.
		PluginsUserStockCompanyModel masterStockCompanyModel = stockService.sltStockCompany(sltMStockCompanyPara);

		// Get key and token
		String token = TokenUtility.generateToken(TokenUtility.SHA_256);
		String key = this.makeKey(sltMStockCompanyPara.getUserId(), AbstractBaseController.PREFIX_UDT_KEY);
		commonBean.addTokenExpireMap(key, token);

		// Set a token
		masterStockCompanyModel.setToken(token);

		return masterStockCompanyModel;
	}

	@RequestMapping(value = "/sltStockAjax")
	public @ResponseBody PluginsUserStockModel sltStockAjax(@RequestBody SltStockPara sltStockPara,
			HttpSession session) throws Exception {

		// Set user id
		this.handleSessionInfo(session, sltStockPara);

		// Get user Reports.
		PluginsUserStockModel stock = stockService.sltStock(sltStockPara);

		// Get key and token
		String token = TokenUtility.generateToken(TokenUtility.SHA_256);
		String key = this.makeKey(sltStockPara.getUserId(), AbstractBaseController.PREFIX_UDT_KEY);
		commonBean.addTokenExpireMap(key, token);

		// Set a token
		stock.setToken(token);

		return stock;
	}

	@RequestMapping(value="/srhStockCompanyAjax")
	public @ResponseBody List<PluginsUserStockCompanyModel> srhStockCompanyAjax(@Valid @RequestBody SrhAutoCompletePara srhAutoCompletePara, 
			BindingResult bindingResult, HttpServletRequest request) throws Exception {
	
		List<PluginsUserStockCompanyModel> mStockCompanyList = null;
	
		// Set user id
		this.handleSessionInfo(request.getSession(), srhAutoCompletePara);
	
		// If it occurs a error, set the default value.
		if (bindingResult.hasErrors()) {
			logger.warn("srhForStockAjax - Special charaters are included in the parameters.");
			return new ArrayList<PluginsUserStockCompanyModel>();
		}
	
		// Get user information
		mStockCompanyList = stockService.srhStockCompany(srhAutoCompletePara);
	
		return mStockCompanyList;
	}

	@RequestMapping(value = { "istStockCompany" })
	public String istStockCompany(@Valid IstStockCompanyPara istStockCompanyPara, BindingResult bindingResult, ModelMap model,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = new HashMap<String, String>();
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("istStock - There are parameter errors.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), istStockCompanyPara);

		// Validate token
		String key = this.makeKey(istStockCompanyPara.getUserId(), AbstractBaseController.PREFIX_IST_KEY);
		if (!istStockCompanyPara.getToken().equals(commonBean.getTokenExpireMap(key))) {
			logger.error("istMStockCompany - token is wrong. parameter token=" + istStockCompanyPara.getToken() + ", server token=" + commonBean.getTokenExpireMap(key));
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.token.message", null, locale));
			model.addAttribute("errorMessage", mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Execute the transaction
		if (!stockService.istStockCompany(istStockCompanyPara)) {
			logger.error("istStockCompany - inserting is error. userId={}", istStockCompanyPara.getUserId());
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.insert.error.message", null, locale));
			model.addAttribute("mapErrorMessage", mapErrorMessage);
			return "apps/errors/systemErrors";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/plugins/stock";
	}

	@RequestMapping(value = { "istStock" })
	public String istStock(@Valid IstStockPara istStockPara, BindingResult bindingResult, ModelMap model,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = new HashMap<String, String>();
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("istStock - There are parameter errors.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), istStockPara);

		// Validate token
		String key = this.makeKey(istStockPara.getUserId(), AbstractBaseController.PREFIX_IST_KEY);
		if (!istStockPara.getToken().equals(commonBean.getTokenExpireMap(key))) {
			logger.error("istStock - token is wrong. parameter token=" + istStockPara.getToken() + ", server token=" + commonBean.getTokenExpireMap(key));
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.token.message", null, locale));
			model.addAttribute("errorMessage", mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Execute the transaction
		if (!stockService.istStock(istStockPara)) {
			logger.error("istReports - inserting is error. userId={}", istStockPara.getUserId());
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.insert.error.message", null, locale));
			model.addAttribute("mapErrorMessage", mapErrorMessage);
			return "apps/errors/systemErrors";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/plugins/stock/sltStockList/" + istStockPara.getUscNo();
	}

	@RequestMapping(value = { "udtStockCompany" })
	public String udtStockCompany(@Valid UdtStockCompanyPara udtStockCompanyPara, BindingResult bindingResult, ModelMap model,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = new HashMap<String, String>();
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtStock - There are parameter errors.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), udtStockCompanyPara);

		// Validate token
		String key = this.makeKey(udtStockCompanyPara.getUserId(), AbstractBaseController.PREFIX_UDT_KEY);
		if (!udtStockCompanyPara.getToken().equals(commonBean.getTokenExpireMap(key))) {
			logger.error("udtMasterStockCompany - token is wrong. parameter token=" + udtStockCompanyPara.getToken() + ", server token=" + commonBean.getTokenExpireMap(key));
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.token.message", null, locale));
			model.addAttribute("errorMessage", mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Execute the transaction
		if (!stockService.udtStockCompany(udtStockCompanyPara)) {
			logger.error("udtMasterStockCompany - updating is error. userId={}, usmNo={}", udtStockCompanyPara.getUserId(), udtStockCompanyPara.getUscNo());
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.update.error.message", null, locale));
			model.addAttribute("mapErrorMessage", mapErrorMessage);
			return "apps/errors/systemErrors";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/plugins/stock";
	}

	@RequestMapping(value = { "udtStock" })
	public String udtStock(@Valid UdtStockPara udtStockPara, BindingResult bindingResult, ModelMap model,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = new HashMap<String, String>();
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("udtStock - There are parameter errors.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), udtStockPara);

		// Validate token
		String key = this.makeKey(udtStockPara.getUserId(), AbstractBaseController.PREFIX_UDT_KEY);
		if (!udtStockPara.getToken().equals(commonBean.getTokenExpireMap(key))) {
			logger.error("udtStock - token is wrong. parameter token=" + udtStockPara.getToken() + ", server token=" + commonBean.getTokenExpireMap(key));
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.token.message", null, locale));
			model.addAttribute("errorMessage", mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Execute the transaction
		if (!stockService.udtStock(udtStockPara)) {
			logger.error("udtStock - updating is error. userId={}, usmNo={}", udtStockPara.getUserId(), udtStockPara.getUstNo());
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.update.error.message", null, locale));
			model.addAttribute("mapErrorMessage", mapErrorMessage);
			return "apps/errors/systemErrors";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/plugins/stock/sltStockList/" + udtStockPara.getMscNo();
	}

	@RequestMapping(value = { "dltStockCompany" })
	public String dltStockCompany(@Valid DltStockCompanyPara dltMStockCompanyPara, BindingResult bindingResult, ModelMap model,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = new HashMap<String, String>();
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltMasterStockCompany - There are parameter errors.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), dltMStockCompanyPara);

		// Validate token
		String key = this.makeKey(dltMStockCompanyPara.getUserId(), AbstractBaseController.PREFIX_UDT_KEY);
		if (!dltMStockCompanyPara.getToken().equals(commonBean.getTokenExpireMap(key))) {
			logger.error("dltMStockCompany - token is wrong. parameter token=" + dltMStockCompanyPara.getToken() + ", server token=" + commonBean.getTokenExpireMap(key));
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.token.message", null, locale));
			model.addAttribute("errorMessage", mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Execute the transaction
		if (!stockService.dltStockCompany(dltMStockCompanyPara)) {
			logger.error("dltStockCompany - deleting is error. userId={}, usmNo={}", dltMStockCompanyPara.getUserId(), dltMStockCompanyPara.getUscNo());
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.delete.error.message", null, locale));
			model.addAttribute("mapErrorMessage", mapErrorMessage);
			return "apps/errors/systemErrors";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/plugins/stock";
	}

	@RequestMapping(value = { "dltStock" })
	public String dltStock(@Valid DltStockPara dltStockPara, BindingResult bindingResult, ModelMap model,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws Exception {

		AbilistsModel abilistsModel = new AbilistsModel();
		abilistsModel.setNavi("plugins");
		abilistsModel.setMenu("stock");

		// Set language in Locale.
		Locale locale = RequestContextUtils.getLocale(request);

		Map<String, String> mapErrorMessage = new HashMap<String, String>();
		// If it occurs errors, set the default value.
		if (bindingResult.hasErrors()) {
			logger.error("dltStock - There are parameter errors.");
			response.setStatus(400);
			mapErrorMessage = this.handleErrorMessages(bindingResult.getAllErrors(), locale);
			model.addAttribute("mapErrorMessage",  mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Set user id
		this.handleSessionInfo(request.getSession(), dltStockPara);

		// Validate token
		String key = this.makeKey(dltStockPara.getUserId(), AbstractBaseController.PREFIX_UDT_KEY);
		if (!dltStockPara.getToken().equals(commonBean.getTokenExpireMap(key))) {
			logger.error("dltStock - token is wrong. parameter token=" + dltStockPara.getToken() + ", server token=" + commonBean.getTokenExpireMap(key));
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.error.token.message", null, locale));
			model.addAttribute("errorMessage", mapErrorMessage);
			return "apps/errors/parameterErrors";
		}

		// Execute the transaction
		if (!stockService.dltStock(dltStockPara)) {
			logger.error("dltStock - deleting is error. userId={}, usmNo={}", dltStockPara.getUserId(), dltStockPara.getUstNo());
			mapErrorMessage.put("errorMessage", message.getMessage("parameter.delete.error.message", null, locale));
			model.addAttribute("mapErrorMessage", mapErrorMessage);
			return "apps/errors/systemErrors";
		}

		// Pass the parameters with post.
		redirectAttributes.addFlashAttribute("save", "completed");
		return "redirect:/plugins/stock/sltStockList/" + dltStockPara.getUscNo();
	}

}