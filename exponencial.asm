section .data           ; Não será utilizada nenhuma constante nesta rotina

section .bss            ; Não será reservada nenhuma posição de memoria p/ vetor nesta rotina

section .text           ; Serão com o código fonte da rotina

   global exponencial   ; labels que serão vistos por outros arquivos 

; A rotina funciona da seguinte forma:
; São recebidos 2 valores do programa C: um valor para a base que será armazenado em
; ebx e outro para o valor do expoente, armazenado no registrador ecx. 
; A execução começa com  a inicialização dos valores, gravando o valor da base
; em eax. Após esta fase, no loop representado pela label "calculo", o valor da base
; é multiplicado com o valor em eax, e o valor do expoente (ecx), é subtraído de 01.
; Se o valor de ecx não for igual à um, o fluxo será desviado para o label "calculo".
; Após o valor de ecx ter chegado à 01, o fluxo de execução é desviado para o label "final", 
; onde são realizados os procedimentos para o término da rotina e retorno para o programa 
; que a chamou.  

; início da rotina
exponencial:        
   
    push ebp        	; procedimento padrão para salvar o contexto
    mov ebp, esp        ; procedimento padrão para salvar o contexto
   
    push ebx         	; carregando os registradores que serão usados (x)
    push ecx         	; carregando os registradores que serão usados (y)
    
    mov ebx, [ebp+8]    ; alocando memória para os registradores (x) - base
    mov ecx, [ebp+12]   ; alocando memória para os registradores (y) - expoente

    mov eax, ebx        ; dando o valor de ebx (x) para eax (inicializando)
      
calculo:        

    imul eax, ebx       ; multiplicando ebx (x) com o valor de eax
    sub ecx, 1        	; subtraindo 1 do expoente
    cmp ecx, 1        	; verificando se o expoente chegou ao valor 1
    jne calculo        	; se o expoente não for 1 ir para a label 'calculo'
      
final:            
    
    pop ecx        	; restaurando os valores riginais dos registradores
    pop ebx            	; restaurando os valores riginais dos registradores
    
    pop ebp          	; desempilha o antigo ebp, para restaurar o contexto
    ret           	; sai da função (valor de retorno fica em eax)