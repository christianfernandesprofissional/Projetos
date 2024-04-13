const data = new Date();
function dayOfWeek () {
    
    let diaDaSemana = data.getDay();
    let diaSemanaTexto;

    switch (diaDaSemana) {
        case 0: 
        diaSemanaTexto = 'Domingo';
        return diaSemanaTexto;
        case 1: 
        diaSemanaTexto = 'Segunda-feira';
        return diaSemanaTexto;
        case 2: 
        diaSemanaTexto = 'Terça-feira';
        return diaSemanaTexto;
        case 3: 
        diaSemanaTexto = 'Quarta-feira';
        return diaSemanaTexto;
        case 4: 
        diaSemanaTexto = 'Quinta-feira';
        return diaSemanaTexto;
        case 5: 
        diaSemanaTexto = 'Sexta-Feira';
        return diaSemanaTexto;
        case 6: 
        diaSemanaTexto = 'Sábado';
        return diaSemanaTexto;
}
};

function monthOfYear () {
    let monthNumber = data.getMonth();
    let monthString;

    switch (monthNumber) {
        case 0:
            monthString = "Janeiro";
            return monthString;
        case 1:
            monthString = "Fevereiro";
            return monthString;
        case 2:
            monthString = "Março";
            return monthString;
        case 3:
            monthString = "Abril";
            return monthString;
        case 4:
            monthString = "Maio";
            return monthString;
        case 5:
            monthString = "Junho";
            return monthString;
        case 6:
            monthString = "Julho";
            return monthString;
        case 7:
            monthString = "Agosto";
            return monthString;
        case 8:
            monthString = "Setembro";
            return monthString;
        case 9:
            monthString = "Outubro";
            return monthString;
        case 10:
            monthString = "Novembro";
            return monthString;
        case 11:
            monthString = "Dezembro";
            return monthString;

    }
};
function putZero (){
    const minuto = data.getMinutes()
    if (minuto >= 0 && minuto <= 9) {
        return "0";
    } else {return ""};
};

const title = document.querySelector('.dataHoje');
const ano = data.getFullYear();
const dia = data.getDate();
const hora = data.getHours();
const minuto = data.getMinutes()

title.innerHTML = `${dayOfWeek()}, ${dia} de ${monthOfYear()} de ${ano}<br>${hora}:${putZero()}${minuto}`; 

console.log(`${dayOfWeek()}, ${dia} de ${monthOfYear()} de ${ano} ${hora}:${putZero()}${minuto}`);