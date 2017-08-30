package org.caco.generator;

import org.caco.generator.bean.Config;
import org.caco.generator.bean.Table;
import org.caco.generator.util.CodeUtil;
import org.caco.generator.util.DBHelper;

/**
 * Hello world!
 *
 */
public class App 
{
	public static void main(String[] args) {
		Config config = (Config) BeanFactory.getBean("config");
		DBHelper dbHelper = (DBHelper) BeanFactory.getBean("mySqlHelper");
		Table t = dbHelper.getTable(config.getTableName());
		t.setEntityName(config.getEntityName());
		t.setProject(config.getModelName());
		t.setModule(config.getPakeage());
		t.setSimpleModule(t.getModule().substring(t.getModule().lastIndexOf(".") + 1));
		t.setAuthor(config.getAuthor());
		t.setEqualsSearchColumns(config.getEqualsSearchColumns());
		t.setLikeSearchColumns(config.getLikeSearchColumns());
		
		//如果在栏位面前添加"!"符号则代表设置此栏位显示
		//String defaulHidePOColumns = "code,name,version,currentUser,currentUserId,status,ifDel,createUser,createDate,modifyUser,modifyDate";
		//t.setHidePOColumns(defaulHidePOColumns);
		t.setHidePOColumns(config.getHidePOColumns());
		
		String defaulHideGridColumns = "cid";
		t.setHideGridColumns(defaulHideGridColumns);
		t.setHideGridColumns(config.getHideGridColumns());
		
		try {
			t.setFKColumns(config.getFkColumns());//外键关联
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			t.setRenderColumns(config.getRenderColumns());//code转text
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			t.setDictColumns(config.getDictColumns());//下拉绑定
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			t.setDictAllColumns(config.getDictAllColumns());//下拉绑定，包含all选项
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		gerenateCode(t, BeanFactory.getClassPath() + "/generated-sources");
		System.out.println("Generated success:"+BeanFactory.getClassPath() + "\\generated-sources");
	}
    
    /**
	 * 代码生成
	 * @param table
	 * @param path
	 */
	public static void gerenateCode(Table table,String path){
		if(path.endsWith("/"))
			path = path.substring(0, path.length() - 1);
		String servicePath = path + "/" + table.getProject() + "/intf/" +table.getModule().replace(".", "/");
		String serviceImplPath = path + "/" + table.getProject() + "/impl/" +table.getModule().replace(".", "/");
		String controllerPath = path + "/" + table.getProject() + "/controller/" +table.getModule().replace(".", "/");
		String xmlPath = path + "/" + table.getProject() + "/xml/" +table.getModule().replace(".", "/");
		String jspPath = path + "/" + table.getProject() + "/jsp/"+table.getProject()+"/";
		String curPath = path + "/" + table.getProject() + "/";
		
		CodeUtil.genereateCode("service.ftl",table,servicePath+"/service/I"+table.getEntityName()+"Service.java");
		CodeUtil.genereateCode("po.ftl",table,servicePath+"/model/"+table.getEntityName()+"PO.java");
		
		CodeUtil.genereateCode("mapper.ftl",table,serviceImplPath+"/mapper/"+table.getEntityName()+"Mapper.java");
		CodeUtil.genereateCode("service_impl.ftl",table,serviceImplPath+"/service/impl/"+table.getEntityName()+"ServiceImpl.java");
		CodeUtil.genereateCode("controller.ftl",table,controllerPath+"/controller/"+table.getEntityName()+"Controller.java");
		CodeUtil.genereateCode("mapper_xml.ftl",table,xmlPath+"/mapper/"+table.getEntityName()+"Mapper.xml");
		CodeUtil.genereateCode("jsp.ftl",table,jspPath+table.getSimpleModule()+"/ey_"+CodeUtil.toLowerCaseFirstChar(table.getEntityName())+".jsp");
		CodeUtil.genereateCode("sql.ftl",table,curPath + "/seq.sql");
		
	}
}
