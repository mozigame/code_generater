package org.caco.generator.util;

import org.caco.generator.bean.Table;

public interface DBHelper {
	public String getPrimaryKey(String tableName);
	public Table getTable(String tableName);
}
