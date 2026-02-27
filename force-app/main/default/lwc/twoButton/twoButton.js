import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class TwoButton extends NavigationMixin(LightningElement) {
    handleClickPos(){
        console.log('Position');
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes:{
                name: 'PositionCreation__c'
            }
        })
    }

    handleClickCan(){
        console.log('Candidate');
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes:{
                name: 'candidateCreation__c'
            }
        })
    }
}