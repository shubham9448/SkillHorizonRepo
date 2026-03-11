import { LightningElement } from 'lwc';
import myFunction from './myFunction.js';
import { calculateMonthlyPayment,getTermOptions } from 'c/calculateUtils';
export default class MyComponent extends LightningElement {
    principal ='';
    rate='';
    years='';
    val='';
    handleChange(event){
        if(event.target.label == 'Years'){
            this.years = event.target.value;
        }
        else if(event.target.label == 'Rate'){
            this.rate = event.target.value;
        }
        else if(event.target.label == 'Principal'){
            this.principal = event.target.value;
        }
    }

    valDefault = getTermOptions();
    myFunction(){
        this.val = calculateMonthlyPayment(this.principal,this.rate,this.years);
    }
}