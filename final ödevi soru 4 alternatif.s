.data
a:	.word  	1
c:	.word  	2		#veri değerlerini ekledim. çalışmasını test etmek için rastgele değerler girdim
d:	.word	3
e:	.word	4
sonuc:	.word	0

.text
main:
        addiu   $sp,$sp,-4
	
	la	$4, a
	li	$2, 1
	syscall
        lw      $16,a                        
        sw      $16,0($sp)

        lw      $16,c                        
        sw      $16,4($sp)	#bir stack pointer oluşturum ve yukarıda tanımladığım değerleri okuyup stacklere yerleştirdim.
        lw      $16,d                       
        sw      $16,8($sp)
        lw      $16,e                        
        sw      $16,16($sp)

        lw      $16,8($sp)
        lw      $17,16($sp)	#bu kısımda öncelikle d ve e değerlerini bellekten yükledim(s0 ve s1'e yükledim) ve d x e işlemini yaptırdım(çarpma işleminin önceliğini kullanabilmek için) 			
        mult    $16,$17		#LO, bu işlemin sonucunu tutuyor, $s1 değeri ise d x e işleminin sonucunu tutuyor.
        mflo    $17

	lw	$16, 4($sp)	# bu kısımda bellekten c değerini yükledim(s0'a yükledim) ve bir üstteki kısımda tuttuğum d x e değerini, c değerinden çıkardım(c-(d x e))
        subu    $17,$16,$17	#$s1 değeri, (c-(d x e)) işleminin sonucunu tutuyor.

        lw      $16,0($sp)	# bu kısımda bellekten a değerini yükledim(s0'a yükledim) ve a + c - c x d işlemini gerçekleştirdim. 
	addu    $17,$17,$16	#$s1 değeri, bu işlemin sonucunu tutuyor.

	sw	$17, sonuc	#yapılan işlemlerin sonucunu tutan $s1 değerini sonuc verisine atadım ve stack'e yerleştirdim.
	sw	$17, 20($sp)

	la	$4, a
	li	$2, 1
	syscall
	
	lw	$4, 20($sp)
	li	$2, 1
	syscall
	

	

        li $2, 10		#kodu bitirdim.
	syscall

	
	