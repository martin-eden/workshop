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
They are not supported.


We're providing functions to

  * get settings from label
  * get label from settings
  * get comment for human from label
