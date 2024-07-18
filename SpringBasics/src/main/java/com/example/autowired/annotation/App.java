package com.example.autowired.annotation;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;


public class App {
    public static void main(String[] args) {
        ApplicationContext context
                = new AnnotationConfigApplicationContext(AppConfig.class);
        Employee employee = (Employee) context.getBean("employee"); // cast or add param
//        Employee employee = context.getBean("employee", Employee.class);
        System.out.println(employee);


        Manager manager = (Manager) context.getBean("manager");
        System.out.println(manager);
    }
}
