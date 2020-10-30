.data
mesaj0:	.asciiz "**** Iki Pozitif Sayinin En Buyuk Ortak Bolenini Bulma ****\n"
mesaj1: .asciiz "Birinci Pozitif Sayiyi Giriniz (x)  : "
mesaj2: .asciiz "Ikinci Pozitif Sayiyi Giriniz  (y)  : "
mesaj3:	.asciiz "gcd(x,y)			      : "
mesaj4:	.asciiz "\nDevam Etmek Istermisiniz Evet(e)/Hayir(h): "
mesaj5:	.asciiz "Program Sonlanmistir ...\n"
newline: .asciiz "\n" 

x:	.word	0
y:	.word	0
sonuc:	.word	0


.text
.globl main
main:
	li $v0, 4
	la $a0, mesaj0                 #ilk mesajı yazdırdım
	syscall
	
	la $a0, mesaj1
	syscall				#ikinci mesajı yazdırdım

	li $v0, 5
	syscall
	sw $v0, x			#klavyeden değer girdirdim ve bu değerin adresini x'e atadım
	lw $a0, x
	move $t0, $a0		
	

	li $v0, 4
	la $a0, mesaj2			#üçüncü mesajı yazdırdım
	syscall
	
	li $v0, 5
	syscall
	sw $v0, y			#klavyeden değer girdirdim ve bu değerin adresini y'e atadım
	lw $a0, y
	move $t1, $a0
	

	li $v0, 4
	la $a0, mesaj3			#dördüncü mesajı yazdırdım
	syscall

	
	jal gcd 			
	sw $v0, sonuc
	lw $a0, sonuc			#fonksiyonu çağırdım ve return ettiği değeri sonuc değerine atadım
	move $s5, $a0			
	
	li $v0, 1
	syscall				#sonuç değerini yazdırdım
	

	li $v0, 4
	la $a0, mesaj4			#beşinci mesajı yazdırdım
	syscall
	
	li $v0, 12
	syscall				#klavyeden bir harf girdirdim 'e' ya da 'h'
	move $t2, $v0

	li $v0, 4
	la $a0, newline			# bir satır aşağıya aldırdım
	syscall

	addi $s0, $zero, 101  		#'e' harfinin decimal değerini s0'a atadım(kontrol için)
	addi $s1, $zero, 104		#'h' harfinin decimal değerini s1'e atadım

whileloop: 
	beq $t2, $s1, finish		#döngüde girilen karakterin h olup olmadığını kontrol ettirdim, h değilse devamı üst kısımla aynı(h ise finish'e gönderdim)
	li $v0, 4
	la $a0, mesaj1
	syscall

	li $v0, 5
	syscall
	sw $v0, x
	lw $a0, x
	move $t0, $a0

	li $v0, 4
	la $a0, mesaj2
	syscall
	
	li $v0, 5
	syscall
	sw $v0, y			
	lw $a0, y
	move $t1, $a0


	li $v0, 4
	la $a0, mesaj3
	syscall

	
	jal gcd 			
	sw $v0, sonuc
	lw $a0, sonuc			
	move $s5, $a0
	
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, mesaj4
	syscall
	
	li $v0, 12
	syscall
	move $t2, $v0

	li $v0, 4
	la $a0, newline
	syscall

	j whileloop			#yeniden bir karakter girdirdim ve döngünün devamını sağladım
	


finish: li $v0, 4
	la $a0, mesaj5 			#finish kısmında altıncı mesajı yazdırdım
	syscall
	
	
	li $v0, 10
	syscall				#kodu bitirdim

gcd:   add $sp, $sp, -4
	sw $t0, 0($sp)			#gcd fonksiyonunu çağırdım ve x, y ve sonuç değerlerini stack pointer'a ekledim. (sp sonuc değerini gösteriyor)
	sw $t1, 4($sp)
	sw $ra, 8($sp)

	bne $t0, $zero, loop		# x == 0 ise y'yi döndür. değilse döngüye gir.
	move $v0, $t1
	jr $ra
	
loop:	beqz $t1, Exit
	bgt $t0, $t1, Else		#while döngüsünde y == 0 ise döngüden çık. aksi halde x>y ise x = x-y yap değilse else'ye git. (y == 0 olana kadar döngüye devam et)
	sub $t1, $t1, $t0
	j loop

Else: sub $t0, $t0, $t1			#y = y-x yap ve y == 0 mı diye bak, öyleyse döngüyü bitir değilse döngüye devam et.
	beqz $t1, Exit			
	j loop
		
	

Exit: 	move $v0, $t0			#x değerini döndür
	jr $ra
