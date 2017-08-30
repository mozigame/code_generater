package org.caco.generator.util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.caco.generator.bean.Column;
import org.caco.generator.bean.Table;

public class MySqlHelper implements DBHelper {
	DataSource dataSource = null;
	List<Table> tables = null;
	
	
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	/**
	 * 查找所有的表
	 * 
	 * @return
	 */
	private List<Table> getAllTables() {
		Connection conn = dataSource.getConnection();
		List<Table> result = new ArrayList<Table>();
		try {
			DatabaseMetaData dmd = conn.getMetaData();
			ResultSet rs = dmd.getTables(null, dataSource.getUsername().toUpperCase(), "%", new String[] { "TABLE", "VIEW" });
			String _str = "";
			while (rs.next()) {
				String tableName = rs.getString(3);
				// oracle中的垃圾表都以BIN$开头
				if (tableName.startsWith("BIN$"))
					continue;// 跳过垃圾表
				Table t = new Table();
				t.setTableName(rs.getString(3));
				t.setTableType(rs.getString(4));
				_str = rs.getString("REMARKS");
				if(_str != null) {
					_str = _str.replaceAll("\r|\n", "");
				}
				t.setComment(_str);
				t.setEnglish(t.getEntityName());
				result.add(t);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dataSource.closeConn(conn);
		}
		return result;
	}

	/**
	 * 获取指定表的所有字段信息
	 * 
	 * @param tableName
	 * @return
	 */
	private List<Column> getAllColumns(String tableName) {
		Connection conn = dataSource.getConnection();
		List<Column> result = new ArrayList<Column>();
		try {
			DatabaseMetaData dmd = conn.getMetaData();
			ResultSet rs = dmd.getColumns(null, dataSource.getUsername().toUpperCase(), tableName, "%");
			while (rs.next()) {
				Column c = new Column();
				c.setColumnName(rs.getString(4));
				c.setFieldName(CodeUtil.getFieldName(c.getColumnName()));
				String typeName = rs.getString(6);
				int columnSize = rs.getInt(7);
				int precision = rs.getInt(9);
				c.setDbType(CodeUtil.getDbType(typeName, columnSize, precision));
				c.setJavaType(CodeUtil.getJavaType(typeName, columnSize, precision));
				if (columnSize == 0 && ("NUMBER".equals(typeName) || "INT".equals(typeName)))
					c.setColumnSize(10 + "");// 默认给10
				else
					c.setColumnSize(columnSize + "");
				c.setPrecision(precision + "");
				c.setEnglish(CodeUtil.getDefaultEnglishName(c.getColumnName()));
				c.setComment(rs.getString("REMARKS"));
				// 查找主键
				String primary = getPrimaryKey(tableName);
				if (c.getColumnName().equals(primary))
					c.setPrimary(true);
				else
					c.setPrimary(false);
				result.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dataSource.closeConn(conn);
		}
		return result;
	}

	// 获取表主键
	public String getPrimaryKey(String tableName) {
		Connection conn = dataSource.getConnection();
		String primary = null;
		try {
			DatabaseMetaData dmd = conn.getMetaData();
			ResultSet rs = dmd.getPrimaryKeys(null, dataSource.getUsername().toUpperCase(), tableName);
			while (rs.next()) {
				primary = rs.getString(4);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dataSource.closeConn(conn);
		}
		return primary;
	}

	/**
	 * 按表名返回表结构
	 * @tableName 
	 */
	public Table getTable(String tableName) {
		if(tables == null) {
			tables = getAllTables();
		}
		for (Table t : tables) {
			if(t.getTableName().equals(tableName)) {
				t.setColumns(getAllColumns(tableName));
				return t;
			}
		}
		return null;
	}

}
