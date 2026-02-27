import { LightningElement } from 'lwc';

export default class Question6 extends LightningElement {
    number1;
    number2;
    result = 0;
    handleNumber1Change(event) {
        this.number1 = parseFloat(event.target.value) || 0;
    }
    handleNumber2Change(event) {
        this.number2 = parseFloat(event.target.value) || 0;
    }

    handleClick(event) {
        this.operation = event.target.label;
        if(this.operation === 'Addition'){
            this.result = this.number1 + this.number2;
        }else if(this.operation === 'Subtraction'){
            this.result = this.number1 - this.number2;
        }else if(this.operation === 'Multiplication'){
            this.result = this.number1 * this.number2;
        }else if(this.operation === 'Division'){
            let divisionResult = this.number1 / this.number2;
            this.result = this.number2 !== 0 ? divisionResult.toFixed(2) : 0; 
        }
    }
}