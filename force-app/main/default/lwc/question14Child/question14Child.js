import { LightningElement ,api} from 'lwc';

export default class Question14Child extends LightningElement {
    @api age;

    get eligible(){
        return this.age >= 18 ? true : false;
    }

}