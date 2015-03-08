# git-changed [![Circle CI](https://img.shields.io/circleci/project/banyan/git-changed.svg)](https://circleci.com/gh/banyan/git-changed) [![Rubygems](https://img.shields.io/gem/v/git-changed.svg)](https://rubygems.org/gems/git-changed)

A Git subcommand to list modified files in git commit

## Installation

```shell
$ gem install git-changed
```

## Usage

```shell
$ git changed # get latest commit of modified files if argument is not passed
activerecord/lib/active_record/transactions.rb
activerecord/test/cases/transactions_test.rb
```

```shell
$ git changed fbb1185
actionpack/lib/action_dispatch/testing/integration.rb
```

## Tips

I often use [tig](https://github.com/jonas/tig) while I'm writing codes. No matter how I feel it's perfect, I would find mistakes soon when I check with tig.
Tig has `e` mode which opens file in editor, yet cursol should be on the files. `git-changed` is handy if you would like to open files with commit sets. It can be available with following tig bindings in `.tigrc`.

```tigrc
bind main K !<sh -c "vim -p $(git changed %(commit))"
bind diff K !<sh -c "vim -p $(git changed %(commit))"
bind log  K !<sh -c "vim -p $(git changed %(commit))"
```

In this example, I use vim (`-p` is opening files in tabs), but it can be changed to any editor, also binding key (`K`) as well.

![git-changed](https://cloud.githubusercontent.com/assets/19625/6544632/686b5ad6-c527-11e4-9dff-e655ff6fef8a.gif)

## License

Licensed under the [MIT license](http://banyan.mit-license.org/)
