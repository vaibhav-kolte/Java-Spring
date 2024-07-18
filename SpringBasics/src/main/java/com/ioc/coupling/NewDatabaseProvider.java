package com.ioc.coupling;

public class NewDatabaseProvider implements UserDataProvider {
    @Override
    public String getUserDetails() {
        return "New database in action";
    }
}
