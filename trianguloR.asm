;Se��o com dados est�ticos
section .data
            ;N�o ser� usado nenhum dado est�tico nessa rotina.

;Se��o com dados din�micos.
section .bss
            ;N�o ser� usado nenhum dado din�mico nessa rotina.


;Se��o com o c�digo fonte da rotina
section .text

global triangulo

;A rotina funciona da seguinte forma:Baseado no teorema de Pit�goras, (soma dos quadrados dos 
;catetos � igual a soma do quadrado da hipotenusa para um tri�ngulo ret�ngulo), recebemos pela main em C, 3 par�metros 
;inteiros sendo um deles a hipotenusa e os outros dois os catetos de um suposto tri�ngulo ret�ngulo. O registrador ecx 
;recebe a hipotenusa e os registradores ebx e edx recebem os catetos.Na label "checktriangulo" � cauculado os quadrados da 
;hipotenusa e dos dois catetos, � calculado tambem a soma desses quadrados dos catetos e por fim � comparado essa soma dos 
;quadrados dos catetos com a soma do quadrado da hipotenusa. Caso seja igual pula para a label "ehtriangulo" e caso contr�rio pula para 
;label ntriangulo. Na label "ehtriangulo", o registrador eax recebe 1 e pula para a label "final" confirmando que o 
;tri�ngulo especificado � ret�ngulo e na label "ntriangulo", o registrador eax recebe 0, confirmando que o tri�ngulo 
;especificado n�o � ret�ngulo. Na label "final", s�o realizados os procedimentos para o dinal da rotina e � feito o retorno 
;para o programa que chamou a fun��o. 

triangulo:
    push ebp
    mov ebp, esp            ; Procedimento padr�o para salvar o contexto

    push ecx
    push ebx
    push edx                ; Salvando os registradores que ser�o utilizados nessa rotina.


    mov ecx, [ebp+8]        ; par�metro: Hipotenusa
    mov ebx, [ebp+12]       ; par�metro: Cateto
    mov edx, [ebp+16]       ; par�metro: Cateto
    mov eax, [ebp+20]       ; par�metro que ira receber se � ou nao � triangulo retangulo

checktriangulo:             ; Label da fun��o que calcula e verifica se � triangulo retangulo

    imul edx, edx  ; calcula o quadrado de um cateto
    imul ebx, ebx  ; calcula o quadrado de um cateto
    imul ecx, ecx  ; calcula o quadrado da hipotenusa

    add ebx, edx   ; soma dos quadrados dos catetos

    cmp ecx, ebx   ; verificando se a soma dos quadrados
                   ; dos catetos � igual ao quadrado da hipotenusa.

     jne  nretangulo    ; Pula para a Label "nretangulo" se a compaar��o nao for igual
     jmp  retangulo     ; pula para a Label "retangulo" se a compara��o for igual

retangulo:                

    mov eax, 1             ; eax recebe 1 para indicar que o triangulo � retangulo
    jmp final              ; desvio para o label "final" para terminar a rotina

nretangulo:                ; label que diz que n�o � tri�ngulo retangulo

    mov eax, 0             ; eax recebe 0 para indicar que o tri�ngulo n�o � ret�ngulo
    jmp final              ; desvio para o label "final" para terminar a rotina

final:
    pop ecx
    pop ebx
    pop edx               ; Desempilha os registradores em ordem inversa de empilhamento, restaurando o antigo contexto dos registradores.
    pop ebp               ; Desempilha o ebp para restaurar o contexto
    ret                   ; sai da fun��o (valor de retorno fica em eax) 