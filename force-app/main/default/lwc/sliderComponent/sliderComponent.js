import { LightningElement } from 'lwc';
import Pic1 from "@salesforce/resourceUrl/Pic1";
import Pic2 from "@salesforce/resourceUrl/Pic2";
import Pic3 from "@salesforce/resourceUrl/Pic3";
import googleUrl from "@salesforce/label/c.google";
export default class SliderComponent extends LightningElement {
Pos1=Pic1;
Pos2=Pic2;
Pos3=Pic3;
url=googleUrl;

handleNavigation(event){
    const targetUrl = event.currentTarget.dataset.url;
    console.log('Navigating to:', targetUrl);
    window.location.href = targetUrl; 
}

}