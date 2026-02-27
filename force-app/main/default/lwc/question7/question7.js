import { LightningElement } from 'lwc';
import Question7Notification from 'c/question7Notification';
export default class Question7 extends LightningElement {
    num1;
    num2;
    num3;
    totalMarks;
    percentage;
    division;

    handleSubjectOneChange(event){
        this.num1 = event.target.value;
    }
    handleSubjectTwoChange(event){
        this.num2 = event.target.value;
    }
    handleSubjectThreeChange(event){
        this.num3 = event.target.value;
    }

    /*get sum() {
        return (parseInt(this.num1,10)||0)
            + (parseInt(this.num2,10)||0)
            + (parseInt(this.num3,10)||0);
    }*/

    calculateTotal(){
        this.totalMarks = parseInt(this.num1) + parseInt(this.num2) + parseInt(this.num3);
    }
    async calculatePercentageAndDivision(){
        this.percentage = ((parseInt(this.num1) + parseInt(this.num2) + parseInt(this.num3))/300)*100;
        if(this.percentage >= 60){
            this.division = 'First Division';
        } else if(this.percentage >= 50){
            this.division = 'Second Division';
        } else if(this.percentage >= 40){
            this.division = 'Third Division';
        } else {
            this.division = 'Fail';
        }

        await Question7Notification.open({
        size: 'small',
        percentage: this.percentage.toFixed(2),
        division: this.division
    });
    }
}