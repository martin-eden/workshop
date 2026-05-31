Image settings

PAM is family of image formats. They all starts with <label>:

  label = P1 | P2 | P3 | P4 | P5 | P6 | P7

"P7" is PAM format. It's most generic of them.
It's not supported.

"P1", "P2", "P3" are text formats for
monochrome, grayscale and color data.
They are supported.

"P4", "P5", "P6" are binary formats for
monochrome, grayscale and color data.
They are not supported yet.


Format labels are lost

Parser returns image data and image settings.

Format labels and format-specific header data are propagated in image settings.

Compiler receives image data and image settings.

It must write format label.


So we're providing formats description table and functions to

  * get settings from label
  * get label from settings
