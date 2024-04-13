function criaCalculadora(){
    return {
        display: document.querySelector('.display'),
        btnClear: document.querySelector('.btn-clear'),

        inicia(){
            this.cliqueBotoes();
            this.pressionaEnter();
           },

           pressionaEnter(){
            this.display.addEventListener('keyup', (e) => {
                if(e.keyCode === 13){
                    this.realizaConta();
                }
            })
           },
        
        realizaConta(){
            let conta = this.display.value;

            try {
                conta = eval(conta); // eval pega strings e tenta executar como se fosse um código, isso é perigos, cuidado ao utilizar, pode causar falha de segurança.
                if(!conta){
                    alert('Conta inválida');
                    return;
                }
                this.display.value = String(conta);
            } catch(e){
                alert('Conta inválida');
                return
            }
        },
        
        apagaUm(){
          this.display.value = this.display.value.slice(0, -1);  
        },
        
        clearDisplay(){
            this.display.value = '';
        },
        

        cliqueBotoes() {
            document.addEventListener('click',function(e){
                const el = e.target; // aqui captura o evento de click e mostra onde foi clicado
                
                if(el.classList.contains('btn-num')){
                    this.btnParaDisplay(el.innerText); 
                }

                if(el.classList.contains('btn-clear')){
                    this.clearDisplay();
                }

                if(el.classList.contains('btn-del')){
                    this.apagaUm();
                }

                if(el.classList.contains('btn-eq')){
                    this.realizaConta();
                }
            }.bind(this));/* A principio, após colocarmos o Event listener no document, o this virou o document
            e por isso aconteceu um erro, porque quem está chamando a função do click é o document, para resolver isso
            usamos .bind(this) que é como se eu falasse pra função, olha ao envés do seu this ser o el, use o meu, que 
            no caso é a constante calculadora, é ela quem está chamando. 
            
            Outra forma de resolver esse problema, é utilizar arrow function, porque arrows functions não permitem
            a mudança do this.*/
           
        },

        btnParaDisplay(valor){
            this.display.value += valor;
        },




    };
}

const calculadora = criaCalculadora();
calculadora.inicia();
