import { api } from 'lwc';
import LightningModal from 'lightning/modal';
export default class Question7Notification extends LightningModal {
    @api percentage;
    @api division;
    header= 'Percentage and Division';
}