import { LightningElement } from 'lwc';

export default class HelloBinding extends LightningElement {
    firstName = 'Shubham';
    lastName = 'Naik';
    handleChange(event){
        const field = event.target.name;
        if(field === 'firstName'){
            this.firstName = event.target.value;
        } else if(field === 'lastName'){
            this.lastName = event.target.value;
        }
    }
    get uppercaseFullName(){
        return `${this.firstName.toUpperCase()} ${this.lastName.toUpperCase()}`;
    }
}