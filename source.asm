.686
.model flat
public _mulMatrix64


.data
mat1ptr	dd 0
row1ptr dd 0
mat1var dq 0

mat2ptr	dd 0
row2ptr dd 0
mat2var dq 0

mat3ptr	dd 0
row3ptr dd 0
mat3var dq 0

varA	dd 0
varB	dd 0
varC	dd 0

varSum	dq 0
varMul	dq 0

.code

_mulMatrix64 proc
	push	ebp
	mov		ebp, esp

	;wskazniki na macierze
	mov		eax, [ebp+8]
	mov		mat1ptr, eax
	mov		eax, [eax]
	mov		row1ptr, eax

	mov		eax, [ebp+12]
	mov		mat2ptr, eax
	mov		eax, [eax]
	mov		row2ptr, eax

	mov		eax, [ebp+16]
	mov		mat3ptr, eax
	mov		eax, [eax]
	mov		row3ptr, eax

	;zmienne
	mov		eax, [ebp+20]
	mov		varA, eax
	mov		eax, [ebp+24]
	mov		varB, eax
	mov		eax, [ebp+28]
	mov		varC, eax

	;petle
	mov		ebx, 0
ptl1:
	cmp		ebx, varA
	je		theEnd

	mov		ecx, 0
ptl2:
	cmp		ecx, varC
	je		endPtl1
	
	mov		esi, 0
ptl3:
	cmp		esi, varB
	je		endPtl2

endPtl3:
	;row1ptr?
	mov		eax, 4
	mul		ebx		        ; eax = ecx*4
	mov		edi, mat1ptr
	add		edi, eax		;=mat1ptr[ecx*4]	
	mov		edi, [edi]
	mov		row1ptr, edi

	mov		eax, 8			;8 bajt
	mul		esi				;eax = esi*4
	add		row1ptr, eax
	
	;row2ptr?
	mov		eax, 4
	mul		esi				;eax=4*esi
	mov		edi, mat2ptr
	add		edi, eax		;mat2ptr[esi*4]
	mov		edi, [edi]
	mov		row2ptr, edi

	mov		eax, 8			;8 bajt
	mul		ecx				;eax=4*ecx
	add		row2ptr, eax



	;fld fst
	mov		edi, row1ptr
	fld		qword ptr [edi]
	fstp	qword ptr mat1var
	

	mov		edi, row2ptr
	fld		qword ptr [edi]
	fstp	qword ptr mat2var


	fld		qword ptr mat1var
	fld		qword ptr mat2var
	fmulp
	fstp	qword ptr varMul

	fld		qword ptr varMul
	fld		qword ptr varSum
	faddp
	fstp	qword ptr varSum


	inc		esi
	cmp		esi, varB
	jne		ptl3

endPtl2:
	;row3ptr?
	mov		eax, 4
	mul		ebx
	mov		edi, mat3ptr
	add		edi, eax
	mov		edi, [edi]
	mov		row3ptr, edi

	mov		eax, 8			;8 bajt
	mul		ecx
	add		row3ptr, eax


	;matrix3[i][j] = varSum

	;mov	edi, varSum
	mov		eax, row3ptr
	
	fld		qword ptr varSum
	fstp	qword ptr [eax]

	;mov	[eax], edi
	fldz
	fstp	qword ptr varSum
	;mov		varSum, 0

	inc		ecx
	cmp		ecx, varC
	jne		ptl2

endPtl1:
	inc		ebx
	cmp		ebx, varA
	jne		ptl1
	
theEnd:

	pop		ebp
	ret
_mulMatrix64 endp

end