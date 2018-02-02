
section .data           	
					; N�o ser� utilizada nenhuma constante nesta rotina
section .bss            	
    
    tamanho resd 1     		; reservando uma posi��o de mem�ria de 4 bytes para armazenar o tamanho do vetor

section .text           	

    global maior      		; labels que ser�o vistos por outros arquivos    

; A rotina funciona da seguinte forma:
; S�o recebidos 2 valores do programa C: um ponteiro para o vetor que ser� armazenado em
; ebx e o tamanho do vetor, armazenado na posi��o de mem�ria de label "tamanho". 
; O registrador ecx � utilizado como �ndice para acesso ao vetor. A execu��o come�a com 
; a inicializa��o dos valores, gravando a primeira posi��o do vetor em eax. Ap�s esta 
; fase, no loop representado pelos labels "verificar" e "contagem" o vetor � percorrido 
; de uma em uma posi��o, e o valor desta posi��o � comparado com o valor atual em eax. 
; Se o valor do vetor for maior, esse valor � gravado em eax. Se for menor ou igual,
; o vetor ser� incrementado em 01 e o fluxo ser� desviado para o label "verificar".
; Ap�s o t�rmino do vetor, o fluxo de execu��o � desviado para o label "final", 
; onde s�o realizados os procedimentos para o t�rmino da rotina e retorno para o programa 
; que a chamou.

; in�cio da rotina
maior:		
	
    push ebp			; procedimento padr�o para salvar o contexto
    mov ebp, esp        	; procedimento padr�o para salvar o contexto
    
    push ebx 			; carregando os registradores que ser�o usados (x)
    push ecx 			; carregando os registradores que ser�o usados (y)
     
    mov ebx, [ebp+8]    	; par�metro: vetor
    mov ecx, [ebp+12]   	; par�metro: tamanho

    mov [tamanho], ecx		; guardando o par�metro tamanho na posi��o de mem�ria reservada para ele
    mov ecx, 0 			; inicializando �ndice do vetor com zero
    mov eax, [ebx+ecx*4]	; guarda o valor buscado com o vetor[ecx]. O valor de ecx � multiplicado por 4 pois cada posi��o do vetor possui 4 bytes (vetor de inteiros).

   
verificar:

    cmp [ebx+ecx*4], eax	; compara vetor[ecx] com o valor em eax. 
    jg gravar			; se for maior, desvia para o label "gravar"

contagem: 

    inc ecx				; incremento de ecx em 1
    cmp ecx, [tamanho]		; compara ecx com o tamanho do vetor
    je final			; se forem iguais, desvia para o label "final" para terminar a rotina
    jmp verificar			; se forem diferentes, desvia para o label "verificar", de forma a continuar o loop
	
gravar:				

    mov eax, [ebx+ecx*4]	; grava o maior valor encontrado no vetor[ecx] em eax
    jmp contagem			; desvio para o label "contagem", de forma a continuar o loop
       
final:				
     
    pop ecx				; restaurando os valores originais dos registradores
    pop ebx    			; restaurando os valores originais dos registradores
     
    pop ebp  			 
    ret				; sai da fun��o (valor de retorno fica em eax)
