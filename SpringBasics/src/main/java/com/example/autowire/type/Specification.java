package com.example.autowire.type;

public class Specification {
    private String make;
    private String model;

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        System.out.println("Make setter called");
        this.make = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        System.out.println("Model setter called");
        this.model = model;
    }

    @Override
    public String toString() {
        return "Specification{" +
                "make='" + make + '\'' +
                ", model='" + model + '\'' +
                '}';
    }
}
