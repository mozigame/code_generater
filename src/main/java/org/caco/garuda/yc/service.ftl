package ${module}.service;

import ${module}.model.${entityName}PO;
<#list columns as column>
<#if column.fieldName=="ifDel">
import com.babel.common.core.data.RetData;
<#break>
</#if>
</#list>
import com.babel.common.core.exception.BaseException;
import com.babel.common.core.page.PageVO;
import com.babel.common.core.service.IBaseService;

import java.util.List;
import java.util.Map;

public interface I${entityName}Service  extends IBaseService<${entityName}PO> {
	
	${entityName}PO findById(Long id);
	
	List<${entityName}PO> findByIds(List<Long> ids);
	
	Map<Long, ${entityName}PO> findMapByIds(List<Long> ids);
	
	List<${entityName}PO> findBy${entityName}(${entityName}PO ${entityName?uncap_first});
	
	${entityName}PO findOneBy${entityName}(${entityName}PO ${entityName?uncap_first}) throws BaseException;
	
	PageVO<${entityName}PO> findPageBy${entityName}(${entityName}PO ${entityName?uncap_first}, PageVO<${entityName}PO> page);
<#list columns as column>
<#if column.fieldName=="ifDel">
	RetData<Integer> deleteVirtual(Long userId, Long cid) throws BaseException;
<#break>
</#if>
</#list>
	
}
