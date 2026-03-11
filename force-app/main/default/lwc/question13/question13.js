import { LightningElement,wire } from 'lwc';
import getAccount from '@salesforce/apex/returnRecords.getRecords';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNT_INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
export default class Question13 extends LightningElement {
    accounts;
    @wire(getAccount,{ObjectName:'Account'})
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }

    get columns() {
        return [
            { label: 'Name', fieldName: ACCOUNT_NAME_FIELD.fieldApiName, type: 'text' },
            { label: 'Phone', fieldName: ACCOUNT_PHONE_FIELD.fieldApiName, type: 'phone' },
            { label: 'Indu  stry', fieldName: ACCOUNT_INDUSTRY_FIELD.fieldApiName, type: 'picklist' }
        ];
    }
}