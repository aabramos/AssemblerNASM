;Se��o com dados est�ticos
section .data
            ;N�o ser� usado nenhum dado est�tico nessa rotina.

;Se��o com dados din�micos.
section .bss
            ;N�o ser� usado nenhum dado din�mico nessa rotina.


;Se��o com o c�digo fonte da rotina
section .text

global bissexto   

;A rotina funciona da seguinte forma:
;Por um par�metro inteiro recebido de um programa em C, a rotina ;vefirica se esse par�metro, � um ano bissexto. Na rotina ;"calculo" o registrador eax recebe o valor do registrador ebx ;que no caso tem o par�metro ano. O registrador edx, que conter� ;o resto da divis�o � inicializado como 0 para n�o ficar ;guardado algum tipo de lixo de mem�ria, o registrador ecx ;recebe o valor 4, no caso o registrador ecx nessa rotina ser� ;usado como o divisor do par�metro ano. Ap�s feita a divis�o ;entre eax e ecx, � comparado o resto com 0, caso seja igual o ;fluxo � desviado para a rotina 'provbissexto", caso contr�rio o ;fluxo � desviado para rotina "nbissexto". Na rotina ;"provbissexto" o par�metro ano, � � novamente passado pro ;registrador eax, o resto edx � zerado, e o divisor ecx recebe ;um novo valor: 100. Caso o resto seja diferente de zero o fluxo ;� alterado para a rotina "nbissexto", caso contr�rio, o ;registrador recebe uma �ltima vez o par�metro ano, o resto � ;zerado e o divisor ecx recebe agora 400. Comparando o resto ;dessa divis�o caso for igual a 0, o fluxo � desviado para a ;rotina "ehbissexto", onde o registrador eax recebe o valor 1 ;para retorno, caso seja diferente o fluxo � desviado para a ;rotina "nbissexto", onde o registrador eax recebe 0 para ;retorno ao programa chamador. Ap�s eax receber 0, ou 1 ;dependendo de qual label o fluxo foi desviado, ao final de cada ;label, o fluxo vai para label final, aonde termina os ;procedimentos necess�rios e retornar o valor de eax entre 0 ou ;1 para o programa chamador.          

bissexto:

        push ebp
        mov ebp, esp        ; procedimento padr�o para salvar o contexto

        push ebx            ; registrador no qual vai ser recebido o parametro(ano)

        mov ebx, [ebp+8]    ; Par�metro de entrada
        mov ecx, [ebp+12]   ; Divisor

calculo:
        mov eax, ebx        ; eax recebe parmetro de entrada(ano) para divis�o;
        mov edx, 0          ; inicializa��o do resto como 0
        mov ecx, 4          ; divisor recebe 4  (Primeira regra de ano bissexto, todo ano bissexto � divisivel por 4)
        div ecx             ; divis�o entre parametro e divisor 
        cmp edx, 0          ; comparando resto com 0 
        je provbissexto     ; caso seja igual pula para label que prova se de fato o ano � bissexto
        jne nbissexto       ; caso n�o seja divisivel por 4 o ano n�o � bissexto, pula para a label "nbissexto" ent�o.

provbissexto:

        ; Regras gerais do ano bissexto, o ano bissexto � divisivel por 400, mais n�o � divisivel por 100 ;

        mov eax, ebx        ; eax recebe novamente o par�metro de entrada(ano)
        mov edx, 0          ; resto zerado.
        mov ecx, 100        ; divisor agora recebe o valor 100
        div ecx             ; divis�o entre par�metro e divisor
        cmp edx, 0          ; compara resto com 0
        jne nbissexto       ; caso for diferente pula para a label "nbissexto"
        
        mov eax, ebx        ; eax recebe a �ltima vez o par�metro de entrada (ano)
        mov edx, 0          ; o resto novamente recebe 0
        mov ecx, 400        ; agora o divisor recebe 400
        div ecx             ; divide o par�metro pelo divisor
        cmp edx, 0          ; compara resto com 0
        je ehbissexto       ; se for igual o ano � bissexto, pula para a  label ehbissexto
        jne nbissexto       ; caso contr�rio, pula para a label nbissexto

ehbissexto:                 ; label de confima��o de ano bissexto
        mov eax, 1          ; eax recebe parAmetro de saida 1
        jmp final           ; pula para o final da fun��o, label "final"
  
nbissexto:                  ; label de nega��o de ano bissexto
        mov eax, 0          ; eax recebe par�metro de saida da rotina
        jmp final           ; pula para o final da fun��o, label "final"

final:                      ; label de final de rotina
        
        pop ebx             ; pop ao contrario dos pushs para restaurar o antigos valores dos registradores

        pop ebp             ; restaura o antigo ebp para restaurar o contexto
        ret                 ; retorno a main em C