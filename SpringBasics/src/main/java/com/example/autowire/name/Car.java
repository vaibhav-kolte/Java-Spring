package com.example.autowire.name;

public class Car {
    private Specification specification;

    public void setSpecification(Specification specification) {
        this.specification = specification;
    }

    public void displayDetails() {
        System.out.println("Car details: " + specification);
    }


    // TODO: Try comment above and un-comment blow code
//    private Specification specification1;
//
//    public void setSpecification1(Specification specification) {
//        this.specification1 = specification;
//    }
//
//    public void displayDetails() {
//        System.out.println("Car details: " + specification1);
//    }
}
