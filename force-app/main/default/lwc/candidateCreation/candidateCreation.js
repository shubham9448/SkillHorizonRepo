import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
export default class CandidateCreation extends LightningElement {
    handleSucess(event){
        const recordId = event.detail.Id;
        console.log('New Candidate Record ID: ',recordId);
        this[NavigationMixin.Navigate]({
            type:'standard__webPage',
            attributes:{
                recordId: event.detail.Id,
                actionName: 'view'
            }
        })
    }
}