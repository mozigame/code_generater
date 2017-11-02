package ${module}.controller;

<#assign hasDate="false">
<#assign hasIfDel="false">
<#assign hasStatus="false">
<#assign hasCreateTime="false">
<#assign hasModifyTime="false">
<#assign hasCreateDate="false">
<#assign hasModifyDate="false">
<#assign hasCreateUser="false">
<#assign hasModifyUser="false">
<#list columns as column>
<#if column.javaType=="Date">
<#assign hasDate="true">
</#if>
<#if column.fieldName=="ifDel">
<#assign hasIfDel="true">
</#if>
<#if column.fieldName=="status">
<#assign hasStatus="true">
</#if>
<#if column.fieldName=="createTime">
<#assign hasCreateTime="true">
</#if>
<#if column.fieldName=="modifyTime">
<#assign hasModifyTime="true">
</#if>
<#if column.fieldName=="createDate">
<#assign hasCreateDate="true">
</#if>
<#if column.fieldName=="modifyDate">
<#assign hasModifyDate="true">
</#if>
<#if column.fieldName=="createUser">
<#assign hasCreateUser="true">
</#if>
<#if column.fieldName=="modifyUser">
<#assign hasModifyUser="true">
</#if>
</#list>	
<#if hasModifyTime=="true">
import java.util.Date;

</#if>
<#if hasFK>
import java.util.ArrayList;
import java.util.List;

</#if>
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.logging.Log;
import com.alibaba.druid.support.logging.LogFactory;

import com.babel.common.core.data.RetData;
import com.babel.common.core.page.PageVO;
<#if hasIfDel=="true">
import com.babel.common.web.context.AppContext;
import com.babel.common.core.exception.BaseException;
</#if>
import com.babel.common.web.controller.WebBaseController;
import ${module}.model.${entityName}PO;
import ${module}.service.I${entityName}Service;

/**
 * @author ${author}
 * @since ${.now}
 */
@RestController
@RequestMapping("/apis/${entityName?uncap_first}")
public class ${entityName}Controller extends WebBaseController {
	private static final Log logger = LogFactory.getLog(${entityName}Controller.class);

    @Autowired
    private I${entityName}Service ${entityName?uncap_first}Service;
    
    <#list columns as column>
	<#if column.showInPO && column.FK>
	@Autowired
    private I${column.fkRelField?cap_first}Service ${column.fkRelField?uncap_first}Service;
    </#if>
	</#list>
		

    @GetMapping(value = {"list"})
    public RetData<PageVO<${entityName}PO>> findByPage(${entityName}PO ${entityName?uncap_first}) {
    	PageVO<${entityName}PO> pageVO = new PageVO<>(this.getRequest());
    	pageVO = ${entityName?uncap_first}Service.findPageBy${entityName}(${entityName?uncap_first}, pageVO);
    	<#list columns as column>
		<#if column.showInPO && column.FK>
	    //${column.fieldName}外键关联值${column.fkRelField}Name;
		List<Long> ${column.fieldName}List = new ArrayList<Long>();
	    try {
    		${column.fieldName}List = ObjectToMapUtil.getDataPropListByName(pageVO.getRows(), "${column.fieldName}");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<${column.fkRelField?cap_first}PO> ${column.fkRelField}POList = ${column.fkRelField}Service.find${column.fkRelField?cap_first}ByIds(${column.fieldName}List);
	    </#if>
		</#list>
		<#if hasFK>
		for (${entityName}PO ${entityName?uncap_first}PO : pageVO.getRows()) {
		</#if>
		<#list columns as column>
		<#if column.showInPO && column.FK>
			for (${column.fkRelField?cap_first}PO ${column.fkRelField}PO : ${column.fkRelField}POList) {
				if(${entityName?uncap_first}PO.get${column.fkRelField?cap_first}Id() == ${column.fkRelField}PO.getCid()) {
					${entityName?uncap_first}PO.set${column.fkRelField?cap_first}Name(${column.fkRelField}PO.getName());
					break;
				}
			}
	    </#if>
		</#list>
		<#if hasFK>
		}
		</#if>
    	return new RetData<>(pageVO);
    }


    @GetMapping(value = "view")
    public RetData<${entityName}PO> view(${entityName}PO ${entityName?uncap_first}) {
        if (${entityName?uncap_first}.getCid() != null) {
            ${entityName?uncap_first} = ${entityName?uncap_first}Service.selectByKey(${entityName?uncap_first}.getCid());
        }
        return new RetData<>(${entityName?uncap_first});
    }
    

    /**
     * save or update
     * @param ${entityName?uncap_first}
     * @return
     */
    @RequestMapping(value = "save")
    public RetData<Long> save(
		@RequestBody ${entityName}PO ${entityName?uncap_first}
	) {
        if (${entityName?uncap_first}.getCid() != null) {
        	logger.info("${entityName?uncap_first}Service.updateNotNull,cid="+${entityName?uncap_first}.getCid());
        	<#if hasModifyTime=="true">
        	${entityName?uncap_first}.setModifyTime(System.currentTimeMillis());
        	</#if>
			<#if hasModifyUser=="true">
			${entityName?uncap_first}.setModifyUser(1L);
			</#if>
            ${entityName?uncap_first}Service.updateNotNull(${entityName?uncap_first});
        } else {
        	logger.info("${entityName?uncap_first}Service.save,cid="+${entityName?uncap_first}.getCid());
        	<#if hasIfDel=="true">
        	${entityName?uncap_first}.setIfDel(0);
        	</#if>
        	<#if hasStatus=="true">
        	${entityName?uncap_first}.setStatus(0);
        	</#if>
        	<#if hasCreateTime=="true">
        	${entityName?uncap_first}.setCreateTime(System.currentTimeMillis());
        	</#if>
        	<#if hasModifyTime=="true">
        	${entityName?uncap_first}.setModifyTime(System.currentTimeMillis());
        	</#if>
        	<#if hasCreateUser=="true">
        	${entityName?uncap_first}.setCreateUser(1L);
        	</#if>
        	<#if hasModifyUser=="true">
        	${entityName?uncap_first}.setModifyUser(1L);
        	</#if>
            ${entityName?uncap_first}Service.save(${entityName?uncap_first});
        }
        return new RetData<>(${entityName?uncap_first}.getCid());
    }

	@RequestMapping(value = {"delete"})
    public RetData<Integer> delete(@RequestParam("id") Long id) {
        RetData<Integer> ret = new RetData<>();
		try {
			<#if hasIfDel=="true">
			Long userId = 1L;
			ret =this.${entityName?uncap_first}Service.deleteVirtual(userId, id);
			</#if>
			<#if hasIfDel=="false">
			${entityName?uncap_first}Service.delete(id);
			</#if>
		}<#if hasIfDel=="true"> catch (BaseException e) {
			return RetData.createByBaseException(e);
		}</#if> catch (Exception e) {
			return RetData.unknowError(e.getMessage());
		}
        return ret;
    }
}
