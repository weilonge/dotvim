## Notes for vim-projections

This is a digest from `vim-projections` plugin's readme. If you would like to
use `frontend.projections.json`, copy to your project folder as the name
`.projections.json`.

### Global and per project projection definitions

In the above example, we used the global `g:projectionist_heuristics` to
declare projections based on requirements in the root directory.  If that's
not flexible enough, you can use the autocommand based API, or create a
`.projections.json` in the root of the project.

### Navigation commands

Navigation commands encapsulate editing filenames matching certain patterns.
Here are some examples for this very project:

    {
      "plugin/*.vim": {"type": "plugin"},
      "autoload/*.vim": {"type": "autoload"},
      "doc/*.txt": {"type": "doc"},
      "README.markdown": {"type": "doc"}
    }

With these in place, you could use `:Eplugin projectionist` to edit
`plugin/projectionist.vim` and `:Edoc projectionist` to edit
`doc/projectionist.txt`.  If no argument is given, it will edit an alternate
file of that type (see below) or a projection without a glob.  So in this
example `:Edoc` would default to editing `README.markdown`.

The `E` stands for `edit`.  You also get `S`, `V`, and `T` variants that
`split`, `vsplit`, and `tabedit`.

Tab complete is smart.  Not quite "fuzzy finder" smart but smart nonetheless.
(On that note, fuzzy finders are great, but I prefer the navigation command
approach when there are multiple categories of similarly named files.)

### Alternate files

Projectionist provides `:A`, `:AS`, `:AV`, and `:AT` to jump to an "alternate"
file, based on ye olde convention originally established in [a.vim][].  Here's
an example configuration for Maven that allows you to jump between the
implementation and test:

    {
      "src/main/java/*.java": {"alternate": "src/test/java/{}.java"},
      "src/test/java/*.java": {"alternate": "src/main/java/{}.java"}
    }

In addition, the navigation commands (like `:Eplugin` above) will search
alternates when no argument is given to edit a related file of that type.

Bonus feature: `:A {filename}` edits a file relative to the root of the
project.

[a.vim]: http://www.vim.org/scripts/script.php?script_id=31

### Buffer configuration

Check out these examples for a minimal Ruby project:

    {
      "*": {"make": "rake"},
      "spec/*_spec.rb": {"dispatch": "rspec {file}"}
    }

That second one sets the default for [dispatch.vim][].  Plugins can use
projections for their own configuration.

[dispatch.vim]: https://github.com/tpope/vim-dispatch
