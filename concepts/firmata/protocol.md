# Firmata protocol

## Preface

This is my interpretation of "Firmata" protocol. It is based on
[Firmata protocol v2.6.0][proto] and [C++ implementation for Arduino][impl].

[proto]: https://github.com/firmata/protocol/blob/master/protocol.md
[impl]: https://github.com/firmata/arduino


## Protocol

Firmata is command-data protocol with byte granularity. All "command" bytes
have 8-th bit set, so lie in range `80`..`FF`. All data bytes have 8-th bit
clear, so lie in range `00`..`7F`.


## Commands

* Pin mode
  * [Set pin mode](#set_pin_mode)
  * [Get pins modes](#get_pins_modes)
  * [Get analog pins mapping](#get_analog_pins_mapping)
* Pin value
  * [Set digital pin value](#set_pin_value_digital)
  * [Set analog pin value](#set_pin_value_analog)
  * [Enable/disable digital port value reporting](#digital_port_reporting)
  * [Enable/disable analog pin value reporting](#analog_pin_reporting)
  * [Get pin state](#get_pin_state)
* Misc
  * [System reset](#reset)
  * [Get firmware version](#get_firmware_version)
  * [Get firmware name and version](#get_firmware_name_version)
  * [Set sampling interval](#set_sampling_interval)
  * [String reply](#string_reply)

----------------------------------------------------------------------

----------------------------------------------------------------------

### Set pin mode <a name="set_pin_mode"/>

Set mode for given pin. Usually mode is input or output.

```
  ╭────╮ ╭───────╮ ╭──────╮
→ │ F4 ├─┤ Pin # ├─┤ Mode │
  ╰────╯ ╰───────╯ ╰──────╯
```

```
← ∅
```

__Mode__<a name="pin_modes"/>

  Value | Description
 -------|-----------------
  `00`  | Digital input
  `01`  | Digital output
  `02`  | Analog input
  `03`  | PWM (pseudo-analog output)
  `04`  | Servo
  `05`  | Shift
  `06`  | I2C
  `07`  | One-wire
  `08`  | Stepper
  `09`  | Encoder
  `0A`  | Serial
  `0B`  | Digital input-pullup

----------------------------------------------------------------------

### Get pins modes <a name="get_pins_modes"/>

For each pin on board list all modes it can support.

```
  ╭────╮ ╭────╮ ╭────╮
→ │ F0 ├─┤ 6B ├─┤ F7 │
  ╰────╯ ╰────╯ ╰────╯
```

```
  ╭────╮ ╭────╮                                   ╭────╮   ╭────╮
← │ F0 ├─┤ 6C ├─┬─┬─────────────────────────────┬─┤ 7F ├─┬─┤ F7 │
  ╰────╯ ╰────╯ ↑ │   ╭──────╮ ╭────────────╮   │ ╰────╯ │ ╰────╯
                │ ╰─┬─┤ Mode ├─┤ Resolution ├─┬─╯        │
                │   ↑ ╰──────╯ ╰────────────╯ │          │
                │   ╰───── #(Pin modes) ──────╯          │
                ╰────────────── #Pins ───────────────────╯
```

[__Mode__](#pin_modes) - same mapping as for "Set pin mode".

__Resolution__ - number of bits in value for given mode.

  Mode # | Mode name             | Resolution bits
 --------|-----------------------|----------------
  `00`   | Digital input         | 1
  `01`   | Digital output        | 1
  `0B`   | Digital input-pullup  | 1
  `06`   | I2C                   | 1
  `03`   | PWM                   | 8
  `02`   | Analog input          | 10
  `04`   | Servo                 | 14
  `0A`   | Serial                | 4: Bit.0: 0 - RX, 1 - TX, Bit.1 .. Bit.3 - UART port number.

----------------------------------------------------------------------

### Get analog pins mapping <a name="get_analog_pins_mapping"/>

Returns byte array _A_ with length of _#Pins_. For given index _i_,
(A[i] == 7F) means that pin _i_ doesn't support analog mode. Other
value of A[i] means __analog pin index__: 0 - A0, 1 - A1, etc.

```
  ╭────╮ ╭────╮ ╭────╮
→ │ F0 ├─┤ 69 ├─┤ F7 │
  ╰────╯ ╰────╯ ╰────╯
```

```
  ╭────╮ ╭────╮     ╭──────────────────╮     ╭────╮
← │ F0 ├─┤ 6A ├─┬─┬─┤ Analog pin index ├─┬─┬─┤ F7 │
  ╰────╯ ╰────╯ ↑ │ ╰──────────────────╯ │ │ ╰────╯
                │ │ ╭────╮               │ │
                │ ╰─┤ 7F ├───────────────╯ │
                │   ╰────╯                 │
                ╰──────── #Pins ───────────╯
```

----------------------------------------------------------------------

### Set digital pin value <a name="set_pin_value_digital"/>

```
  ╭────╮ ╭───────╮ ╭────────────────╮
→ │ F5 ├─┤ Pin # ├─┤ LOW/HIGH (0/1) │
  ╰────╯ ╰───────╯ ╰────────────────╯
```

```
← ∅
```

----------------------------------------------------------------------

### Set analog pin value <a name="set_pin_value_analog"/>

```
  ╭────╮ ╭────╮ ╭───────╮ ╭──────────────────╮           ╭────╮
→ │ F0 ├─┤ 6F ├─┤ Pin # ├─┤ Value.Bit.0 .. 6 ├──────┬────┤ F7 │
  ╰────╯ ╰────╯ ╰───────╯ ╰─┬────────────────╯      │    ╰────╯
                            │ ╭───────────────────╮ │
                            ╰─┤ Value.Bit.7 .. 13 ├─┤
                              ╰─┬─────────────────╯ │
                                │                   │
                                ╰─ ... ─────────────╯
```

```
← ∅
```

----------------------------------------------------------------------

### Enable/disable digital port value reporting <a name="digital_port_reporting"/>

Port value is byte where every bit represents pin. So _port 0_ are
pins 0 to 7, _port 1_ are pins 8 to 15, etc. 16 ports are possible,
so this command capacity is 128 digital pins.

Port value is reported every time firmware main loop executed (as fast
as possible).

```
  ╭───────────────╮ ╭──────────────────────╮
→ │ D0 + (Port #) ├─┤ Enable/disable (1/0) │
  ╰───────────────╯ ╰──────────────────────╯
```

```
     ╭───────────────╮ ╭────────────╮ ╭─────────────╮
← ─┬─┤ 90 + (Port #) ├─┤ Pin.0 .. 6 ├─┤ Pin.7 (0/1) ├─╮
   ↑ ╰───────────────╯ ╰────────────╯ ╰─────────────╯ │
   ╰──────────────────────────────────────────────────╯
```

__Port #__ - value between 0 and 15.

----------------------------------------------------------------------

### Enable/disable analog pin value reporting <a name="analog_pin_reporting"/>

Pin value is reported every 19 ms by default. This time may be changed
via [set sampling interval](#set_sampling_interval) command.

```
  ╭─────────────────────╮ ╭──────────────────────╮
→ │ C0 + (Analog pin #) ├─┤ Enable/disable (1/0) │
  ╰─────────────────────╯ ╰──────────────────────╯
```

```
     ╭─────────────────────╮ ╭────────────╮ ╭─────────────╮
← ─┬─┤ E0 + (Analog pin #) ├─┤ Bit.0 .. 6 ├─┤ Bit.7 .. 13 ├─ delay ─╮
   ↑ ╰─────────────────────╯ ╰────────────╯ ╰─────────────╯         │
   ╰────────────────────────────────────────────────────────────────╯
```

__Analog pin #__ - value between 0 and 15. 0 means A0, 1 - A1, etc.

----------------------------------------------------------------------

### Get pin state <a name="get_pin_state"/>

```
  ╭────╮ ╭────╮ ╭───────╮ ╭────╮
→ │ F0 ├─┤ 6D ├─┤ Pin # ├─┤ F7 │
  ╰────╯ ╰────╯ ╰───────╯ ╰────╯
```

```
  ╭────╮ ╭────╮ ╭───────╮ ╭──────────╮ ╭──────────────────╮        ╭────╮
← │ F0 ├─┤ 6E ├─┤ Pin # ├─┤ Pin mode ├─┤ State.Bit.0 .. 6 ├──────┬─┤ F7 │
  ╰────╯ ╰────╯ ╰───────╯ ╰──────────╯ ╰─┬────────────────╯      │ ╰────╯
                                         │ ╭───────────────────╮ │
                                         ╰─┤ State.Bit.7 .. 13 ├─┤
                                           ╰─┬─────────────────╯ │
                                             │                   │
                                             ╰─ ... ─────────────╯
```

__State__ - pin state value, meaning depends of pin mode:

  Mode                                | Value or meaning
  ------------------------------------|----------------------------------------
  digital output, PWM, servo          | value, previously written to pin
  analog input                        | 0
  digital input-pullup, digital input | 1/0 - pullup resistor enabled/disabled

----------------------------------------------------------------------

### System reset <a name="reset"/>

Reset to initial state and execute initialization sequence.

```
  ╭────╮
→ │ FF │
  ╰────╯
```

```
← ─ ∅
```

----------------------------------------------------------------------

### Get firmware version <a name="get_firmware_version"/>

Report major and minor version of protocol in two 7-bit bytes.

```
  ╭────╮
→ │ F9 │
  ╰────╯
```

```
  ╭────╮ ╭───────────────╮ ╭───────────────╮
← │ F9 ├─┤ Major version ├─┤ Minor version │
  ╰────╯ ╰───────────────╯ ╰───────────────╯
```

----------------------------------------------------------------------

### Get firmware name and version <a name="get_firmware_name_version"/>

Every byte of ASCII name is split in two: first byte contains lower 7
bits, second contains 8-th bit (at bit 0).

```
  ╭────╮ ╭────╮ ╭────╮
→ │ F0 ├─┤ 79 ├─┤ F7 │
  ╰────╯ ╰────╯ ╰────╯
```

```
  ╭────╮ ╭────╮ ╭───────────────╮ ╭───────────────╮                                           ╭────╮
→ │ F0 ├─┤ 79 ├─┤ Major version ├─┤ Minor version ├──┬──────────────────────────────────────┬─┤ F7 │
  ╰────╯ ╰────╯ ╰───────────────╯ ╰───────────────╯  │   ╭─────────────────╮ ╭────────────╮ │ ╰────╯
                                                     ╰─┬─┤ Char.Bit.0 .. 6 ├─┤ Char.Bit.7 ├─┤
                                                       ↑ ╰─────────────────╯ ╰────────────╯ │
                                                       ╰──────── #(Firmware name) ──────────╯
```

__Firmware name__ - name of the Firmata client file, minus the file
extension. So for `StandardFirmata.ino` _firmware_name_ is
`StandardFirmata`. But in practice name is __with__ `.ino` extension
as implementation code strips only `.cpp` extension.

----------------------------------------------------------------------

### Set sampling interval <a name="set_sampling_interval"/>

Sampling interval is time interval between analog pin value reporting.
Used in [enable/disable analog pin value reporting](#analog_pin_reporting)
command.

Default value is __19 ms__.

```
  ╭────╮ ╭────╮ ╭────────────────────────╮ ╭─────────────╮ ╭────╮
→ │ F0 ├─┤ 7A ├─┤ Sampling_ms.Bit.0 .. 6 ├─┤ Bit.7 .. 13 ├─┤ F7 │
  ╰────╯ ╰────╯ ╰────────────────────────╯ ╰─────────────╯ ╰────╯
```

```
← ∅
```

----------------------------------------------------------------------

### String reply <a name="string_reply"/>

This is possible reply to some commands. Typically it means that error
occurred and string contains reason.

Maximum message length for Arduino Uno version is 30 characters.

```
→ ∅
```

```
  ╭────╮ ╭────╮                                             ╭────╮
← │ F0 ├─┤ 71 ├──┬────────────────────────────────────────┬─┤ F7 │
  ╰────╯ ╰────╯  │   ╭─────────────────╮ ╭────────────╮   │ ╰────╯
                 ╰─┬─┤ Char.Bit.0 .. 6 ├─┤ Char.Bit.7 ├─┬─╯
                   ↑ ╰─────────────────╯ ╰────────────╯ │
                   ╰──────────── #Message ──────────────╯

```

----------------------------------------------------------------------
