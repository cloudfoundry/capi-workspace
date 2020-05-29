scriptencoding utf-8

let g:ale_yaml_yamllint_options = '-d relaxed'

let g:leader_key_map.a = {
      \ 'name': '+tabs',
      \ 'n': [':tabnew',            'Create new tab'],
      \ ',': [':tabprevious',       'Switch to tab left of current'],
      \ '.': [':tabnext',           'Switch to tab right of current'],
      \ '1': ['1gt',             'Switch to tab 1'],
      \ '2': ['2gt',             'Switch to tab 2'],
      \ '3': ['3gt',             'Switch to tab 3'],
      \ '4': ['4gt',             'Switch to tab 4'],
      \ '5': ['5gt',             'Switch to tab 5'],
      \ }
