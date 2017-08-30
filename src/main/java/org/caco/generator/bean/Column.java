package org.caco.generator.bean;

/**
 * 列信息
 * @author 737878
 *
 */
public class Column {
	//列名
	private String columnName; 
	//属性名
	private String fieldName;
	//数据库类型
	private String dbType;
	//字段长度,hibernate配置需要
	private String columnSize;
	//小数位,hibernate配置需要
	private String precision;
	//属性类型,例如Long
	private String javaType;
	//属性类全名,例如,java.lang.Long
	private String fullJavaType;
	//注释
	private String comment;
	//英文名
	private String english;
	//是否主键
	private boolean primary;
	//是否表单查询
	private boolean equalsSearch;
	//是否表单查询
	private boolean likeSearch;
	//是否在PO中显示
	private boolean showInPO = true;
	//是否在grid中显示
	private boolean showInGrid = true;
	//是否有rander
	private boolean hasRender = false;
	//rander对应的关键字
	private String renderKey = "";
	//是否有dict
	private boolean hasDict = false;
	//是否有dictAll选项
	private boolean hasDictAll = false;
	//dict对应的关键字
	private String dictKey = "";
	//fk外键标识
	private boolean isFK;
	//外键需要关联的数据
	private String fkRelField;
	
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getDbType() {
		return dbType;
	}
	public void setDbType(String dbType) {
		this.dbType = dbType;
	}
	public String getJavaType() {
		return javaType;
	}
	public void setJavaType(String javaType) {
		this.javaType = javaType;
	}
	public boolean isPrimary() {
		return primary;
	}
	public void setPrimary(boolean primary) {
		this.primary = primary;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public boolean isEqualsSearch() {
		return equalsSearch;
	}
	public void setEqualsSearch(boolean equalsSearch) {
		this.equalsSearch = equalsSearch;
	}
	public boolean isLikeSearch() {
		return likeSearch;
	}
	public void setLikeSearch(boolean likeSearch) {
		this.likeSearch = likeSearch;
	}
	public String getFullJavaType() {
		return fullJavaType;
	}
	public void setFullJavaType(String fullJavaType) {
		this.fullJavaType = fullJavaType;
	}
	public String getColumnSize() {
		return columnSize;
	}
	public void setColumnSize(String columnSize) {
		this.columnSize = columnSize;
	}
	public String getPrecision() {
		return precision;
	}
	public void setPrecision(String precision) {
		this.precision = precision;
	}
	public String getJdbcType(){
		if("String".equals(this.getJavaType()) || "Character".equals(this.getJavaType()))
			return "VARCHAR";
		else if("Date".equals(this.getJavaType())){
			if("DATE".equalsIgnoreCase(this.getDbType()))
				return "DATE";
			else
				return "TIMESTAMP";
		}else if("Boolean".equals(this.getJavaType())) {
			return "BOOLEAN";
		} else if("Long".equals(this.getJavaType())) {
			return "DECIMAL";
		}  else if("Integer".equals(this.getJavaType())) {
			return "INTEGER";
		}else
			return "NUMERIC";
	}
	public String getEnglish() {
		return english;
	}
	public void setEnglish(String english) {
		this.english = english;
	}
	
	public boolean isSearch() {
		return equalsSearch || likeSearch;
	}
	public boolean isShowInPO() {
		return showInPO;
	}
	public void setShowInPO(boolean showInPO) {
		this.showInPO = showInPO;
	}
	public boolean isShowInGrid() {
		return showInGrid;
	}
	public void setShowInGrid(boolean showInGrid) {
		this.showInGrid = showInGrid;
	}
	public boolean isHasRender() {
		return hasRender;
	}
	public void setHasRender(boolean hasRender) {
		this.hasRender = hasRender;
	}
	public String getRenderKey() {
		return renderKey;
	}
	public void setRenderKey(String renderKey) {
		this.renderKey = renderKey;
	}
	public boolean isHasDict() {
		return hasDict;
	}
	public void setHasDict(boolean hasDict) {
		this.hasDict = hasDict;
	}
	public String getDictKey() {
		return dictKey;
	}
	public void setDictKey(String dictKey) {
		this.dictKey = dictKey;
	}
	public boolean isHasDictAll() {
		return hasDictAll;
	}
	public void setHasDictAll(boolean hasDictAll) {
		this.hasDictAll = hasDictAll;
	}
	public boolean isFK() {
		return isFK;
	}
	public void setFK(boolean isFK) {
		this.isFK = isFK;
	}
	public String getFkRelField() {
		return fkRelField;
	}
	public void setFkRelField(String fkRelField) {
		this.fkRelField = fkRelField;
	}
}
