.data
a:	.word  	1
c:	.word  	2		#veri değerlerini ekledim. çalışmasını test etmek için rastgele değerler girdim
d:	.word	3
e:	.word	4
sonuc:	.word	0

.text
main:
        addiu   $sp,$sp,-4

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
        
	lw	$16, 0($sp)	#bu kısımda bellekten a ve c değerlerini yükledim(s0 ve s1'e yükledim). a + c işlemini yaptırdım ve sonucu s1'de tuttum.
	lw	$17, 4($sp)
	addu	$17, $17, $16

	mflo	$16		#bu kısımda s0'a daha önce yaptırdığım çarpma işleminin sonucunu lo'dan yükledim ve s1'de bulunan a + c işleminden s0'ı çıkardım.
	subu	$16, $17, $16	#yani (a+c) - (d*e) işlemini yaptırdım ve çıkan sonucu s0'a atadım.

	sw	$16, sonuc	#yapılan işlemlerin sonucunu tutan $s0 değerini sonuc verisine atadım ve stack'e yerleştirdim.
	sw	$16, 20($sp)

        li $2, 10		#kodu bitirdim.
	syscall