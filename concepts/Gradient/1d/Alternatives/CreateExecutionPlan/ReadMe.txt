Create execution plan

"Execution plan" is table with arguments for .CreatePixel().
Using it to feed .CreatePixel() determines order in which pixels
will be spawned.

More importantly, it determines "parents" for each pixel.
(We have two parents for pixel in 1-d. Spawning pixel interpolates
values of it's parents respecting their relative location. Also
it introduces distance-dependent "observation noise" when getting
pixel's value of parent.)

Let's consider line with 4 pixels. Border pixels are already set:

   1   2   3   4
  [L] [.] [.] [R]

We can create pixels at [2] and [3] as (2 1 4), (3 1 4). "L" and "R"
are spawning two children. Not much space for locality: each
child depends on the same parents.

(2 1 4) (3 2 4). "L" and "R" creates "2". "2" and "R" creates "3".
That's introduces some incest and desired locality.

For longer sequences we can use more sexy algorithms like
"spawn child at middle", "call ourselves with that child".
That's a classic binary tree.
