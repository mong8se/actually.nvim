# Actually.nvim

![A cat saying "umm... actually" and pushing up its nerd glasses](https://media.giphy.com/media/RMwZypp489fuGBI0Ti/giphy.gif)

## What is it?

(Shamelessly stolen and rewritten in|Ported to) lua from:
[EinfachToll/DidYouMean](https://github.com/EinfachToll/DidYouMean)

## What it do?

Let's say you want to open `that_thing.txt` so you happily type ...

```bash

> nvim somedir/th<TAB><CR>

```

But! You forgot about the existence of `the_other_thing.md` so
after the `<TAB>` the shell prompted you to disambiguate ... but you
already swiftly hit `<CR>` so you've just opened a new file
called `somedir/th` ... womp womp

But wait! With this plugin you'll get a prompt asking you if you
actually want to choose `that_thing` or `the_other_thing`.

But don't worry, if you really intended to make a file called `th`,
you can cancel, because you actually knew all along.

![a demo gif using actually.nvim](./doc/actually.gif)

## How I install?

The regular way.

```lua
packer use "mong8se/actually.nvim"
```

## How I configure

Ain't none.

## Can I dress it?

You mean
[stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) ?
Hold on let me go check ...

## Well?

... ya totally worked

TODO: Cleanup
TODO: Windows Operating System!?
