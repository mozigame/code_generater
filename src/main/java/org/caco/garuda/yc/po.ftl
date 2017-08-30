package ${module}.model;
<#list columns as column>
<#if column.javaType=="Date">

import java.util.Date;

<#break>
</#if>
</#list>
import com.babel.core.entity.BaseEntityOnId;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

<#list columns as column>
<#if column.javaType=="Date">
import com.fasterxml.jackson.annotation.JsonFormat;
<#break>
</#if>
</#list>
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

@Table(name = "${tableName}")
@XmlRootElement(name="${entityName?uncap_first}")
@JsonInclude(Include.NON_NULL)
public class ${entityName}PO extends BaseEntityOnId {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

<#list columns as column>
	<#if column.showInPO>
	/**
     * ${column.comment}
     */
    <#if column.fieldName=="cid">
    @Id
    @SequenceGenerator(name="",sequenceName="select _nextval('_${prefix}_${entityName?uncap_first}_cid_seq')")
    </#if>
    @Column(name = "${column.columnName}")
    private ${column.javaType} ${column.fieldName};
	<#if column.FK>
	
	/**
     * ${column.fieldName}外键关联值
     */
    @Transient
    private String ${column.fkRelField}Name;
    </#if>
    
    </#if>
</#list>
<#list columns as column>
<#if column.showInPO> 
    /**
     * 获取${column.comment}
     *
     * @return ${column.fieldName} - ${column.comment}
     */
    <#if column.javaType=="Date">
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    </#if>
    public ${column.javaType} get${column.fieldName?cap_first}() {
        return ${column.fieldName};
    }

   	/**
     * 设置${column.comment}
     *
     * @param ${column.fieldName} ${column.comment}
     */
    public void set${column.fieldName?cap_first}(${column.javaType} ${column.fieldName}) {
        this.${column.fieldName} = ${column.fieldName};
    }
	
	<#if column.FK>
	/**
     * ${column.fieldName}外键关联值get
     */
    public String get${column.fkRelField?cap_first}Name() {
        return ${column.fkRelField}Name;
    }

   	/**
     * ${column.fieldName}外键关联值set
     */
    public void set${column.fkRelField?cap_first}Name(String ${column.fkRelField}Name) {
        this.${column.fkRelField}Name = ${column.fkRelField}Name;
    }
    </#if>
</#if>
</#list>
    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        ${entityName}PO other = (${entityName}PO) that;
        return <#list columns as column><#if column.fieldName=="cid"><#else>            && </#if>(this.get${column.fieldName?cap_first}() == null ? other.get${column.fieldName?cap_first}() == null : this.get${column.fieldName?cap_first}().equals(other.get${column.fieldName?cap_first}()))<#if columns?size-1==column_index >;</#if>
        </#list>
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        <#list columns as column>
        	result = prime * result + ((get${column.fieldName?cap_first}() == null) ? 0 : get${column.fieldName?cap_first}().hashCode());
        </#list>
        return result;
    }
}