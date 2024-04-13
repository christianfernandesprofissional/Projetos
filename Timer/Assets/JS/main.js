function relogio (){

    function criaHoraDosSegundos (segundos) {
        const data = new Date(segundos*1000);
        return data.toLocaleTimeString('pt-BR', {
            hour12: false,
            timeZone: 'GMT'
        });
    }
    
    const relogio = document.querySelector('.relogio');
    let segundos = 0;
    let timer;

    function iniciaRelogio(){
         timer = setInterval(function(){
            segundos++;
            relogio.innerHTML = criaHoraDosSegundos(segundos);
        },1000)
    }
    
    document.addEventListener('click', function(e){
        const el = e.target;
    
        if(el.classList.contains('zerar')){
            relogio.classList.remove('pausado');
        clearInterval(timer);
        segundos = 0;
        relogio.innerHTML = '00:00:00';
        }
    
        if (el.classList.contains('pausar')){
            relogio.classList.add('pausado');
            clearInterval(timer);
        }
    
        if (el.classList.contains('iniciar')){
            relogio.classList.remove('pausado');
            clearInterval(timer);
            iniciaRelogio();
        }
    })

} 

relogio();