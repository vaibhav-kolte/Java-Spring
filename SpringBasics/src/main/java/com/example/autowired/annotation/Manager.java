package com.example.autowired.annotation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class Manager {
    // Example 1
//    private Employee employee;
//
//    @Autowired
//
//    public Manager(Employee employee) {
//        this.employee = employee;
//    }

    // Example 2
     @Autowired
     @Qualifier("employee")
     private Employee employee;


    @Override
    public String toString() {
        return "Manager{" +
                "employee=" + employee +
                '}';
    }
}
