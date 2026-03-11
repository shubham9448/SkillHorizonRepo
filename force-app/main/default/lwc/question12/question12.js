import { LightningElement,wire } from 'lwc';
import getAccount from '@salesforce/apex/returnRecords.getRecords';
export default class Question12 extends LightningElement {
    accounts;
    @wire(getAccount,{ObjectName:'Account'})
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }
}