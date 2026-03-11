import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import NEW_CHANNEL from '@salesforce/messageChannel/NewNewLMS__c';

export default class MainTogglePage extends LightningElement {
    flag = true;

    @wire(MessageContext)
    messageContext;

    subscription = null;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                NEW_CHANNEL,
                (message) => {
                    this.flag = message.flag;
                }
            );
        }
    }
}
