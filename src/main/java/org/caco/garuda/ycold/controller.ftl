package ${module}.controller;

<#if hasFK>
import java.util.ArrayList;
import java.util.List;

</#if>
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.logging.Log;
import com.alibaba.druid.support.logging.LogFactory;

import com.babel.common.core.data.RetResult;
import com.babel.common.core.exception.RetException;
import com.babel.common.core.page.PageVO;
import com.babel.common.web.filter.BaseController;
import ${module}.model.${entityName}PO;
import ${module}.service.I${entityName}Service;

/**
 * @author liuzh_3nofxnp
 * @since 2015-09-19 17:15
 */
@Controller
@RequestMapping("/${project}/${simpleModule}/${entityName?uncap_first}")
public class ${entityName}Controller extends BaseController {
	private static final Log logger = LogFactory.getLog(${entityName}Controller.class);

    @Autowired
    private I${entityName}Service ${entityName?uncap_first}Service;
    
    <#list columns as column>
	<#if column.showInPO && column.FK>
	@Autowired
    private I${column.fkRelField?cap_first}Service ${column.fkRelField?uncap_first}Service;
    </#if>
	</#list>
		
    @RequestMapping(value = {"index", "index.html", ""})
    public ModelAndView index(${entityName}PO ${entityName?uncap_first}){
    	ModelAndView result = new ModelAndView("${project}/${simpleModule}/ey_${entityName?uncap_first}");
    	return result;
    }
    
    @RequestMapping(value = {"list"})
    @ResponseStatus(value = HttpStatus.OK)
    @ResponseBody
    public PageVO<${entityName}PO> findByPage(${entityName}PO ${entityName?uncap_first},
                                @RequestParam(required = false, defaultValue = "1") int page,
                                @RequestParam(required = false, defaultValue = "10") int rows) {
    	logger.info("-------findByPage-------");
    	PageVO<${entityName}PO> pageVO = new PageVO<${entityName}PO>(page, rows);
    	pageVO = ${entityName?uncap_first}Service.findPageBy${entityName}(${entityName?uncap_first}, pageVO);
    	if(pageVO.getDatas() == null || pageVO.getDatas().size() == 0) {
    		return pageVO;
    	}
    	<#list columns as column>
		<#if column.showInPO && column.FK>
	    //${column.fieldName}外键关联值${column.fkRelField}Name;
		List<Long> ${column.fieldName}List = new ArrayList<Long>();
	    try {
    		${column.fieldName}List = ObjectToMapUtil.getDataPropListByName(pageVO.getDatas(), "${column.fieldName}");
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<${column.fkRelField?cap_first}PO> ${column.fkRelField}POList = ${column.fkRelField}Service.find${column.fkRelField?cap_first}ByIds(${column.fieldName}List);
	    </#if>
		</#list>
		<#if hasFK>
		for (${entityName}PO ${entityName?uncap_first}PO : pageVO.getDatas()) {
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
    	return pageVO;
    }


    @RequestMapping(value = "view", method = RequestMethod.GET)
    @ResponseStatus(value = HttpStatus.OK)
    @ResponseBody
    public RetResult<${entityName}PO> view(${entityName}PO ${entityName?uncap_first}) {
    	RetResult<${entityName}PO> ret = new RetResult<${entityName}PO>();
        if (${entityName?uncap_first}.getCid() != null) {
            ${entityName?uncap_first} = ${entityName?uncap_first}Service.selectByKey(${entityName?uncap_first}.getCid());
        }
        ret.setData(${entityName?uncap_first});
        return ret;
    }
    

    /**
     * save or update
     * @param ${entityName?uncap_first}
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseStatus(value = HttpStatus.OK)
    @ResponseBody
    public RetResult<Long> save(${entityName}PO ${entityName?uncap_first}) {
//    	logger.info("------${entityName?uncap_first}--cid="+${entityName?uncap_first}.getCid()+" code="+${entityName?uncap_first}.getCode()+" nameCn="+${entityName?uncap_first}.getNameCn());
    	RetResult<Long> ret=new RetResult<Long>();
        if (${entityName?uncap_first}.getCid() != null) {
        	this.initUpdate(${entityName?uncap_first});
            ${entityName?uncap_first}Service.updateNotNull(${entityName?uncap_first});
        } else {
        	this.initCreate(${entityName?uncap_first});
            ${entityName?uncap_first}Service.create(${entityName?uncap_first});
        }
        ret.setData(${entityName?uncap_first}.getCid());
        return ret;
    }

    @RequestMapping(value = {"delete"})
    @ResponseStatus(value = HttpStatus.OK)
    @ResponseBody
    public RetResult<Integer> delete(@RequestParam("id") Long id) {
        RetResult<Integer> ret = new RetResult<Integer>();
		try {
			ret =this.${entityName?uncap_first}Service.deleteVirtual(id);
		} catch (RetException e) {
			ret.initError(RetResult.msg_codes.ERR_UNKNOWN , e.getMessage(), e);
		}
        return ret;
    }
    
}
