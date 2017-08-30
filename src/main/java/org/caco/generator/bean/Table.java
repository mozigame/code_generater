package org.caco.generator.bean;

import java.util.List;

/**
 * 表信息
 * @author 737878
 *
 */
public class Table {
	//用户名
	private String author;
	//表名
	private String tableName;
	//表类型
	private String tableType;
	//实体名
	private String entityName;
	//所属项目
	private String project;
	//所属模块,例如com.sf.module.ssv
	private String module;
	//模块简称,ssv
	private String simpleModule;
	//类注释
	private String comment;
	private String english;
	//excel模板名
	private String excelTpl;
	//主键序列
	private String sequence;
	//表名前缀
	private String prefix;
	//是否存在外键关联
	private boolean hasFK;
	//表结构
	private List<Column> columns;
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableType() {
		return tableType;
	}
	public void setTableType(String tableType) {
		this.tableType = tableType;
	}
	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	public String getModule() {
		return module;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public List<Column> getColumns() {
		return columns;
	}
	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getExcelTpl() {
		return excelTpl;
	}
	public void setExcelTpl(String excelTpl) {
		this.excelTpl = excelTpl;
	}
	public String getSequence() {
		return sequence;
	}
	public void setSequence(String sequence) {
		this.sequence = sequence;
	}
	public String getSimpleModule() {
		return simpleModule;
	}
	public void setSimpleModule(String simpleModule) {
		this.simpleModule = simpleModule;
	}
	public String getEnglish() {
		return english;
	}
	public void setEnglish(String english) {
		this.english = english;
	}
	
	public void setEqualsSearchColumns(String columnsStr) {
		if(columnsStr==null || columnsStr.trim().equals("")) {
			return;
		}
		columnsStr = columnsStr.trim();
		columnsStr += "," + columnsStr + ",";//只要判断fieldName是否在columnsStr中即可
		for (Column column : this.columns) {
			if (columnsStr.indexOf("," + column.getFieldName() + ",") != -1) {
				column.setEqualsSearch(true);
			}
		}
	}
	
	public void setLikeSearchColumns(String columnsStr) {
		if(columnsStr==null || columnsStr.trim().equals("")) {
			return;
		}
		columnsStr = columnsStr.trim();
		columnsStr += "," + columnsStr + ",";//只要判断fieldName是否在columnsStr中即可
		for (Column column : this.columns) {
			if (columnsStr.indexOf("," + column.getFieldName() + ",") != -1) {
				column.setLikeSearch(true);
			}
		}
	}
	
	/**
	 * 指定字段不在PO中生成，多个以,隔开
	 * @param columnsStr
	 */
	public void setHidePOColumns(String columnsStr) {
		if(columnsStr==null || columnsStr.trim().equals("")) {
			return;
		}
		columnsStr = columnsStr.trim();
		columnsStr += "," + columnsStr + ",";//只要判断fieldName是否在columnsStr中即可
		for (Column column : this.columns) {
			if (columnsStr.indexOf("," + column.getFieldName() + ",") != -1) {
				column.setShowInPO(false);
			} else if(columnsStr.indexOf(",!" + column.getFieldName() + ",") != -1) {
				column.setShowInPO(true);
			}
		}
	}
	
	/**
	 * 指定字段不在grid中显示
	 * @param columnsStr
	 */
	public void setHideGridColumns(String columnsStr) {
		if(columnsStr==null || columnsStr.trim().equals("")) {
			return;
		}
		columnsStr = columnsStr.trim();
		columnsStr += "," + columnsStr + ",";//只要判断fieldName是否在columnsStr中即可
		for (Column column : this.columns) {
			if (columnsStr.indexOf("," + column.getFieldName() + ",") != -1) {
				column.setShowInGrid(false);
			} else if(columnsStr.indexOf(",!" + column.getFieldName() + ",") != -1) {
				column.setShowInGrid(true);
			}
		}
	}
	
	/**
	 * 设置属性
	 * @param columnsStr
	 * @param type
	 * @throws Exception
	 */
	private void setRenderOrDictColumns(String columnsStr, String type) throws Exception {
		if(columnsStr==null || columnsStr.trim().equals("")) {
			return;
		}
		columnsStr = columnsStr.trim();
		String[] strs = columnsStr.split(",");
		String fieldName;
		String key;
		String[] subStrs;
		Column c;
		for (String str : strs) {
			subStrs = str.split(":");
			fieldName = subStrs[0];
			key = subStrs[1];
			c = getColumnByFieldName(fieldName);
			if(c == null) {
				throw new Exception(type+"栏位不存在:" + fieldName);
			} else {
				if(type.equals("render")) {
					c.setHasRender(true);
					c.setRenderKey(key);
				} else if(type.equals("dict")) {
					c.setHasDict(true);
					c.setDictKey(key);
				} else if(type.equals("dictAll")) {
					c.setHasDict(true);
					c.setDictKey(key);
					c.setHasDictAll(true);
				} else if(type.equals("fk")) {
					this.setHasFK(true);
					c.setFK(true);
					c.setFkRelField(key);
				}
			}
		}
		
	}
	/**
	 * 设置栏位的code转换成text的render
	 * @param columnsStr
	 * @throws Exception 
	 */
	public void setRenderColumns(String columnsStr) throws Exception {
		setRenderOrDictColumns(columnsStr, "render");
	}
	
	/**
	 * 设置栏位的下拉
	 * @param columnsStr
	 */
	public void setDictColumns(String columnsStr) throws Exception {
		setRenderOrDictColumns(columnsStr, "dict");
	}
	
	/**
	 * 设置栏位的下拉(包含all选项)
	 * @param columnsStr
	 */
	public void setDictAllColumns(String columnsStr) throws Exception {
		setRenderOrDictColumns(columnsStr, "dictAll");
	}
	
	/**
	 * 指定字段是否为FK
	 * @param columnsStr
	 * @throws Exception 
	 */
	public void setFKColumns(String columnsStr) throws Exception {
		setRenderOrDictColumns(columnsStr, "fk");
	}
	
	/**
	 * 通过fieldName获取栏位对象
	 * @param fieldName
	 * @return
	 */
	public Column getColumnByFieldName(String fieldName) {
		for (Column column : this.columns) {
			if(column.getFieldName().equals(fieldName)) {
				return column;
			}
		}
		return null;
	}
	public String getPrefix() {
		if(prefix==null || prefix.trim().equals("")) {
			return tableName.split("_")[0].toLowerCase();
		}
		return prefix;
	}
	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	public boolean isHasFK() {
		return hasFK;
	}
	public void setHasFK(boolean hasFK) {
		this.hasFK = hasFK;
	}
	
//	//获取resultMap名称
//	public String getResultMap(){
//		return this.getModule().replaceAll("\\.", "_")+"_pojo_"+this.getEntityName();
//	}
	
	
}
