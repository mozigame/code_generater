package org.caco.generator.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import freemarker.core.ParseException;
import freemarker.template.Configuration;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;
import freemarker.template.Version;

public class CodeUtil {
	
	public final static String VERSION = "2.3.23";
	public final static String ROOT = "org/caco/garuda/yc";
	
	/**
	 * 首字母小写
	 * @param value
	 * @return
	 */
	public static String toLowerCaseFirstChar(String value) {
		if(value==null || value.trim().equals("")) {
			return value;
		} else if(value.length()==1) {
			return value.toLowerCase();
		}
		return value.substring(0, 1).toLowerCase()+ value.substring(1);
		
	}
	
	/**
	 * 生成驼峰命名的属性名
	 * @param columnName
	 * @return
	 */
	public static String getFieldName(String columnName){
		String[] array = columnName.split("_+");
		String result = "";
		for(int i = 0; i < array.length; i++){
			if(i == 0) {
				result += array[i].toLowerCase();
			} else{
				result += array[i].substring(0, 1).toUpperCase();
				result += array[i].substring(1).toLowerCase();
			}
			
		}
		return result;
	}
	
	/**
	 * 栏位转成英文，如user_name:User Name
	 * @param columnName
	 * @return
	 */
	public static String getDefaultEnglishName(String columnName){
		String[] array = columnName.split("_+");
		String result = "";
		for(int i = 0; i < array.length; i++){
			result += array[i].substring(0, 1).toUpperCase();
			result += array[i].substring(1).toLowerCase();
			if(i != array.length - 1)
				result += " ";
			
		}
		return result;		
	}
	
	/**
	 * 获取数据库类型
	 * @param typeName 类型类名,如 VARCHAR2,NUMBER...
	 * @param columnSize 类型大小
	 * @param precision 精度
	 * @return
	 */
	public static String getDbType(String typeName,int columnSize,int precision){
		if("DATE".equals(typeName) || "TIMESTAMP".equals(typeName) || "DATETIME".equals(typeName)
				|| "DOUBLE".equals(typeName) || "FLOAT".equals(typeName))
			return typeName;
		else if("NUMBER".equals(typeName)) {
			if(columnSize == 0)
				return typeName;
			return typeName + "(" + columnSize + "," + precision + ")";
		} else if("INT".equals(typeName)){
			return typeName + "(" + columnSize + ")";
		} else {
			return typeName + "(" + columnSize + ")";
		}
	}
	
	/**
	 * 获取属性类型
	 * @param typeName
	 * @param columnSize
	 * @param precision
	 * @return
	 */
	public static String getJavaType(String typeName,int columnSize,int precision){
		if(typeName.startsWith("VARCHAR") || typeName.startsWith("CHAR")){
			return "String";
		} else if(typeName.startsWith("DECIMAL") || typeName.startsWith("NUMBER") || typeName.startsWith("INT") || typeName.startsWith("BIGINT")){
			if( precision != 0 )
				return "Double";
			else if( columnSize < 3 )
				return "Byte";
			else if( columnSize < 5 )
				return "Short";
			else if( columnSize < 12 )
				return "Integer";
			else
				return "Long";
		} else if( "DOUBLE".equals(typeName) ){
			return "Double";
		} else if( "Float".equals(typeName) ){
			return "Float";
		} else if( "DATE".equals(typeName) || "TIMESTAMP".equals(typeName) || "DATETIME".equals(typeName) ){
			return "Date";
		} else if( "DECIMAL".equals(typeName) ){
			return "Long";
		} else if( "TEXT".equals(typeName) ){
			return "String";
		} else {
			return typeName;
		}
	}
	
	/**
	 * sort java type to full java type
	 * @param javaType
	 * @return
	 */
	public static String getFullJavaType(String javaType){
		if("Date".equals(javaType))
			return "java.util.Date";
		else
			return "java.lang."+javaType;
	}
	
	/**
	 * 生成代码文件
	 * @param ftl 模板文件名
	 * @param model
	 * @param outputName 输出目标路径
	 */
	public static void genereateCode(String ftl,Object model,String outputName){
		Configuration cfg = new Configuration(new Version(VERSION));
		cfg.setClassLoaderForTemplateLoading(CodeUtil.class.getClassLoader(), ROOT);
		cfg.setDefaultEncoding("UTF-8");
		BufferedOutputStream bos = null;
		PrintWriter writer = null;
		try {
			File target = new File(outputName);
			if(target.exists())
				target.delete();
			File dir = new File(target.getParent());
			if(!dir.exists())
				dir.mkdirs();
			bos = new BufferedOutputStream(new FileOutputStream(target,true));
			writer = new PrintWriter(bos,true);
			Template template = cfg.getTemplate(ftl);
			template.process(model, writer);
		} catch (TemplateNotFoundException e) {
			e.printStackTrace();
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		} finally {
			if(bos != null)
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			if(writer != null)
				writer.close();
		}
	}
	
}
