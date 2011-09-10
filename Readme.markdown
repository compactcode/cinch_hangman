Grab the gem.

```
gem 'cinch_hangman'
```

And add hangman to your cinch bot as a plugin:

```ruby
require 'cinch_hangman'

bot = Cinch::Bot.new do
  configure do |c|
    c.server          = "irc.freenode.net"
    c.plugins.plugins = [
      Cinch::Plugins::Hangman
    ]
  end
end
```

To start a new game send a private message to your bot:

```
compactcode: !hang new #channel secret
```

The game will be started in the specified channel.

```
bot: (s_____) hangman started.
compactcode: !hang guess s
bot: (s_____) 6 guesses left.
```

In order to minimize chatter players may guess multiple letters at a time.

```
compactcode: !hang guess et
bot: (se__et) 6 guesses left.
```
