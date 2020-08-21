local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local rep = handy.rep
local cho = handy.cho
local list = handy.list
local opt_rep = handy.opt_rep

local common_prefix =
  {
    'create',
    opt('temporary'),
    'table',
    opt('if', 'not', 'exists'),
    name,
  }

local data_type =
  {
    cho(
      {
        'bit',
        opt('(', int, ')'),
      },
      {
        cho(
          'tinyint',
          'mediumint',
          'int',
          'integer',
          'bigint'
        )
        opt('(', int, ')'),
        opt('unsigned'),
        opt('zerofill'),
      },
      {
        cho(
          'real',
          'double',
          'float'
        )
        opt('(', int, ',', int, ')'),
        opt('unsigned'),
        opt('zerofill'),
      },
      {
        cho(
          'decimal',
          'numeric'
        )
        opt('(', int, opt(',', int, ')')),
        opt('unsigned'),
        opt('zerofill'),
      },
      'date',
      {
        cho(
          'time',
          'timestamp',
          'datetime'
        ),
        opt('(', str, ')'),
      },
      'year',
      {
        cho(
          'char',
          'varchar',
          'text',
        ),
        opt('(', int, ')'),
        opt('character', 'set', name),
        opt('collate', name),
      },
      {
        cho(
          'tinytext',
          'mediumtext',
          'longtext',
          {
            cho('enum', 'set'),
            '(', list(value, ','), ')',
          }
        ),
        opt('character', 'set', name),
        opt('collate', name),
      },
      {
        'binary',
        opt('(', int, ')'),
      },
      {
        'varbinary', '(', int, ')',
      },
      {
        'blob',
        opt('(', int, ')'),
      },
      'tinyblob',
      'mediumblob',
      'longblob',
      'json',
      spatial_type,
    ),
  }

local reference_option =
  {
    cho(
      'restrict',
      'cascade',
      {'set', 'null'},
      {'no', 'action'},
      {'set', 'default'},
    ),
  }

local reference_definition =
  {
    'references', name,
    '(', list(index_field_name, ','), ')',
    opt('match', cho('full', 'partial', 'simple')),
    opt('on', cho('delete', 'update'), reference_option),
  }

local field_def =
  {
    cho(
      {
        data_type,
        opt(cho({'not', 'null'}, 'null')),
        opt('default', value),
        opt('auto_increment'),
        opt('unique', opt('key')),
        opt('primary', opt('key')),
        opt('comment', "'", str, "'"),
        opt('column_format', cho('fixed', 'dynamic', 'default')),
        opt('storage', cho('disk', 'memory', 'default')),
        opt(reference_definition),
      },
      {
        data_type,
        opt('generated', 'always'),
        'as',
        '(', expression, ')',
        opt(cho('virtual', 'stored')),
        opt(cho({'not', 'null'}, 'null')),
        opt('unique', opt('key')),
        opt(opt('primary'), 'key'),
        opt('comment', "'", str, "'"),
      }
    ),
  }

local index_field_name =
  {
    field_name,
    opt('(', int, ')'),
    opt(cho('asc', 'desc')),
  }

local index_type =
  {
   'using', cho('btree', 'hash'),
  }

local opt_eq = opt('=')

local index_option =
  {
    cho(
      {'key_block_size', opt_eq, value},
      index_type,
      {'with', 'parser', name},
      {'comment', "'", str, "'"},
    ),
  }

local create_definition =
  {
    cho(
      {
        field_name,
        field_def,
      },
      {
        opt('constraint', opt(name)),
        'primary', 'key', opt(index_type),
        '(', list(index_field_name, ','), ')',
        opt_rep(index_option),
      },
      {
        cho('index', 'key'), opt(name),
        opt(index_type),
        '(', list(index_field_name ','), ')',
        opt_rep(index_option),
      },
      {
        opt('constraint', opt(name)),
        'unique', opt(cho('index', 'key')), opt(name),
        opt(index_type),
        '(', list(index_field_name, ','), ')',
        opt_rep(index_option),
      },
      {
        cho('fulltext', 'spatial'), opt(cho('index', 'key')), opt(name),
        '(', list(index_field_name, ','), ')',
        opt_rep(index_option),
      },
      {
        opt('constraint', opt(name)),
        'foreign', 'key', opt(name),
        '(', list(index_field_name, ','), ')',
        reference_definition,
      },
      {
        'check', '(', expression, ')',
      },
    ),
  }

local table_option =
  {
    cho(
      {'auto_increment', opt_eq, value},
      {'avg_row_length', opt_eq, value},
      {opt('default'), 'character', 'set', opt_eq, name},
      {'checksum', opt_eq, cho('0', '1')},
      {opt('default'), 'collate', opt_eq, name},
      {'comment', opt_eq, "'", str, "'"},
      {'compression', opt_eq, cho("'zlib'", "'lz4'", "'none'")},
      {'connection', opt_eq, "'", str, "'"},
      {cho('data', 'index'), 'directory', opt_eq, "'", str, "'"},
      {'delay_key_write', opt_eq, cho('0', '1')},
      {'encryption', opt_eq, cho("'y'", "'n'")},
      {'engine', opt_eq, str},
      {'insert_method', opt_eq, cho('no', 'first', 'last')},
      {'key_block_size', opt_eq, value},
      {'max_rows', opt_eq, value},
      {'min_rows', opt_eq, value},
      {'pack_keys', opt_eq, cho('0', '1', 'default')},
      {'password', opt_eq, "'", str, "'"},
      {
        'row_format',
        opt_eq,
        cho(
          'default',
          'dynamic',
          'fixed',
          'compressed',
          'redundant',
          'compact',
        ),
      },
      {'stats_auto_recalc', opt_eq, cho('0', '1', 'default')},
      {'stats_persistent', opt_eq, cho('0', '1', 'default')},
      {'stats_sample_pages', opt_eq, value},
      {'tablespace', name, opt('storage', cho('disk', 'memory', 'default'))},
      {'stats_auto_recalc', opt_eq, cho('0', '1', 'default')},
      {'union', opt_eq, '(', list(name, ','), ')'},
    ),
  }

local table_options =
  {
    list(table_option, ','),
  }

local subpartition_definition =
  {
    'subpartition', name,
    opt(opt('storage'), 'engine', opt_eq, name),
    opt(comment, opt_eq, "'", str, "'"),
    opt('data', 'directory', opt_eq, "'", str, "'"),
    opt('index', 'directory', opt_eq, "'", str, "'"),
    opt('max_rows', opt_eq, value),
    opt('min_rows', opt_eq, value),
    opt('tablespace', opt_eq, name),
  }

local partition_definition =
  {
    'partition', name,
    opt(
      'values',
      cho(
        {
          'less', 'than',
          cho(
            {
              '(',
              cho(expression, list(value, ',')),
              ')',
            },
            'maxvalue'
          ),
        },
        {
          'in',
          '(',
          list(value, ','),
          ')',
        }
      )
    ),
    opt(opt('storage'), 'engine', opt_eq, name),
    opt(comment, opt_eq, "'", str, "'"),
    opt('data', 'directory', opt_eq, "'", str, "'"),
    opt('index', 'directory', opt_eq, "'", str, "'"),
    opt('max_rows', opt_eq, value),
    opt('min_rows', opt_eq, value),
    opt('tablespace', opt_eq, name),
    opt(list(subpartition_definition, ',')),
  }

local partition_options =
  {
    'partition', 'by',
    cho(
      {
        opt('linear'), 'hash',
        '(', expression, ')',
      },
      {
        opt('linear'), 'key',
        opt('algorithm', '=', cho('1', '2'))},
        '(', list(field_name, ','), ')',
      },
      {
        cho('range', 'list'),
        cho(
          {'(', expression, ')'},
          {
            'columns',
            '(', list(field_name, ','), ')',
          },
        ),
      },
    ),
    opt('partitions', int),
    opt(
      'subpartition', 'by',
      cho(
        {
          opt('linear'), 'hash',
          '(', expression, ')',
        },
        {
          opt('linear'), 'key',
          opt('algorithm', '=', cho('1', '2'))},
          '(', list(field_name, ','), ')',
        },
      ),
      opt('subpartitions', int),
    ),
    opt('(', list(partition_definition, ','), ')'),
  }

local create_straight =
  {
    common_prefix,
    '(',
    list(create_definition, ','),
    ')',
    opt(table_options),
    opt(partition_options),
  }

local create_query =
  {
    common_prefix,
    opt(
      '(',
      list(create_definition, ','),
      ')'
    ),
    opt(table_options),
    opt(partition_options),
    opt(cho('ignore', 'replace')),
    opt('as'),
    query_expression,
  }

local create_like =
  {
    common_prefix,
    cho(
      {'(', 'like', name, ')'},
      {'like', name},
    ),
  }

local result =
  cho(create_straight, create_query, create_like)

return result
