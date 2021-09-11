# Vim Configurations

## Installation:

```console
$ git clone git://github.com/weilonge/dotvim.git ~/.vim
```

Launch vim and apply `:PlugInstall` to install plugins. Or apply the following command in console to install or update plugins:

### Install Plugins:

```console
$ vim +PlugUpgrade +PlugInstall +qa
```

### Update Plugins:

```console
$ vim +PlugUpgrade +PlugUpdate +qa
```

### Optional:

Apply the command to install coc related plugins:
```console
$ vim -c ':CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css'
```

Apply the command to update coc related plugins:
```console
$ vim +CocUpdate
```

