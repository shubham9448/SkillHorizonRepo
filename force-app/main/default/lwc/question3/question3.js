import { LightningElement } from 'lwc';

export default class Question3 extends LightningElement {
    billingAddress='';
    shippingAddress='';
    handleBillingAddressChange(event){
        this.billingAddress = event.target.value;
    }
    copyBillingToShipping(){
        this.shippingAddress = this.billingAddress;
    }
}