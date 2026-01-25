## What

Image settlement.

Loosely related files without argument type checks. Idea is that
when you use them correctly they do what they meant to do.

## Details

Code at this moment was influenced by several users. Gradient filling
wants color smoothing, NetPBM image codec wants data matrix and color
encoding format, general user wants to know image dimensions, color
format and easy method to get/set pixel.

Below is a description of that villagers. They are agnostics and
if you want to shoot off your foot by misusing them - you can.
Still you can shoot off your foot more efficiently by doing it
directly.

### Composition

  * Matrix
    * Line
      * Color
---
  * Settings
  * Interface

Matrix is a list of lines. Line is a list of colors. Color is a list
of color channels. Color channel is some number value.

Color channel value can be float-point in unit interval (between 0.0
and 1.0) or integer, which is typically in byte range (between 0 and 255).

Settings and Interface concepts came later from "general user" use-case.
I'm inclined to base code on them.


#### Color functions

  Color is a list of numbers.

  * Spawn Color by Format - receives Color Format and returns list
    with color channels
  * Normalize/Denormalize - Normalize converts Color channels from
    byte range to unit range. Denormalize does inverse.
  * Mix Colors - receives color A, color B and "A portion" which is
    another float in unit range (from 0.0 to 1.0). Return new color
    where each component is mix of components from A and B, respecting
    that "A portion".

#### Line functions

  Line is a list of colors.

  * Denormalize - applies that function to list (unit range to byte)
  * Get Color/Set Color - access by index. Index is supposed to be
    integer number but not have to. If color is already set, Set Color
    does nothing. But behavior for getting non-existent colors and
    re-setting colors is up to implementation.

#### Matrix functions

  Matrix is a list of lines.

  * Denormalize - unit ranges to bytes
  * Create From Line - (outdated) creates matrix from seed line
    duplicated N times
  * Get Color/Set Color - (out of fashion) Access by index. Index is a
    list of two integers. First integer is line index.

#### Settings

  Settings is a set of parameters useful for image processing

  * Width - natural number
  * Height - natural number
  * Color Formats - list of strings
  * Color Format - one string from Color Formats

#### Interface

  Interface is Lua table with run-time API.

  Unlike my many other modules, it's not class-like. It does not contain
  mentioned functions for color, line and matrix. It contains following

  * Settings - settings structure (table, as described above)
  * Data - image data (table, we're agnostic to it)
  * Get Pixel/Set Pixel - functions. They receive coordinates as table
    and doing "deep indexing" on Data to get what it contains.
    Under "deep indexing" we mean `{ 10, 20 }` on `Data` yields to
    `Data[10][20]`.

#### Note

  I'm documenting some parts of existing code. It's mostly for myself.
  I see that new Get/Set Pixel overlaps with Matrix and Line funcs.
  I'll think what I can do but here how it is.
