--[[
  Constructs file tree in a memory. It is not linked with
  real files, just nodes separated to "directories" and "files".
  Also handles ".." and "/" in arguments.

  Main methods are
    add_file(<file_name_with_path>)
    add_directory(<directory_name_with_path>)

  Result is get_tree() structure.

  Tree node format:

    tree_node =
      {
        is_file = <boolean>,
        parent = <tree_node>,
        name = <string>,
        children =
          {
            [<name>] = <tree_node>,
          },
      }

  If you

    add_file('../../some_file')
    add_file('some_dir/some_other_file')

  then the structure will be like
    name = ''
    children =
      [''] =
        name = '',
        children =
          [''] =   // <-- self.tree, starting point
            name = ''
            parent = <>
            children =
              ['some_dir'] =
                name = 'some_dir'
                parent = <>
                children =
                  ['some_file'] =
                    name = 'some_file'
                    parent = <>
                    children = {}
          ['some_file'] =
            name = 'some_file',
            is_file = true,
            parent = <>,
            children = {}

  Note that
    (1) anonymous nodes saved under "" name
    (2) starting point (self.tree) never changes. To get root of
      the tree call get_tree().
]]

return
  {
    init = request('init'),
    add_file = request('add_file'),
    add_directory = request('add_directory'),
    get_tree = request('get_tree'),

    tree = {},
    parse_path_name = request('parse_path_name'),
  }
