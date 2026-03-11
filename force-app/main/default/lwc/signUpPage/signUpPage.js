import { LightningElement,wire } from 'lwc';
import { publish, MessageContext } from "lightning/messageService";
import NEW_CHANNEL from "@salesforce/messageChannel/NewNewLMS__c";
export default class SignUpPage extends LightningElement {
    userName='';
    firstName = '';
    lastName = '';
    email = '';
    password = '';
    handleChange(event){
        if(event.target.name === 'firstName'){
            this.firstName = event.target.value;
        }else if(event.target.name === 'lastName'){
            this.lastName = event.target.value;
        }else if(event.target.name === 'email'){
            this.email = event.target.value;
        }else if(event.target.name === 'password'){
            this.password = event.target.value;
        }else{
            this.userName = event.target.value;
        }
    }
    @wire(MessageContext)
    messageContext;

    handleBack(){
        const message = { flag: true };
        publish(this.messageContext, NEW_CHANNEL, message);
    }
}