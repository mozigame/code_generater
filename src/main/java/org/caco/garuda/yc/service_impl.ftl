package ${module}.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.alibaba.druid.support.logging.Log;
import com.alibaba.druid.support.logging.LogFactory;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.util.StringUtil;
<#list columns as column>
<#if column.fieldName=="ifDel">
import com.babel.common.core.data.RetData;
import com.babel.common.core.exception.InputNullException;
import com.babel.common.core.exception.UnknownException;
<#break>
</#if>
</#list>
import com.babel.common.core.exception.BaseException;
import com.babel.common.core.exception.MultiException;
import com.babel.common.core.page.PageVO;
import com.babel.common.core.service.impl.BaseService;
import ${module}.mapper.${entityName}Mapper;
import ${module}.model.${entityName}PO;
import ${module}.service.I${entityName}Service;

@Service("${entityName?uncap_first}Service")
public class ${entityName}ServiceImpl extends BaseService<${entityName}PO> implements I${entityName}Service{
	private static final Log logger = LogFactory.getLog(${entityName}ServiceImpl.class);
	
	@Autowired
	private ${entityName}Mapper ${entityName?uncap_first}Mapper;
	
	@Override
	public ${entityName}Mapper getMapper() {
		return ${entityName?uncap_first}Mapper;
	}
	
	@Override
	public ${entityName}PO findById(Long id) {
		logger.info("----${entityName}PO find${entityName}ById----id = "+id);
		return ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
	}
	
	@Override
	public List<${entityName}PO> findByIds(List<Long> ids) {
		logger.info("----find${entityName}ByIds----");
		Example example = new Example(${entityName}PO.class);
		Example.Criteria criteria = example.createCriteria();
		criteria.andIn("cid", ids);
		return ${entityName?uncap_first}Mapper.selectByExample(example);
	}
	
	@Override
	public Map<Long, ${entityName}PO> findMapByIds(List<Long> ids) {
		List<${entityName}PO> list = findByIds(ids);
		Map<Long, ${entityName}PO> map = new HashMap<>();
		if(list!=null) {
			for (${entityName}PO po : list) {
				map.put(po.getCid(), po);
			}
		}
		return map;
	}
	
	@Override
    public List<${entityName}PO> findBy${entityName}(${entityName}PO ${entityName?uncap_first}) {
		logger.info("----selectBy${entityName}----${entityName?uncap_first} = "+${entityName?uncap_first});
		if(${entityName?uncap_first} == null) {
			${entityName?uncap_first} = new ${entityName}PO();
		}
        return ${entityName?uncap_first}Mapper.select(${entityName?uncap_first});
    }
    
    @Override
    public ${entityName}PO findOneBy${entityName}(${entityName}PO ${entityName?uncap_first}) throws BaseException {
		logger.info("----selectBy${entityName}----${entityName?uncap_first} = "+${entityName?uncap_first});
		if(${entityName?uncap_first} == null) {
			${entityName?uncap_first} = new ${entityName}PO();
		}
        List<${entityName}PO> list = ${entityName?uncap_first}Mapper.select(${entityName?uncap_first});
		if(list == null || list.size()==0) {
			return null;
		}
		if(list.size() == 1) {
			return list.get(0);
		}
		throw new MultiException();
    }
	
	public PageVO<${entityName}PO> findPageBy${entityName}(${entityName}PO ${entityName?uncap_first}, PageVO<${entityName}PO> page) {
		logger.info("----findPageBy${entityName}----${entityName?uncap_first} = "+${entityName?uncap_first});
		if(${entityName?uncap_first} == null) {
			${entityName?uncap_first} = new ${entityName}PO();
		}
		Example example = new Example(${entityName}PO.class);
		Example.Criteria criteria = example.createCriteria();
		<#list columns as column>
		<#if column.equalsSearch >
  		if (${entityName?uncap_first}.get${column.fieldName?cap_first}() != null) {
			criteria.andEqualTo("${column.fieldName}", ${entityName?uncap_first}.get${column.fieldName?cap_first}());
		}
		</#if>
		<#if column.likeSearch >
		if (${entityName?uncap_first}.get${column.fieldName?cap_first}() != null) {
			criteria.andLike("${column.fieldName}", "%" + ${entityName?uncap_first}.get${column.fieldName?cap_first}() + "%");
		}
		</#if>
		</#list>
		<#list columns as column>
		<#if column.fieldName=="ifDel">
		criteria.andEqualTo("ifDel", 0);
		<#break>
		</#if>
		</#list>
		String orderClause = page.getOrderClause();
		if(StringUtil.isNotEmpty(orderClause)) {
			example.setOrderByClause(orderClause);
		}
		return selectPageByExample(example, page);
	}
<#list columns as column>
<#if column.fieldName=="ifDel">

	public RetData<Integer> deleteVirtual(Long userId, Long cid) throws BaseException {
		logger.info("----deleteVirtual----cid = "+cid);
		RetData<Integer> ret = new RetData<Integer>();
		if(cid == null || cid == 0){
			throw new InputNullException("cid不能为空", "CID");
		}
		${entityName}PO ${entityName?uncap_first} = new ${entityName}PO();
		${entityName?uncap_first}.setCid(cid);
		<#list columns as column>
		<#if column.fieldName=="modifyUser">
		${entityName?uncap_first}.setModifyUser(userId);
		<#break>
		</#if>
		</#list>
		int v = 0;
		try {
			${entityName?uncap_first}.setIfDel(1);
			v = this.getMapper().updateByPrimaryKeySelective(${entityName?uncap_first});
		} catch (Exception e) {
			logger.error("-----deleteVirtual----", e);
			throw new UnknownException("cid = "+cid+",error = "+e.getMessage());
		}
		ret.setData(v);
		return ret;
	}
	
<#break>
</#if>
</#list>

}
