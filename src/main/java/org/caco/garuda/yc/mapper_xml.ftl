<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${module}.mapper.${entityName}Mapper" >
    <resultMap id="BaseResultMap" type="${module}.model.${entityName}PO" >
    <!--
      WARNING - @mbggenerated
    -->
		<#list columns as column>
		<<#if column.primary >id<#else>result</#if> column="${column.columnName}" property="${column.fieldName}" jdbcType="${column.jdbcType}" />
		</#list>
	</resultMap>
  <sql id="Base_Column_List" >
    <!--
      WARNING - @mbggenerated
    -->
    <#list columns as column><#if column_index==0>${column.columnName}<#else>, ${column.columnName}</#if></#list>
  </sql>
  
  <sql id="find${entityName}ListByPage_Where_Clause" >
  		where if_del=0
  		<#list columns as column>
		<#if column.equalsSearch >
		<if test="param.${column.fieldName}!=null"> 
  			and ${column.columnName}=#${'{'}param.${column.fieldName}}
  		</if>
		</#if>
		<#if column.likeSearch >
		<if test="param.${column.fieldName}!=null">
  			and (${column.columnName} like CONCAT('%',#${'{'}param.${column.fieldName}},'%') and ${column.fieldName} like CONCAT('%',#${'{'}param.${column.fieldName}},'%'))
  		</if>
		</#if>
		</#list>
  		
  		<!--
  		<if test="param.name!=null">
  			and (name_cn like CONCAT('%',#${'{'}param.nameCn},'%') and name_en like CONCAT('%',#${'{'}param.nameCn},'%'))
  			and (name like #${'{'}param.name} or name like #${'{'}param.name})
  		</if>
  		-->
  </sql>
  
  <select id="find${entityName}ListByPage"  resultMap="BaseResultMap">
  	 select 
    <include refid="Base_Column_List" />
    from ${tableName}
    <include refid="find${entityName}ListByPage_Where_Clause" />
     limit #${'{'}page.pageBegin} , #${'{'}page.pageSize}
    
  </select>
  
  <select id="find${entityName}ListByPageCount" resultType="int" >
  	select count(*) from ${tableName}
  	 <include refid="find${entityName}ListByPage_Where_Clause" />
  </select>
</mapper>