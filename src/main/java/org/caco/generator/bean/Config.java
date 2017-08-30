package org.caco.generator.bean;

public class Config {
	// button checkbox radio date file hidden image email number color datetime
	private String tableName;
	private String entityName;
	private String modelName;
	private String pakeage;
	private String author;
	private String equalsSearchColumns;
	private String likeSearchColumns;
	private String hidePOColumns;
	private String hideGridColumns;
	private String renderColumns;
	private String dictColumns;
	private String dictAllColumns;
	private String fkColumns;
	public String getDictAllColumns() {
		return dictAllColumns;
	}

	public void setDictAllColumns(String dictAllColumns) {
		this.dictAllColumns = dictAllColumns;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public String getModelName() {
		return modelName;
	}

	public void setModelName(String modelName) {
		this.modelName = modelName;
	}

	public String getPakeage() {
		return pakeage;
	}

	public void setPakeage(String pakeage) {
		this.pakeage = pakeage;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getEqualsSearchColumns() {
		return equalsSearchColumns;
	}

	public void setEqualsSearchColumns(String equalsSearchColumns) {
		this.equalsSearchColumns = equalsSearchColumns;
	}

	public String getLikeSearchColumns() {
		return likeSearchColumns;
	}

	public void setLikeSearchColumns(String likeSearchColumns) {
		this.likeSearchColumns = likeSearchColumns;
	}

	public String getHidePOColumns() {
		return hidePOColumns;
	}

	public void setHidePOColumns(String hidePOColumns) {
		this.hidePOColumns = hidePOColumns;
	}

	public String getHideGridColumns() {
		return hideGridColumns;
	}

	public void setHideGridColumns(String hideGridColumns) {
		this.hideGridColumns = hideGridColumns;
	}

	public String getRenderColumns() {
		return renderColumns;
	}

	public void setRenderColumns(String renderColumns) {
		this.renderColumns = renderColumns;
	}

	public String getDictColumns() {
		return dictColumns;
	}

	public void setDictColumns(String dictColumns) {
		this.dictColumns = dictColumns;
	}

	public String getFkColumns() {
		return fkColumns;
	}

	public void setFkColumns(String fkColumns) {
		this.fkColumns = fkColumns;
	}
	
}
