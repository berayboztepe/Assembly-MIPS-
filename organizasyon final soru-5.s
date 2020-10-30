.data
	x : 	.word 0
	ptr : 	.word 0 




.text
main:	la	$8, x
	li	$2, 22		#burada x'in adresini alıyorum ve bu adresin tuttuğu değeri 22 (x = 22) yapıp x'i stack'e yerleştiriyorum.
	sw	$2, 0($8)
	

	sw	$8, 4($8) 	#burada x'in adresini ptr ye eşitliyorum ve stack'e yüklüyorum. (ptr = &x)
	
        li      $2,100 
	lw      $3,4($8)	#burada ise yüklediğim ptr değerinin tuttuğu adresteki değeri 100 yapıyorum.   (*ptr = 100)               
        sw      $2,0($3)



	li	$2, 10		#kodu bitirdim
	syscall
	

	

	
	