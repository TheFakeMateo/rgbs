_Diploma:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call DisableLCD
	ld hl, DiplomaGFX
	ld de, vTiles2
	call Decompress
; Page 1
	ld hl, DiplomaPage1Tilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld de, .Player
	hlcoord 2, 5
	call PlaceString
	ld de, wPlayerName
	hlcoord 9, 5
	call PlaceString
	ld de, .Certification
	hlcoord 2, 8
	call PlaceString
	call EnableLCD
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetPalettes
	call DelayFrame
	call WaitPressAorB_BlinkCursor
; Page 2
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	call ByteFill
	ld hl, DiplomaPage2Tilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld de, .GameFreak
	hlcoord 8, 0
	call PlaceString
	ld de, .PlayTime
	hlcoord 3, 15
	call PlaceString
	hlcoord 12, 15
	ld de, wGameTimeHours
	lb bc, 2, 4
	call PrintNum
	ld [hl], $67 ; colon
	inc hl
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	jp WaitPressAorB_BlinkCursor

.Player: db "PLAYER@"

.Certification:
	db   "This certifies"
	next "that you have"
	next "completed the"
	next "new #DEX."
	next "Congratulations!"
	db   "@"

.PlayTime: db "PLAY TIME@"
.GameFreak: db "GAME FREAK@"

DiplomaGFX:
INCBIN "gfx/diploma/diploma.2bpp.lz"

DiplomaPage1Tilemap:
INCBIN "gfx/diploma/page1.tilemap"

DiplomaPage2Tilemap:
INCBIN "gfx/diploma/page2.tilemap"
