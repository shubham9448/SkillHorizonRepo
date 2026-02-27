import { LightningElement } from 'lwc';

export default class Question5 extends LightningElement {
    selectedInputCurrency;
    selectedOutputCurrency;
    exchangeRate;
    amount;
    convertedAmount;

    options = [
        { label: 'EUR', value: 'EUR' },
        { label: 'USD', value: 'USD' },
    ];

    handleChange(event) {
        if(event.target.name === 'input') {
        this.selectedInputCurrency = event.detail.value;
        } else if(event.target.name === 'output') {
        this.selectedOutputCurrency = event.detail.value;
        }
    }

    handleChangeAmount(event) {
        this.amount = event.target.value;
    }

    handleConvert(){
        if(this.selectedInputCurrency == 'EUR' && this.selectedOutputCurrency == 'USD'){
            this.exchangeRate= 1.18;
        }else if(this.selectedInputCurrency == 'USD' && this.selectedOutputCurrency == 'EUR'){
            this.exchangeRate= 0.85;
        }else{
            this.exchangeRate= 1;
        }

        this.convertedAmount = this.amount * this.exchangeRate; 
        console.log('Converted Amount: ' + this.convertedAmount);
    }
}