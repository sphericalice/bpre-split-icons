.include "config.s"
.include "labels.s"
.include "constants.s"

// -----------------------------------------------------------------------------

.gba
.thumb

.open input_rom, output_rom, 0x08000000

// -----------------------------------------------------------------------------

.org free_space
.align 2

display_icons_battle_sel_move:
@@main:
    push {r4-r6,lr}
    ldr r5, =b_active_side
    ldrb r4, [r5]
    lsl r4, r4, #9
    ldr r0, =(b_buffer_A + 4)
    add r4, r4, r0
    ldr r6, =string_buffer
    ldr r2, =(rom + move_data)
    ldr r1, =byte_2023FFC
    ldrb r0, [r5]
    add r0, r0, r1
    ldrb r0, [r0]
    lsl r0, r0, #1
    add r4, r4, r0
    ldrh r1, [r4]
    lsl r0, r1, #1
    add r0, r0, r1
    lsl r0, r0, #2
    add r0, r0, r2
    ldrb r4, [r0, #2]
    ldrb r5, [r0, #10]
    ldrb r0, [r0, #0]
    cmp r0, #EFFECT_HIDDEN_POWER
    bne @@not_hidden_power
.if unhidden_power
@@hidden_power:
    ldr r0, =b_active_side
    ldrb r0, [r0]
    lsl r0, r0, #1
    ldr r1, =b_pokemon_team_id_by_side
    add r0, r0, r1
    ldrb r0, [r0]
    mov r1, #100
    mul r0, r1
    ldr r1, =party_player
    add r0, r0, r1
    bl @@hp_type_decode
    lsl r0, r0, #0x18
    lsr r4, r0, #0x18
.endif
@@not_hidden_power:
    mov r0, #0x70
    mov r1, #1
    bl @@load_type_icon_pals
    mov r0, #8
    mov r1, #0xFF
    bl @@FillWindowPixelBuffer
    mov r0, #8
    bl @@rboxid_tilemap_update
    mov r0, #8
    mov r1, r4
    add r1, r1, #1
    mov r2, #0
    mov r3, #3
    bl @@draw_type_icon
    mov r0, #8
    bl @@rboxid_tilemap_update
    mov r1, r5
    mov r0, #CATEGORY_ICONS
    add r1, r0, r1
    mov r0, #8
    mov r2, #36
    mov r3, #3
    bl @@draw_type_icon
    mov r0, #8
    bl @@rboxid_tilemap_update
    mov r0, #8
    mov r1, #3
    bl @@rboxid_upload_a
    ldr r0, =(rom + 0x309A4 |1)
    bx r0
.pool

@@rboxid_upload_a:
    ldr r2, =(rom + 0x3F20 |1)
    bx r2
.pool

@@rboxid_tilemap_update:
    ldr r1, =(rom + 0x3FA0 |1)
    bx r1
.pool

@@FillWindowPixelBuffer:
    ldr r2, =(rom + 0x445C |1)
    bx r2
.pool

@@load_type_icon_pals:
    ldr r2, =(rom + 0x107D38 |1)
    bx r2
.pool

@@draw_type_icon:
    ldr r4, =(rom + 0x107D68 |1)
    bx r4
.pool

@@hp_type_decode:
    ldr r1, =(rom + hp_type_decode_addr |1)
    bx r1
.pool

// -----------------------------------------------------------------------------

.org 0x08030940
    ldr r0, =display_icons_battle_sel_move |1
    bx r0
    .pool

// change palette of Type/NORMAL window from 05 to 07 so we can use the type icon graphics here
.org 0x08248375
    .byte 0x07

.close
