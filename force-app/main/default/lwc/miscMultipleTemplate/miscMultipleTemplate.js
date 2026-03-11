import { LightningElement } from 'lwc';
import templateOne from './templateOne.html';
import templateTwo from './templateTwo.html';
export default class MiscMultipleTemplate extends LightningElement {
    flag  = true;
    render(){
        return this.flag ? templateOne : templateTwo;
    }
    switchTemplate(){
        this.flag = !this.flag;
    }
}