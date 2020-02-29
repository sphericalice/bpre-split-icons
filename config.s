input_rom equ "rom.gba"
output_rom equ "test.gba"

.definelabel free_space, 0x08800000

.definelabel move_data, 0x250C04
.definelabel move_descriptions, 0x4886e8
.definelabel hp_type_decode_addr, 0x0

unhidden_power equ false
CATEGORY_ICONS equ 25
