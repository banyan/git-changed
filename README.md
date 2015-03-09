# git-modified [![Circle CI](https://img.shields.io/circleci/project/banyan/git-modified.svg)](https://circleci.com/gh/banyan/git-modified) [![Rubygems](https://img.shields.io/gem/v/git-modified.svg)](https://rubygems.org/gems/git-modified)

A Git subcommand to list modified files in git commit or from current working tree

## Installation

```shell
$ gem install git-modified
```

## Usage

* Get modified files from current working tree if no argument is given

```shell
$ touch a.txt
$ git modified
a.txt
```

* Get modified files in git commit if argument is given

```shell
$ git modified fbb1185
actionpack/lib/action_dispatch/testing/integration.rb
```

## Tips

I often use [tig](https://github.com/jonas/tig) while I'm writing codes. No matter how I feel it's perfect, I would find mistakes soon when I check with tig.
Tig has `e` mode which opens file in editor, yet cursol should be on the files. `git-modified` is handy if you would like to open files with commit sets. It can be available with following tig bindings in `.tigrc`.

```tigrc
bind main K !<sh -c "vim -p $(git modified %(commit))"
bind diff K !<sh -c "vim -p $(git modified %(commit))"
bind log  K !<sh -c "vim -p $(git modified %(commit))"
```

In this example, I use vim (`-p` is opening files in tabs), but it can be modified to any editor, also binding key (`K`) as well.

![git-modified](https://cloud.githubusercontent.com/assets/19625/6544632/686b5ad6-c527-11e4-9dff-e655ff6fef8a.gif)

## License

Licensed under the [MIT license](http://banyan.mit-license.org/)
