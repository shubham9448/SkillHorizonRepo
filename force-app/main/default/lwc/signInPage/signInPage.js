import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import NEW_CHANNEL from '@salesforce/messageChannel/NewNewLMS__c';

export default class SignInPage extends LightningElement {
    userName = '';
    password = '';
    flag = false; // when publishing from Sign In, false => show Sign Up

    @wire(MessageContext)
    messageContext;

    handleChange(event) {
        const { name, value } = event.target;
        if (name === 'userName') {
            this.userName = value;
        } else if (name === 'password') {
            this.password = value;
        }
    }

    handleSignIn() {
        // TODO: implement real auth; placeholder to avoid undefined handler
        // You can add validation and toast here if needed.
    }

    handleSignUp() {
        const message = { flag: this.flag };
        publish(this.messageContext, NEW_CHANNEL, message);
    }
}
