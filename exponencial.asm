section .data           ; N�o ser� utilizada nenhuma constante nesta rotina

section .bss            ; N�o ser� reservada nenhuma posi��o de memoria p/ vetor nesta rotina

section .text           ; Ser�o com o c�digo fonte da rotina

   global exponencial   ; labels que ser�o vistos por outros arquivos 

; A rotina funciona da seguinte forma:
; S�o recebidos 2 valores do programa C: um valor para a base que ser� armazenado em
; ebx e outro para o valor do expoente, armazenado no registrador ecx. 
; A execu��o come�a com  a inicializa��o dos valores, gravando o valor da base
; em eax. Ap�s esta fase, no loop representado pela label "calculo", o valor da base
; � multiplicado com o valor em eax, e o valor do expoente (ecx), � subtra�do de 01.
; Se o valor de ecx n�o for igual � um, o fluxo ser� desviado para o label "calculo".
; Ap�s o valor de ecx ter chegado � 01, o fluxo de execu��o � desviado para o label "final", 
; onde s�o realizados os procedimentos para o t�rmino da rotina e retorno para o programa 
; que a chamou.  

; in�cio da rotina
exponencial:        
   
    push ebp        	; procedimento padr�o para salvar o contexto
    mov ebp, esp        ; procedimento padr�o para salvar o contexto
   
    push ebx         	; carregando os registradores que ser�o usados (x)
    push ecx         	; carregando os registradores que ser�o usados (y)
    
    mov ebx, [ebp+8]    ; alocando mem�ria para os registradores (x) - base
    mov ecx, [ebp+12]   ; alocando mem�ria para os registradores (y) - expoente

    mov eax, ebx        ; dando o valor de ebx (x) para eax (inicializando)
      
calculo:        

    imul eax, ebx       ; multiplicando ebx (x) com o valor de eax
    sub ecx, 1        	; subtraindo 1 do expoente
    cmp ecx, 1        	; verificando se o expoente chegou ao valor 1
    jne calculo        	; se o expoente n�o for 1 ir para a label 'calculo'
      
final:            
    
    pop ecx        	; restaurando os valores riginais dos registradores
    pop ebx            	; restaurando os valores riginais dos registradores
    
    pop ebp          	; desempilha o antigo ebp, para restaurar o contexto
    ret           	; sai da fun��o (valor de retorno fica em eax)