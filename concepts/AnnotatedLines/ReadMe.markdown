# Annotated lines format

Works with simple `key=some one-line string` format.

"Annotated lines" name is too generic as there are many ways to express
binding of one-line string to identifier. But for now that's the only
type of family I've implemented, so I won't qualify name any further.

## Details and background

It's part of ArduinoLibGenerator. I want to save results in
`library.properties` which looks like

  ```
  name=ArduinoJson
  version=7.0.3
  author=Benoit Blanchon <blog.benoitblanchon.fr>
  ```

So the general format is

  ```
  format:

    list(<annotated_line>, \n) [\n]

  annotated_line:

    any_char_except("=", \n)* "=" any_char_except(\n)
    ~~~~~~~~~~~~~~~~~~~~~~~~~     ~~~~~~~~~~~~~~~~~~~
             key                         value
  ```

### Internal data structures

`Load(Data: string): table, table` return two tables.

First is parsed data indexed by key: string key, string value.

Second is list of lines. Each line is an error/warning message about
problems encountered while parsing. If there are no problems, table
is empty.

There are two types of problems.

First is when we can't parse line. For example we cant parse `a`.
(But can parse `a=`.)

Second is when we overwriting already already parsed data. For example
`a=A<newline>a=B`. We can have only one value for key. In current
implementation we are keeping the last value.

Original order of keys is lost after Load(). I don't need it for
my current project.

`Save(Data: table [, Keys: table]): string` takes two arguments.

First is table with data to serialize. String keys, string values.
No newlines in keys or values and no `=` in keys please.
Or else we will blow with error().

Second optional parameter is a list with key names to serialize records
in that order. If it's absent we will create it internally. Current
implementation uses alphabetical order

Well, I think that's all that ought to be said about public interface.

-- Martin, 2024-02-13/2024-03-03
