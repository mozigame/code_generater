package ${module}.model;
<#list columns as column>
<#if column.javaType=="Date">

import java.util.Date;

<#break>
</#if>
</#list>
import com.babel.common.core.entity.BaseEntityTimestamp;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import lombok.Data;
import lombok.EqualsAndHashCode;

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

@EqualsAndHashCode(callSuper = true)
@Table(name = "${tableName}")
@XmlRootElement(name="${entityName?uncap_first}")
@JsonInclude(Include.NON_NULL)
@Data
public class ${entityName}PO extends BaseEntityTimestamp {
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
    <#if column.javaType=="Date">
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    </#if>
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

}