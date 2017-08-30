package ${module}.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.babel.core.page.PageVO;
import ${module}.model.${entityName}PO;
import tk.mybatis.mapper.common.Mapper;

public interface ${entityName}Mapper extends Mapper<${entityName}PO> {
	List<${entityName}PO> find${entityName}ListByPage(@Param("param")${entityName}PO param, @Param("page")PageVO<${entityName}PO> page);
	int find${entityName}ListByPageCount(@Param("param") ${entityName}PO record);
}