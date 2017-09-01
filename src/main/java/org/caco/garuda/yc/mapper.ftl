package ${module}.mapper;

import ${module}.model.${entityName}PO;
import com.babel.common.core.page.PageVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.MapperMy;

import java.util.List;

@Repository
public interface ${entityName}Mapper extends MapperMy<${entityName}PO> {
	List<${entityName}PO> find${entityName}ListByPage(@Param("param")${entityName}PO param, @Param("page")PageVO<${entityName}PO> page);
	int find${entityName}ListByPageCount(@Param("param") ${entityName}PO record);
}