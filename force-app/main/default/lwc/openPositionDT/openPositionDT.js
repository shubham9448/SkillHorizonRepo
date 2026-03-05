import { LightningElement,api,wire } from 'lwc';
import getPosition from '@salesforce/apex/HandlerLWC.featchPosition';
export default class OpenPositionDT extends LightningElement {
    @api recordId;
    PositionList;
    @wire(getPosition) 
    position({data,error}){
        if(data){
            this.PositionList=data;
        }
        if(error){
            console.log(error);
        }
    }

    columns=[
        {label:'Name',fieldName:'Name',type:'text'},
        {label:'Status',fieldName:'Status__c',type:'picklist'},
        {label:'Max Pay',fieldName:'Max_pay__c',type:'currency'},
        {label:'Min Pay',fieldName:'Min_pay__c',type:'currency'},
        {label:'Location',fieldName:'Location__c',type:'picklist'},
    ]
}