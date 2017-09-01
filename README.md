# README #

This README would normally document whatever steps are necessary to get your application up and running.

### Ionic and Cordova Installation  ###
```
$ sudo npm install -g ionic cordova
```

### Create New project  ###

```
$ ionic start MobileNumberVerify
```
### Add platform  ###

Add Ios and android platform in project
```
$ ionic cordova platform add android
$ ionic cordova platform add ios
```

# Demo View #

![alt text](https://github.com/nakulkundaliya/Ionic-3-phone-number-verification-using-digits/tree/master/src/assets/ios.gif)


### Add cordova-plugin-digits plugin ###
```
#!cli

$ ionic cordova plugin add cordova-plugin-digits --variable FABRIC_API_KEY=XXXXXXXXXXXXXX --variable FABRIC_CONSUMER_KEY=XXXXXXXXXXXXXX --variable FABRIC_CONSUMER_SECRET=XXXXXXXXXXXXXX --save

```
Get Fabric api key from fabric.io/dashboard


### Customise plugin for getting verify phoneNumber ###


**ANDROID**

  - REMOVE ANDROID PLATFORM

      ionic platform rm android

  - OPEN CordovaDigits.java file

      goto plugins->cordova-plugin-digits->src->android->FabricPlugin.java

  - CHANGE CODE

      add following line of code inside authenticate() method after authHeaders object.(Approx 72 line number)

         authHeaders.put("phoneNumber", phoneNumber);

      then you get verify contact number


**IOS**

Nothing change in ios
