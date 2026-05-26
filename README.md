# Articulate Rise to Omnisets

This is an API that will scrape an Articulate Rise page for flashcards, and provide them in a format that Omnisets can import.

## Usage

To deploy, install the depencies: 

```sh
sudo apt install xvfb chromium chromium-driver
bundle install
```
and then run `ruby app.rb`. There's also a Dockerfile that should do it for you.

Then you can send a request to `localhost:4567/get_flashcards?url=https://rise.articulate.com/share/whatever`, which will return the formatted flashcards. No HTML output (yet).

## TODO

- [ ] JSON output that can be used as an intermediate for other platforms. This is how it should've been architected in the first place, and this project will probably end up being rewritten if I ever need to use it again.
- [ ] Fancy web frontend
