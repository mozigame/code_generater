package org.caco.generator;

import java.io.IOException;
import java.util.Map;

import org.caco.generator.bean.Config;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;
import org.springframework.core.io.ClassPathResource;

public class BeanFactory {
	 static ClassPathResource resource = new ClassPathResource("generatorConfig.xml");
	 static DefaultListableBeanFactory factory = new DefaultListableBeanFactory();
	 static XmlBeanDefinitionReader reader =  new XmlBeanDefinitionReader(factory);
     static{
    	 reader.loadBeanDefinitions(resource);
     }
     
     public static Object getBean(String beanId) {
    	 return factory.getBean(beanId);
     }

	public static Map<String, Config> getConfigBean() {
		Map<String, Config> beans = factory.getBeansOfType(Config.class);
		return beans;
	}


	public static String getClassPath() {
    	 try {
			String path =  resource.getFile().toString();
			path = path.substring(0, path.indexOf("target")+"target".length());
			return path;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	 return null;
     }
}
