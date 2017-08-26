import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
declare var window;
@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  constructor(public navCtrl: NavController) {

  }

  mobileNumberVerify(){
     const options = {
      accentColor: '#dfdfdf',
      backgroundColor: '#ffffff',
      };

      window.plugins.digits.authenticate(options,
      (oAuthHeaders) => {
        alert("Your mobile number "+oAuthHeaders.phoneNumber+" is verification successfully")
        console.log("success",oAuthHeaders);
      },
      (error) => {
        console.warn("[Digits]", "Login failed", error);
      }
      );
  }

}
