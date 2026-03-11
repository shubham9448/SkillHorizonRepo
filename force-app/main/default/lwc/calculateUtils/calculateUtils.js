const getTermOptions = () =>{
    return [
        {label: '20 years',value:'20'},
        {label: '30 years',value:'30'}
    ];
}
const calculateMonthlyPayment = ( principal,years,rate) => {
    return (principal * years * rate )/ 100 ;
}

export  {getTermOptions,calculateMonthlyPayment }