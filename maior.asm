
section .data           	
					; Não será utilizada nenhuma constante nesta rotina
section .bss            	
    
    tamanho resd 1     		; reservando uma posição de memória de 4 bytes para armazenar o tamanho do vetor

section .text           	

    global maior      		; labels que serão vistos por outros arquivos    

; A rotina funciona da seguinte forma:
; São recebidos 2 valores do programa C: um ponteiro para o vetor que será armazenado em
; ebx e o tamanho do vetor, armazenado na posição de memória de label "tamanho". 
; O registrador ecx é utilizado como índice para acesso ao vetor. A execução começa com 
; a inicialização dos valores, gravando a primeira posição do vetor em eax. Após esta 
; fase, no loop representado pelos labels "verificar" e "contagem" o vetor é percorrido 
; de uma em uma posição, e o valor desta posição é comparado com o valor atual em eax. 
; Se o valor do vetor for maior, esse valor é gravado em eax. Se for menor ou igual,
; o vetor será incrementado em 01 e o fluxo será desviado para o label "verificar".
; Após o término do vetor, o fluxo de execução é desviado para o label "final", 
; onde são realizados os procedimentos para o término da rotina e retorno para o programa 
; que a chamou.

; início da rotina
maior:		
	
    push ebp			; procedimento padrão para salvar o contexto
    mov ebp, esp        	; procedimento padrão para salvar o contexto
    
    push ebx 			; carregando os registradores que serão usados (x)
    push ecx 			; carregando os registradores que serão usados (y)
     
    mov ebx, [ebp+8]    	; parâmetro: vetor
    mov ecx, [ebp+12]   	; parâmetro: tamanho

    mov [tamanho], ecx		; guardando o parâmetro tamanho na posição de memória reservada para ele
    mov ecx, 0 			; inicializando índice do vetor com zero
    mov eax, [ebx+ecx*4]	; guarda o valor buscado com o vetor[ecx]. O valor de ecx é multiplicado por 4 pois cada posição do vetor possui 4 bytes (vetor de inteiros).

   
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
    ret				; sai da função (valor de retorno fica em eax)
