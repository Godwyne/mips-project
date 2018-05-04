.data
quad: .asciiz "aX^2 + bX + c\n"
message1: .asciiz "\nEnter value for a="
message2: .asciiz "\nEnter value for b="
message3: .asciiz "\nEnter value for c="
answer: .asciiz "\nThe two value for X\n"
any_key: .asciiz "\nEnter 1 to continue or Enter any other number to quit\n"
error:  .asciiz "\nThis equation has a complex root and cannot be solved,try again using another number!"
press1: .word 1
a_n_d: .asciiz "\n&\n"
zerofloat: .float 0.0
one: .float -1.0
two: .float 2
four: .float 4


 .text
 la $a0,quad
 li $v0,4
 syscall
 
 #lw $t3,press1
 
  main:
  lwc1 $f4,zerofloat
  lwc1 $f2,one
  lwc1 $f20,two
  lwc1 $f18,four
  
  
  #ask for first input
  la $a0,message1
  li $v0,4
  syscall
  
  li $v0,6
  syscall
  mov.s $f6,$f0
  
  #ask for second input
  la $a0,message2
  li $v0,4
  syscall
  
  li $v0,6
  syscall
  mov.s $f8,$f0
  
  #ask for third input
  la $a0,message3
  li $v0,4
  syscall
  
  li $v0,6
  syscall
  mov.s $f10,$f0
  
  mul.s $f2,$f2,$f8  # multiply -1*b = -b
  mul.s $f8,$f8,$f8 #multiply b*b and int0 $f8 = b^2
  mul.s $f16,$f20,$f6  #multiply 2 by 'a' value into $f16 = 2*a
  mul.s $f12,$f6,$f10 #multiply a*c into $f12 = a*c
  mul.s $f14,$f12,$f18 #multiply 4 by 'ac' = 4*a*c
  sub.s $f22,$f8,$f14  #d = b^2 - 4*a*c
  
  mfc1 $t5,$f22  #move from coprocessor1 to integer
  blez $t5,complexroot  #branch if d<0 go to complexroot
  

  
   sqrt.s $f24,$f22 
   add.s  $f26,$f2,$f24  #-b + sqrt (b^2 - 4*a*c) = X1
   sub.s $f28,$f2,$f24  #-b - sqrt (b^2 - 4*a*c) =X2
   div.s $f14,$f26,$f16  #-b + sqrt (b^2 - 4*a*c)/ 2a
   div.s $f13,$f28,$f16  #-b - sqrt (b^2 - 4*a*c) / 2a
   

   
   la $a0,answer
   li $v0,4
   syscall
   
   add.s $f12,$f14,$f4
   li $v0,2
   syscall
   
   la $a0,a_n_d
   li $v0,4
   syscall
   
   add.s $f12,$f13,$f4
   li $v0,2
   syscall
  b anykey
   
complexroot:
   la $a0,error
   li $v0,4
   syscall

anykey:
   li $t3,1
   la $a0,any_key
   li $v0,4
   syscall
   li $v0,5
   syscall
   move $t1,$v0
   beq $t1,$t3,main #if the input is equal to press1($t3) branch to main
   
   #exit
   li $v0,10
   syscall 
   

  
   
   
   
   
   
  
  
   
