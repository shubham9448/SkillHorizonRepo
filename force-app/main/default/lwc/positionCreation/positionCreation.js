import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
export default class PositionCreation extends NavigationMixin(LightningElement) {
    handleSucess(event){
        const recordId = event.detail.Id;
        console.log('New Position Record ID: ',recordId);
        this[NavigationMixin.Navigate]({
            type:'standard__recordPage',
            attributes:{
                recordId: event.detail.Id,
                actionName: 'view'
            }
        })
    }
}