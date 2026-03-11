import { LightningElement} from 'lwc';

export default class Parent extends LightningElement {
    fullName='Shubham Naik'; 
    handleChange(event) {
        this.fullName = event.target.value;
    }   
}