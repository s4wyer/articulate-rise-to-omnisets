# Articulate Rise to Omnisets

This is an API that will scrape an Articulate Rise page for flashcards, and provide them in a format that Omnisets can import.

## Usage

To deploy, install the depencies: 

```sh
sudo apt install xvfb chromium chromium-driver
bundle install
```
and then run `ruby app.rb`. There's also a Dockerfile that should do it for you.

Then you can send a request to "/get_flashcards?url=https://rise.articulate.com/share/whatever", which will return the formatted flashcards. No HTML or JSON.

## TODO

- [ ] JSON output that can be adapted to any format instead of just Omnisets. This is how it should have been built in the first place but the project started out as a simple script that I decided to turn into an API. 
