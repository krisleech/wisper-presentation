# Adding Events to Ruby Presenation

## Usage

### View the Presentation

```
./view
```

`r` reveal the next fold

When viewing the presentation folds are not visible.

#### Edit the Presentation

To create fold visually select a number of lines and then `zf`.

When editing presentations folds are visible.

`:w` write the buffer and state of folds

## Syntax Highlighting

```
@begin=haml@
%h2 #{@conference.name}
@end=haml@

@begin=ruby@
def foobar
end
@end=ruby@
```
