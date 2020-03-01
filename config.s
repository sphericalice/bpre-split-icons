input_rom equ "rom.gba"
output_rom equ "test.gba"

.definelabel free_space, 0x08800000

.definelabel move_data, 0x900000
.definelabel move_descriptions, 0x910000
.definelabel hp_type_decode_addr, 0x19c7786

unhidden_power equ true
CATEGORY_ICONS equ 26
