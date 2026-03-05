import {api} from 'lwc';
import LightningModal from 'lightning/modal';
export default class Question8Notification extends LightningModal {
    @api totalBillAmount;
    @api totalBillAmountWithGST;
}