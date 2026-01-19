Seguem alguns programas simples feitos em x86 Assembly para fins de aprendizado. Foi usado o NASM para a montagem do código e um programa em C para chamar os arquivos .asm listados abaixo.

Para instalar o NASM no console:
```
cd -P Desktop
cd -P nasm
./configure
make
sudo make install
```

Compilando Linux:
```
nasm -f elf hello_world.asm
gcc hello_world.c hello_world.o
./a.out
```

# Exponencial:

São recebidos 2 valores do programa C: um valor para a base que será armazenado em ebx e outro para o valor do expoente, armazenado no registrador ecx. 

A execução começa com  a inicialização dos valores, gravando o valor da base em eax. Após esta fase, no loop representado pela label "calculo", o valor da base é multiplicado com o valor em eax, e o valor do expoente (ecx), é subtraído de 01. Se o valor de ecx não for igual à um, o fluxo será desviado para o label "calculo". Após o valor de ecx ter chegado à 01, o fluxo de execução é desviado para o label "final", onde são realizados os procedimentos para o término da rotina e retorno para o programa que a chamou.

# Maior:

São recebidos 2 valores do programa C: um ponteiro para o vetor que será armazenado em ebx e o tamanho do vetor, armazenado na posição de memória de label "tamanho". O registrador ecx é utilizado como índice para acesso ao vetor. A execução começa com a inicialização dos valores, gravando a primeira posição do vetor em eax. Após esta fase, no loop representado pelos labels "verificar" e "contagem" o vetor é percorrido de uma em uma posição, e o valor desta posição é comparado com o valor atual em eax. 

Se o valor do vetor for maior, esse valor é gravado em eax. Se for menor ou igual, o vetor será incrementado em 01 e o fluxo será desviado para o label "verificar". Após o término do vetor, o fluxo de execução é desviado para o label "final", onde são realizados os procedimentos para o término da rotina e retorno para o programa que a chamou.
 
# TriânguloR:

Baseado no teorema de Pitágoras, (soma dos quadrados dos catetos é igual a soma do quadrado da hipotenusa para um triângulo retângulo), recebemos pela main em C, 3 parâmetros inteiros sendo um deles a hipotenusa e os outros dois os catetos de um suposto triângulo retângulo. O registrador ecx recebe a hipotenusa e os registradores ebx e edx recebem os catetos.Na label "checktriangulo" é calculado os quadrados da hipotenusa e dos dois catetos, é calculado tambem a soma desses quadrados dos catetos e por fim é comparado essa soma dos quadrados dos catetos com a soma do quadrado da hipotenusa. 

Caso seja igual pula para a label "ehtriangulo" e caso contrário pula para label ntriangulo. Na label "ehtriangulo", o registrador eax recebe 1 e pula para a label "final" confirmando que o triângulo especificado é retângulo e na label "ntriangulo", o registrador eax recebe 0, confirmando que o triângulo especificado não é retângulo. Na label "final", são realizados os procedimentos para o final da rotina e é feito o retorno para o programa que chamou a função. 
 
# Bissexto:

Por um parâmetro inteiro recebido de um programa em C, a rotina verifica se esse parâmetro, é um ano bissexto. Na rotina "calculo" o registrador eax recebe o valor do registrador ebx que no caso tem o parâmetro ano. O registrador edx, que conterá o resto da divisão é inicializado como 0 para não ficar guardado algum tipo de lixo de memória, o registrador ecx recebe o valor 4, no caso o registrador ecx nessa rotina será usado como o divisor do parâmetro ano. Após feita a divisão entre eax e ecx, é comparado o resto com 0, caso seja igual o fluxo é desviado para a rotina 'provbissexto", caso contrário o fluxo é desviado para rotina "nbissexto". 

Na rotina "provbissexto" o parâmetro ano, é é novamente passado pro registrador eax, o resto edx é zerado, e o divisor ecx recebe um novo valor: 100. Caso o resto seja diferente de zero o fluxo é alterado para a rotina "nbissexto", caso contrário, o registrador recebe uma última vez o parâmetro ano, o resto é zerado e o divisor ecx recebe agora 400. Comparando o resto dessa divisão caso for igual a 0, o fluxo é desviado para a rotina "ehbissexto", onde o registrador eax recebe o valor 1 para retorno, caso seja diferente o fluxo é desviado para a rotina "nbissexto", onde o registrador eax recebe 0 para retorno ao programa chamador. Após eax receber 0, ou 1 dependendo de qual label o fluxo foi desviado, ao final de cada label, o fluxo vai para label final, aonde termina os procedimentos necessários e retornar o valor de eax entre 0 ou 1 para o programa chamador.    
