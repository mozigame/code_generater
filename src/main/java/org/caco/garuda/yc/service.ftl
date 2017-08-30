package ${module}.service;

import java.util.List;
import java.util.Map;

<#list columns as column>
<#if column.fieldName=="ifDel">
import com.babel.core.data.RetData;
<#break>
</#if>
</#list>
import com.babel.core.exception.BaseException;
import com.babel.core.page.PageVO;
import com.babel.core.service.IBaseService;
import ${module}.model.${entityName}PO;

public interface I${entityName}Service  extends IBaseService<${entityName}PO> {
	
	public ${entityName}PO findById(Long id);
	
	public List<${entityName}PO> findByIds(List<Long> ids);
	
	public Map<Long, ${entityName}PO> findMapByIds(List<Long> ids);
	
	public List<${entityName}PO> findBy${entityName}(${entityName}PO ${entityName?uncap_first});
	
	public ${entityName}PO findOneBy${entityName}(${entityName}PO ${entityName?uncap_first}) throws BaseException;
	
	public PageVO<${entityName}PO> findPageBy${entityName}(${entityName}PO ${entityName?uncap_first}, PageVO<${entityName}PO> page);
<#list columns as column>
<#if column.fieldName=="ifDel">

	public RetData<Integer> deleteVirtual(Long userId, Long cid) throws BaseException;

<#break>
</#if>
</#list>
	
}
