# Firmata protocol

## Preface

This is my personal interpretation of "Firmata" protocol. It's based on [protocol v2.6.0 description][proto] and [C++ implementation for Arduino][impl].

All literal two-digit numbers here are hexadecimal.

Read tables from left to right.

It's OK to raise issue for grammar errors. I'm not native English writer.

[proto]: https://github.com/firmata/protocol/blob/master/protocol.md
[impl]: https://github.com/firmata/arduino


## Protocol

Variable-sized messages with byte granulatiry. Format of message is determined by value of first byte(s).

All "command" bytes have 8-th bit set, so lie in `80`..`FF`. All data bytes have 8-th bit clear, so lie in `00`..`7F`. So simple parser can ignore all data bytes while looking for predefined command.


## Data format

Indeed there are two formats of messages:

* Core commands

  command    | data_bytes ...
  -----------|-------------------
  `80`..`FF` | `00`..`7F` ...

* Extended commands

   * Base id

      sysex_start | command      | data_bytes ... | sysex_end |
      ------------|--------------|----------------|-----------|
      `F0`        | `0x10`..`7F` | `00`..`7F` ... | `F7`      |

   * Extended id.

      sysex_start | zero | command_byte_2 | command_byte_1 | data_bytes ... | sysex_end |
      ------------|------|----------------|----------------|----------------|-----------|
      `F0`        | `00` | `00`..`7F`     | `00`..`7F`     | `00`..`7F` ... | `F7`      |

      Currently extended ids are not used and just pure theoretical extension.

      Extended ids do not intersect with core ids. So core command `10` is not equal to extended command `0010`.


## Commands

* Core

  * System reset

    command |
    --------|
    `FF`    |

    No reply

    Resets state to default and executes initialization sequence (report version).

  * Request firmware version

    command |
    --------|
    `F9`    |

    Reply

    command | major_version | minor_version |
    --------|---------------|---------------|
    `F9`    | `00`..`7F`    | `00`..`7F`    |

  * Set pin mode

    command | pin_number | pin_mode   |
    --------|------------|------------|
    `F4`    | `00`..`7F` | `00`..`0B` |

      ***pin_mode***

      > value | mode
      > ------|----------------
      > `00`  | digital input
      > `01`  | digital output
      > `02`  | analog input
      > `03`  | PWM
      > `04`  | servo
      > `05`  | shift
      > `06`  | I2C
      > `07`  | one-wire
      > `08`  | stepper
      > `09`  | encoder
      > `0A`  | serial
      > `0B`  | input_pullup

    No reply

  * Set digital pin value

    command | pin_number | LOW/HIGH   |
    --------|------------|------------|
    `F5`    | `00`..`7F` | `00`..`01` |

    No reply

  * Enable/disable analog pin value reporting

    command    | disable/enable |
    -----------|----------------|
    `C0`..`CF` | `00`..`01`     |

    Low nibble of command byte is analog pin number.

    Replies are

    command    | bits(0..6) | bits(7..13) |
    -----------|------------|-------------|
    `E0`..`EF` | `00`..`7F` | `00`..`7F`  |

    Low nibble of command byte is analog pin number.

    Pin value is queried every 19ms by default. This time may be changed via "set sampling interval" command.

  * Enable/disable digital port value reporting

    (Port value is byte where every bit represents pin. Port 0 is pins 0 to 7, port 1 is pins 8 to 15 etc.)

    command    | disable/enable |
    -----------|----------------|
    `D0`..`DF` | `00`..`01`     |

    Low nibble of command byte is port number.

    Replies are

    command    | pins(0..6) | pin_7      |
    -----------|------------|------------|
    `90`..`9F` | `00`..`7F` | `00`..`01` |

    Low nibble of command byte is port number.

    Port value is reported every time firmware main loop executed (as fast as possible).


* Extended

  (Mind that every extended command must be embraced in `F0` `F7` bytes.)

  * Request firmware name and version

     command |
     --------|
     `79`    |

     Reply

     command | major_version | minor_version | name_char_low, name_char_high  ... |
     --------|---------------|---------------|------------------------------------|
     `79`    | `00`..`7F`    | `00`..`7F`    | `00`..`7F`, `00`..`01` ...         |

     ***firmware_name***

     The name of the Firmata client file, minus the file extension. So for `StandardFirmata.ino` *firmware_name* is `StandardFirmata`.

     Every byte of ASCII name is split in two: first byte contains lower 7 bits, second contains 8-th bit (at bit 0).

  * Request board pin modes

    command |
    --------|
    `6B`    |

    Reply

    command | pin_modes_list ... |
    --------|--------------------|
    `6C`    | `00`..`7F` ...     |

    ***pin_modes_list***

    Delimited list of pairs mode-resolution for each pin. Items delimiter is `7F`. Item can be empty.

    Each item is

    mode           | mode_resolution |
    ---------------|-----------------|
    `00`..`0B`     | `00`..`7F`      |

      ***mode***

      > value | mode
      > ------|----------------
      > `00`  | digital input
      > `01`  | digital output
      > `02`  | analog input
      > `03`  | PWM
      > `04`  | servo
      > `05`  | shift
      > `06`  | I2C
      > `07`  | one-wire
      > `08`  | stepper
      > `09`  | encoder
      > `0A`  | serial
      > `0B`  | input_pullup

      ***mode_resolution***

      > Number of bits in value for given mode. 1 for binary, 10 fo analog. For "servo" it's a bit length of maximum number of steps.
      >
      > For "serial" it has different meaning. It stores RX/TX pin type and UART index according to following table.
      >
      > value | mode
      > ------|------------
      > `00`  | RX, UART 0
      > `01`  | TX, UART 0
      > `02`  | RX, UART 1
      > ...   | ...
      > `0F`  | TX, UART 7

  * List analog pins

    command |
    --------|
    `69`    |

    Reply

    command | analog_index_mapping ... |
    --------|--------------------------|
    `6A`    | `00`..`7F` ...           |

    ***analog_index_mapping***

    Analog index mapping for every pin. `7F` means given pin does not support analog input mode. 0 means `A0`, 1 - `A1`, etc.

  * String reply

    This message is possible reply to some commands. Typically it means error occurred and string contains reason.

    command | char\_(i)\_bits(0..6), char\_(i)\_bits(7..13) ... |
    --------|---------------------------------------------------|
    `71`    | `00`..`7F`, `00`..`7F` ...                        |

    Maximum message length for Arduino Uno version is 30 characters.

  * Get pin state

    For output modes (digital output, PWM, servo), the state is value previously written to pin. For input modes (except digital input) it is zero. For digital input mode it is status of pull-up resistor: 1 means enabled, 0 - disabled.

    command | pin        |
    --------|------------|
    `6D`    | `00`..`7F` |

    Reply

    command | pin        | pin_mode   | state_bits(0..6) [state_bits(7..13) [...]] |
    --------|------------|------------|--------------------------------------------|
    `6E`    | `00`..`7F` | `00`..`0B` | `00`..`7F` [`00`..`7F` [...]]              |

  * Set pin value, 14+ bits resolution

     command | pin        | value_bits(0..6) [value_bits(7..13) [...]] |
     --------|------------|--------------------------------------------|
     `6F`    | `00`..`7F` | `00`..`7F` [`00`..`7F` [...]]              |

  * Set sampling interval

    command | sampling_ms_bits(0..6) | sampling_ms_bits(7..13) |
    --------|------------------------|-------------------------|
    `7A`    | `00`..`7F`             | `00`..`7F`              |

    No reply

    Sampling interval is time interval between analog pin value reporting. See "enable/disable analog pin value reporting" command.

    Default value is 19ms.
