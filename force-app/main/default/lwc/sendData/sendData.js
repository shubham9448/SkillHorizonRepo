import { LightningElement,api,wire } from 'lwc';
import { publish, MessageContext } from "lightning/messageService";
import NEW_CHANNEL from "@salesforce/messageChannel/NewLMS__c";
export default class SendData extends LightningElement {
    @api firstName;
    @api lastName;
    
    handlefirstName(event) {
        this.firstName = event.target.value;
    }

    handlelastName(event) {
        this.lastName = event.target.value;
    }

    @wire(MessageContext)
    messageContext;
    
    handleClick() {
        const message = { firstName: this.firstName, lastName: this.lastName };
        publish(this.messageContext, NEW_CHANNEL, message);
    }

}