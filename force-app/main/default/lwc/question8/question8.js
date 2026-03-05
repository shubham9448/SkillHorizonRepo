import { LightningElement } from 'lwc';
import Question8Notification from 'c/question8Notification';
export default class Question8 extends LightningElement {
    totalBillAmount;
    totalBillAmountWithGST;
    quantity1="";
    price1="";
    quantity2="";
    price2="";
    quantity3="";
    price3="";
    quantity4="";
    price4="";
    quantity5="";
    price5="";

    handleQuantityChange1(event) {
        this.quantity1 = parseInt(event.target.value) || 0;
    }
    handlePriceChange1(event) {
        this.price1 = parseFloat(event.target.value) || 0;
    }
    handleQuantityChange2(event) {
        this.quantity2 = parseInt(event.target.value) || 0;
    }
    handlePriceChange2(event) {
        this.price2 = parseFloat(event.target.value) || 0;
    }

    handleQuantityChange3(event) {
        this.quantity3 = parseInt(event.target.value) || 0;
    }
    handlePriceChange3(event) {
        this.price3 = parseFloat(event.target.value) || 0;
    }

    handleQuantityChange4(event) {
        this.quantity4 = parseInt(event.target.value) || 0;
    }
    handlePriceChange4(event) {
        this.price4 = parseFloat(event.target.value) || 0;
    }

    handleQuantityChange5(event) {
        this.quantity5 = parseInt(event.target.value) || 0;
    }
    handlePriceChange5(event) {
        this.price5 = parseFloat(event.target.value) || 0;
    }

    async calculateTotalBill(){
        this.totalBillAmount = (this.quantity1 * this.price1) + (this.quantity2 * this.price2) + (this.quantity3 * this.price3) + (this.quantity4 * this.price4) + (this.quantity5 * this.price5);
        this.totalBillAmountWithGST = this.totalBillAmount + (this.totalBillAmount * 0.18);

        await Question8Notification.open({
        size: 'small',
        totalBillAmount: this.totalBillAmount,
        totalBillAmountWithGST: this.totalBillAmountWithGST.toFixed(2)
    });
    }

}