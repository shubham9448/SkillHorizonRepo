import { LightningElement } from 'lwc';

export default class Question14Parent extends LightningElement {
    age;
    show= false;
    handleAgeChange(event) {
        this.age = Number(event.target.value);
    }

    handleClick(){
        this.show = true;
    }

}