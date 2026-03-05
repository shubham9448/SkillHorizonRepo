import { LightningElement,wire } from 'lwc';
import getRecords from '@salesforce/apex/returnRecords.getRecords';
export default class Question9 extends LightningElement {
    isAccTrue;
    isContactTrue;
    isLeadTrue;
    isOppTrue;
    record;
    error;
    selectedObject = '';
    isObjectSelected = false;

    objectOptions = [
        { label: 'Account', value: 'Account' },
        { label: 'Contact', value: 'Contact' },
        { label: 'Lead', value: 'Lead' },
        { label: 'Opportunity', value: 'Opportunity' }
    ];

    /*handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        switch (this.selectedObject) {
            case 'Account':
                window.location.href = 'https://orgfarm-9e92df8f3c-dev-ed.develop.lightning.force.com/lightning/o/Account/new?count=3&nooverride=1&useRecordTypeCheck=1&navigationLocation=LIST_VIEW&uid=177227102801064156&backgroundContext=%2Flightning%2Fo%2FAccount%2Flist%3FfilterName%3D__Recent';
                break;

            case 'Contact':
                window.location.href = 'https://orgfarm-9e92df8f3c-dev-ed.develop.lightning.force.com/lightning/o/Contact/new?count=1&nooverride=1&useRecordTypeCheck=1&navigationLocation=LIST_VIEW&uid=177227135071921528&backgroundContext=%2Flightning%2Fo%2FContact%2Flist%3FfilterName%3D__Recent';
                break;
            case 'Lead':
                window.location.href = 'https://orgfarm-9e92df8f3c-dev-ed.develop.lightning.force.com/lightning/o/Lead/new?count=4&nooverride=1&useRecordTypeCheck=1&navigationLocation=LIST_VIEW&uid=177227149728645349&backgroundContext=%2Flightning%2Fo%2FLead%2Flist';
                break;
            case 'Opportunity':
                window.location.href = 'https://orgfarm-9e92df8f3c-dev-ed.develop.lightning.force.com/lightning/o/Opportunity/new?count=3&nooverride=1&useRecordTypeCheck=1&navigationLocation=LIST_VIEW&uid=177227142672529626&backgroundContext=%2Flightning%2Fo%2FOpportunity%2Flist';
                break;
            default:
                break;
        }

    }*/

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
    }

    get hasRecords() {
    return this.record && this.record.length > 0;
    }

    @wire(getRecords, { ObjectName: '$selectedObject' })
    wiredRecord({ error, data }) {
        if (data) {
            this.record = data.length ? data : null;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = null;
        }
    }

    get Columns() {
        if (this.selectedObject === 'Account') {
            return [
                { label: 'Name', fieldName: 'Name' },
                { label: 'Industry', fieldName: 'Industry' },
                { label: 'Phone', fieldName: 'Phone' }
            ];
        } else if (this.selectedObject === 'Contact') {
            return [
                { label: 'First Name', fieldName: 'FirstName' },
                { label: 'Last Name', fieldName: 'LastName' },
                { label: 'Email', fieldName: 'Email' }
            ];
        } else if (this.selectedObject === 'Lead') {
            return [
                { label: 'First Name', fieldName: 'FirstName' },
                { label: 'Last Name', fieldName: 'LastName' },
                { label: 'Company', fieldName: 'Company' }
            ];
        } else if (this.selectedObject === 'Opportunity') {
            return [
                { label: 'Name', fieldName: 'Name' },
                { label: 'Stage', fieldName: 'StageName' },
                { label: 'Amount', fieldName: 'Amount' }
            ];
        }
        return [];
    }
}