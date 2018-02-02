;Seção com dados estáticos
section .data
            ;Não será usado nenhum dado estático nessa rotina.

;Seção com dados dinâmicos.
section .bss
            ;Não será usado nenhum dado dinâmico nessa rotina.


;Seção com o código fonte da rotina
section .text

global bissexto   

;A rotina funciona da seguinte forma:
;Por um parâmetro inteiro recebido de um programa em C, a rotina ;vefirica se esse parâmetro, é um ano bissexto. Na rotina ;"calculo" o registrador eax recebe o valor do registrador ebx ;que no caso tem o parâmetro ano. O registrador edx, que conterá ;o resto da divisão é inicializado como 0 para não ficar ;guardado algum tipo de lixo de memória, o registrador ecx ;recebe o valor 4, no caso o registrador ecx nessa rotina será ;usado como o divisor do parâmetro ano. Após feita a divisão ;entre eax e ecx, é comparado o resto com 0, caso seja igual o ;fluxo é desviado para a rotina 'provbissexto", caso contrário o ;fluxo é desviado para rotina "nbissexto". Na rotina ;"provbissexto" o parâmetro ano, é é novamente passado pro ;registrador eax, o resto edx é zerado, e o divisor ecx recebe ;um novo valor: 100. Caso o resto seja diferente de zero o fluxo ;é alterado para a rotina "nbissexto", caso contrário, o ;registrador recebe uma última vez o parâmetro ano, o resto é ;zerado e o divisor ecx recebe agora 400. Comparando o resto ;dessa divisão caso for igual a 0, o fluxo é desviado para a ;rotina "ehbissexto", onde o registrador eax recebe o valor 1 ;para retorno, caso seja diferente o fluxo é desviado para a ;rotina "nbissexto", onde o registrador eax recebe 0 para ;retorno ao programa chamador. Após eax receber 0, ou 1 ;dependendo de qual label o fluxo foi desviado, ao final de cada ;label, o fluxo vai para label final, aonde termina os ;procedimentos necessários e retornar o valor de eax entre 0 ou ;1 para o programa chamador.          

bissexto:

        push ebp
        mov ebp, esp        ; procedimento padrão para salvar o contexto

        push ebx            ; registrador no qual vai ser recebido o parametro(ano)

        mov ebx, [ebp+8]    ; Parâmetro de entrada
        mov ecx, [ebp+12]   ; Divisor

calculo:
        mov eax, ebx        ; eax recebe parmetro de entrada(ano) para divisão;
        mov edx, 0          ; inicialização do resto como 0
        mov ecx, 4          ; divisor recebe 4  (Primeira regra de ano bissexto, todo ano bissexto é divisivel por 4)
        div ecx             ; divisão entre parametro e divisor 
        cmp edx, 0          ; comparando resto com 0 
        je provbissexto     ; caso seja igual pula para label que prova se de fato o ano é bissexto
        jne nbissexto       ; caso não seja divisivel por 4 o ano não é bissexto, pula para a label "nbissexto" então.

provbissexto:

        ; Regras gerais do ano bissexto, o ano bissexto é divisivel por 400, mais não é divisivel por 100 ;

        mov eax, ebx        ; eax recebe novamente o parâmetro de entrada(ano)
        mov edx, 0          ; resto zerado.
        mov ecx, 100        ; divisor agora recebe o valor 100
        div ecx             ; divisão entre parâmetro e divisor
        cmp edx, 0          ; compara resto com 0
        jne nbissexto       ; caso for diferente pula para a label "nbissexto"
        
        mov eax, ebx        ; eax recebe a última vez o parâmetro de entrada (ano)
        mov edx, 0          ; o resto novamente recebe 0
        mov ecx, 400        ; agora o divisor recebe 400
        div ecx             ; divide o parâmetro pelo divisor
        cmp edx, 0          ; compara resto com 0
        je ehbissexto       ; se for igual o ano é bissexto, pula para a  label ehbissexto
        jne nbissexto       ; caso contrário, pula para a label nbissexto

ehbissexto:                 ; label de confimação de ano bissexto
        mov eax, 1          ; eax recebe parAmetro de saida 1
        jmp final           ; pula para o final da função, label "final"
  
nbissexto:                  ; label de negação de ano bissexto
        mov eax, 0          ; eax recebe parâmetro de saida da rotina
        jmp final           ; pula para o final da função, label "final"

final:                      ; label de final de rotina
        
        pop ebx             ; pop ao contrario dos pushs para restaurar o antigos valores dos registradores

        pop ebp             ; restaura o antigo ebp para restaurar o contexto
        ret                 ; retorno a main em C