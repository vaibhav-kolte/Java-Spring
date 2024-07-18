package com.ioc.coupling;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class IOCExample {
    public static void main(String[] args) {

        ApplicationContext context
                = new ClassPathXmlApplicationContext("applicationIoCLooseCouplingExample.xml");


        UserManager userManagerWIthDB
                = context.getBean("userManagerWithUserDataProvider", UserManager.class);
        System.out.println(userManagerWIthDB.getUserInfo());


        UserManager webServiceUserManager
                = context.getBean("userManagerWithWebServiceProvider", UserManager.class);
        System.out.println(webServiceUserManager.getUserInfo());


        UserManager newUserManager
                = context.getBean("userManagerWithNewDataProvider", UserManager.class);
        System.out.println(newUserManager.getUserInfo());
    }
}
