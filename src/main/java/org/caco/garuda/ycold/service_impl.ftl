package ${module}.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.druid.support.logging.Log;
import com.alibaba.druid.support.logging.LogFactory;

import com.babel.common.core.data.RetResult;
import com.babel.common.core.exception.RetException;
import com.babel.common.core.page.PageVO;
import com.babel.common.core.service.impl.BaseService;
import ${module}.mapper.${entityName}Mapper;
import ${module}.model.${entityName}PO;
import ${module}.service.I${entityName}Service;
import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.mapperhelper.SqlHelper;

@Service("${entityName?uncap_first}Service")
public class ${entityName}ServiceImpl extends BaseService<${entityName}PO> implements I${entityName}Service{
	 private static final Log logger = LogFactory.getLog(${entityName}ServiceImpl.class);
	 //@Autowired
	 //private ILogDbService logDbService;
	
	@Autowired
	private ${entityName}Mapper ${entityName?uncap_first}Mapper;
	
	 @Override
		public Mapper<${entityName}PO> getMapper() {
			return ${entityName?uncap_first}Mapper;
		}
	
	@Override
	public ${entityName}PO find${entityName}ById(Long id) {
		logger.info("----find${entityName}ById--id="+id);
		SqlHelper.addIgnore(${entityName}PO.class, "name");
		return ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
	}
	
	@Override
	public List<${entityName}PO> find${entityName}ByIds(List<Long> ids) {
		Example example = new Example(${entityName}PO.class);
		Example.Criteria criteria = example.createCriteria();
		criteria.andIn("cid", ids);
		return ${entityName?uncap_first}Mapper.selectByExample(example);
	}
	
	@Override
    public List<${entityName}PO> selectBy${entityName}(${entityName}PO ${entityName?uncap_first}) {
		logger.info("----selectBy${entityName}--${entityName?uncap_first}="+${entityName?uncap_first});
		if(${entityName?uncap_first} == null) {
			${entityName?uncap_first} = new ${entityName}PO();
		}
		${entityName?uncap_first}.setStatus(1);
		${entityName?uncap_first}.setIfDel(0);
        return ${entityName?uncap_first}Mapper.select(${entityName?uncap_first});
    }
	
	public PageVO<${entityName}PO> findPageBy${entityName}(${entityName}PO search, PageVO<${entityName}PO> page) {
		logger.info("----find${entityName}ListByPage--");
		List<${entityName}PO> list=null;
		int totalSize=0;
		try {
			totalSize = ${entityName?uncap_first}Mapper.find${entityName}ListByPageCount(search);
			list = ${entityName?uncap_first}Mapper.find${entityName}ListByPage(search, page);
		} catch (Exception e) {
			logger.error("-----find${entityName}ListByPage--", e);
		}
		PageVO<${entityName}PO> pageRet=new PageVO<${entityName}PO>(list, totalSize, page.getPageSize(), page.getCurrentPage());
		return pageRet;
	}
	
	public RetResult<Long> create(${entityName}PO record){
		logger.info("----create--");
//		this.logDbService.info(record, "create", "start", 0l);
		RetResult<Long> ret = new RetResult<Long>();
//		if(StringUtils.isEmpty(record.getXxx())){
//			ret.initError(RetResult.msg_codes.ERR_DATA_INPUT, "xxx is empty", null);
//			logger.warn("create="+ret.getMsgBody());
//			return ret;
//		}
		record.initCreate();
		${entityName?uncap_first}Mapper.insert(record);
		ret.setData(record.getCid());
//		this.logDbService.info(record, "create", "end", System.currentTimeMillis()-time);
		return ret;
	}
	
	public RetResult<Long> update(${entityName}PO record){
		logger.info("----update--");
//		this.logDbService.info(record, "update", "start", 0l);
		RetResult<Long> ret = new RetResult<Long>();
		if(record.getCid()==null||record.getCid().longValue()==0){
			ret.initError(RetResult.msg_codes.ERR_DATA_INPUT, "cid="+record.getCid()+" is empty", null);
			return ret;
		}
		record.initUpdate();
		record.setIfDel(0);
		${entityName?uncap_first}Mapper.updateByPrimaryKey(record);
		ret.setData(record.getCid());
//		this.logDbService.info(record, "update", "end", System.currentTimeMillis()-time);
		return ret;
	}
	
	public RetResult<Integer> deleteVirtual(Long cid) throws RetException{
		logger.info("----update--");
//		this.logDbService.info(null, "update", "start", 0l);
		RetResult<Integer> ret = new RetResult<Integer>();
		if(cid==null||cid==0){
			ret.initError(RetResult.msg_codes.ERR_DATA_INPUT, "cid="+cid+" is empty", null);
			return ret;
		}
		${entityName}PO ${entityName?uncap_first} = new ${entityName}PO();
		${entityName?uncap_first}.setCid(cid);
		int v=0;
		try {
			v = this.deleteVirtual(${entityName?uncap_first});
		} catch (Exception e) {
			ret.initError(RetResult.msg_codes.ERR_UNKNOWN, "cid="+cid+",error="+e.getMessage(), e);
			throw new RetException(ret);
		}
		ret.setData(v);
//		this.logDbService.info(null, "update", "end", System.currentTimeMillis()-time);
		return ret;
	}

}
