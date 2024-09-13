#!/usr/bin/env ruby

require 'sinatra'
require 'watir'

def get_flashcards(flashcard_link)
  flashcard_link = flashcard_link.to_s
  @browser = Watir::Browser.new :chrome , headless: true
  @browser.goto (flashcard_link)

  sleep 2

  # close the cookie dialog or else it gets in the way of the flashcard flipping later
  @browser.element(class: 'osano-cm-close').click

  # remove the nav-control__menu element because it was getting in the way of clicking the flip button
  @browser.execute_script("
  const elements = document.getElementsByClassName('nav-control__menu');
  while(elements.length > 0){
      elements[0].parentNode.removeChild(elements[0]);
  }")

  # scroll to bottom to properly load in all flashcards
  @browser.execute_script("
    main = document.getElementsByTagName('main')[0];
    main.scrollIntoView(false);
  main.scrollIntoView(true);")

  sleep 0.1

  flashcards = []

  @browser.elements(class: 'flashcard').each do |flashcard|
    title = flashcard.element(class: 'flashcard-side__content--front').text
    title = title.sub('Click to flip', '')

    # flashcards have to be flipped for the data to be in the html
    flip_button = flashcard.element(class: 'flashcard-side-flip__btn--prefers-keyboard')
    @browser.execute_script('arguments[0].scrollIntoView();', flip_button)
    flip_button.click

    description = flashcard.element(class: 'flashcard-side--back').text
    description = description.sub('Back of card', '')

    flashcards << { title: title, description: description }
  end

  return flashcards
end

def to_omnisets(flashcards)
  exported_flashcards = ''

  flashcards.each do |flashcard|
    title = flashcard[:title]
    description = flashcard[:description]
    exported_flashcards += "#{title} ###{description} #### "
  end

  return exported_flashcards
end

get '/get_flashcards' do
  flashcard_url = URI(params['url'])
  
  unless flashcard_url.to_s.start_with? 'https://rise.articulate.com/share/'
    'URL must begin with "https://rise.articulate.com/share/"'
  end

  flashcards = get_flashcards(flashcard_url)
  puts flashcards
  exported_flashcards = to_omnisets(flashcards)
  puts exported_flashcards
  return exported_flashcards
end
