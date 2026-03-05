import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class TwoButton extends NavigationMixin(LightningElement) {
    handleClickPos(){
        console.log('Position');
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes:{
                name: 'PositionCreate__c'
            }
        })
    }

    handleClickCan(){
        console.log('Candidate');
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes:{
                name: 'CandidateCreate__c'
            }
        })
    }
}