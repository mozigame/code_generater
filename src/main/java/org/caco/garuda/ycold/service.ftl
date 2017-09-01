package ${module}.service;

import java.util.List;

import com.babel.common.core.data.RetResult;
import com.babel.common.core.exception.RetException;
import com.babel.common.core.page.PageVO;
import com.babel.common.core.service.IBaseService;
import ${module}.model.${entityName}PO;

public interface I${entityName}Service  extends IBaseService<${entityName}PO> {
	public List<${entityName}PO> selectBy${entityName}(${entityName}PO ${entityName?uncap_first});
	 
	public ${entityName}PO find${entityName}ById(Long id);
	
	public List<${entityName}PO> find${entityName}ByIds(List<Long> ids);
	
	public PageVO<${entityName}PO> findPageBy${entityName}(${entityName}PO search, PageVO<${entityName}PO> page);
	
	public RetResult<Long> update(${entityName}PO record);
	
	public RetResult<Long> create(${entityName}PO record);
	
	public RetResult<Integer> deleteVirtual(Long cid) throws RetException;
	
	
}
