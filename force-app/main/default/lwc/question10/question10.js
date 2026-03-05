import { LightningElement } from 'lwc';

export default class Question10 extends LightningElement {
    isChecked = false;
    handleCheckboxChange(event) {
        this.isChecked = event.target.checked;
    }
}