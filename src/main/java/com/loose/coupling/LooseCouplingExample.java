package com.loose.coupling;

public class LooseCouplingExample {
    public static void main(String[] args) {
        UserDataProvider dataProvider = new UserDatabaseProvider();
        UserManager userManagerWIthDB = new UserManager(dataProvider);
        System.out.println(userManagerWIthDB.getUserInfo());


        UserDataProvider webServiceDataProvider = new WebServiceDataProvider();
        UserManager webServiceUserManager = new UserManager(webServiceDataProvider);
        System.out.println(webServiceUserManager.getUserInfo());


        UserDataProvider newDataProvider = new NewDatabaseProvider();
        UserManager newUserManager = new UserManager(newDataProvider);
        System.out.println(newUserManager.getUserInfo());
    }
}
