;Seção com dados estáticos
section .data
            ;Não será usado nenhum dado estático nessa rotina.

;Seção com dados dinâmicos.
section .bss
            ;Não será usado nenhum dado dinâmico nessa rotina.


;Seção com o código fonte da rotina
section .text

global triangulo

;A rotina funciona da seguinte forma:Baseado no teorema de Pitágoras, (soma dos quadrados dos 
;catetos é igual a soma do quadrado da hipotenusa para um triângulo retângulo), recebemos pela main em C, 3 parâmetros 
;inteiros sendo um deles a hipotenusa e os outros dois os catetos de um suposto triângulo retângulo. O registrador ecx 
;recebe a hipotenusa e os registradores ebx e edx recebem os catetos.Na label "checktriangulo" é cauculado os quadrados da 
;hipotenusa e dos dois catetos, é calculado tambem a soma desses quadrados dos catetos e por fim é comparado essa soma dos 
;quadrados dos catetos com a soma do quadrado da hipotenusa. Caso seja igual pula para a label "ehtriangulo" e caso contrário pula para 
;label ntriangulo. Na label "ehtriangulo", o registrador eax recebe 1 e pula para a label "final" confirmando que o 
;triângulo especificado é retângulo e na label "ntriangulo", o registrador eax recebe 0, confirmando que o triângulo 
;especificado não é retângulo. Na label "final", são realizados os procedimentos para o dinal da rotina e é feito o retorno 
;para o programa que chamou a função. 

triangulo:
    push ebp
    mov ebp, esp            ; Procedimento padrão para salvar o contexto

    push ecx
    push ebx
    push edx                ; Salvando os registradores que serão utilizados nessa rotina.


    mov ecx, [ebp+8]        ; parâmetro: Hipotenusa
    mov ebx, [ebp+12]       ; parâmetro: Cateto
    mov edx, [ebp+16]       ; parâmetro: Cateto
    mov eax, [ebp+20]       ; parâmetro que ira receber se é ou nao é triangulo retangulo

checktriangulo:             ; Label da função que calcula e verifica se é triangulo retangulo

    imul edx, edx  ; calcula o quadrado de um cateto
    imul ebx, ebx  ; calcula o quadrado de um cateto
    imul ecx, ecx  ; calcula o quadrado da hipotenusa

    add ebx, edx   ; soma dos quadrados dos catetos

    cmp ecx, ebx   ; verificando se a soma dos quadrados
                   ; dos catetos é igual ao quadrado da hipotenusa.

     jne  nretangulo    ; Pula para a Label "nretangulo" se a compaarção nao for igual
     jmp  retangulo     ; pula para a Label "retangulo" se a comparação for igual

retangulo:                

    mov eax, 1             ; eax recebe 1 para indicar que o triangulo é retangulo
    jmp final              ; desvio para o label "final" para terminar a rotina

nretangulo:                ; label que diz que não é triângulo retangulo

    mov eax, 0             ; eax recebe 0 para indicar que o triângulo não é retângulo
    jmp final              ; desvio para o label "final" para terminar a rotina

final:
    pop ecx
    pop ebx
    pop edx               ; Desempilha os registradores em ordem inversa de empilhamento, restaurando o antigo contexto dos registradores.
    pop ebp               ; Desempilha o ebp para restaurar o contexto
    ret                   ; sai da função (valor de retorno fica em eax) 