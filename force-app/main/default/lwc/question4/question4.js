import { LightningElement } from 'lwc';

export default class Question4 extends LightningElement {
    feet;
    inches;
    handleFeetChange(event){
        this.feet = event.target.value;
    }
    convertFeetToInches(){
        this.inches = this.feet*12;
    }
}
