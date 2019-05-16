package com.sojson.site.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sojson.common.controller.BaseController;
import com.sojson.common.model.UPermission;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.site.service.SiteService;
/**
 * 
 * 开发公司：itboy.net<br/>
 * 版权：itboy.net<br/>
 * <p>
 * 
 * 用户权限管理
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建　周柏成　2016年5月26日 　<br/>
 * <p>
 * *******
 * <p>
 * @author zhou-baicheng
 * @email  i@itboy.net
 * @version 1.0,2016年5月26日 <br/>
 * 
 */
@Controller
@Scope(value="prototype")
@RequestMapping("site")
public class SiteController extends BaseController {
	
	@Autowired
	SiteService siteService;
	/**
	 * 工地列表
	 * @param findContent	查询内容
	 * @param pageNo		页码
	 * @param modelMap		参数回显
	 * @return
	 */
	@RequestMapping(value="index")
	public ModelAndView index(String findContent,ModelMap modelMap,Integer pageNo){
		modelMap.put("findContent", findContent);
		Pagination<UPermission> permissions = siteService.findPage(modelMap,pageNo,pageSize);
		return new ModelAndView("site/index","page",permissions);
	}	
	/**
	 * 文件图片上传
	 * @return
	 */
	@RequestMapping(value="fileupload",method=RequestMethod.GET)
	public ModelAndView fileUpload(){
		LoggerUtils.fmtDebug(getClass(), "fileUpload路径:fileUpload");	        
		return new ModelAndView("site/fileupload");
	}
	
	/** 
	 * 一次上传多张图片 
	 */  
	@RequestMapping(value="threefile",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> threeFileUpload(  
	        @RequestParam("file") CommonsMultipartFile files[],  
	        HttpServletRequest request,ModelMap model) {  
		try {
	  
	    List<String> list = new ArrayList<String>();  
	    // 获得项目的路径  
	    ServletContext sc = request.getSession().getServletContext();  
	    // 上传位置   
	    String path = "E:\\iot\\workspace_sitemanagersystem\\APMServruanjian\\APMServruanjian\\APMServ-v5.2.6\\APMServ5.2.6\\www\\htdocs" + "\\"; // 设定文件保存的目录  
		LoggerUtils.fmtDebug(getClass(), "图片路径:[%s]",path);	        

		
	    File f = new File(path);  
	    if (!f.exists())  
	        f.mkdirs();  
	  
	    for (int i = 0; i < files.length; i++) {  
	        // 获得原始文件名  
	        String fileName = files[i].getOriginalFilename();  
			LoggerUtils.fmtDebug(getClass(), "原始文件名:[%s]",fileName);	        
	        
	        // 新文件名  
	        String newFileName = fileName;  
	        if (!files[i].isEmpty()) {  
	            try {  
	                FileOutputStream fos = new FileOutputStream(path  
	                        + newFileName);  
	                InputStream in = files[i].getInputStream();  
	                int b = 0;  
	                while ((b = in.read()) != -1) {  
	                    fos.write(b);  
	                }  
	                fos.close();  
	                in.close();  
	            } catch (Exception e) {  
	                e.printStackTrace();  
	            }  
	        }  
			LoggerUtils.fmtDebug(getClass(), "上传图片到:[%s]",path + newFileName);	        
	        list.add(path + newFileName);  
	  
	    }  
	    // 保存文件地址，用于JSP页面回显  
//		return new ModelAndView("site/fileupload","fileList", list);
	    model.addAttribute("fileList", list);  
//	    return "site/fileupload"; 
		resultMap.put("status", 200);
		resultMap.put("imagesavepath", list);	    
		} catch (Exception e) {
			resultMap.put("status", 500);
			resultMap.put("message", "添加失败，请刷新后再试！");
		}
		return resultMap;
	}  
	
	/**
	 * 工地添加
	 * @param role
	 * @return
	 */
	@RequestMapping(value="addSite",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> addSite(UPermission psermission){
		try {
			UPermission entity = siteService.insertSelective(psermission);
			resultMap.put("status", 200);
			resultMap.put("entity", entity);
		} catch (Exception e) {
			resultMap.put("status", 500);
			resultMap.put("message", "添加失败，请刷新后再试！");
			LoggerUtils.fmtError(getClass(), e, "添加权限报错。source[%s]", psermission.toString());
		}
		return resultMap;
	}
	/**
	 * 删除权限，根据ID，但是删除权限的时候，需要查询是否有赋予给角色，如果有角色在使用，那么就不能删除。
	 * @param id
	 * @return
	 */
	@RequestMapping(value="deleteSiteById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteSiteById(String ids){
		LoggerUtils.fmtDebug(getClass(), "删除权限:[%s]",ids);	        
		
		return siteService.deletePermissionById(ids);
	}
}
