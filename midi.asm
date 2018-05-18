	bits 16

segment code

	..start: ; entry point

	; setup stack
	mov ax, stack
	mov ss, ax
	mov sp, stack_top

	; print 'A' in the screen
	mov ah, 0eh
	mov al, 'A'
	int 10h

	; Get Environment Settings
	mov bx, 2
	mov dx, enviroment
	mov ax, blaster
	call driver:ct_midi

	; Initialize Driver
	mov bx, 3
	call driver:ct_midi

	; Prepare MIDI Start
	mov bx, 8
	mov dx, midi
	mov ax, music
	call driver:ct_midi

	; Play MIDI Music
	mov bx, 9
	call driver:ct_midi

	; wait for keypress
	mov ah, 0
	int 16h

	; Terminate Driver
	mov bx, 4
	call driver:ct_midi

	; return to DOS
	mov ah, 4ch
	int 21h

segment enviroment
	blaster db "A220 I7 D1 H5 T6"

segment driver align=16
	ct_midi:
		incbin "ctmidi.drv"

segment midi
	music:
		incbin "mario.mid"

segment stack stack
		resb 256
	stack_top:



