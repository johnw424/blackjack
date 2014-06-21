class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    # Check if bust
    if @scores().length < 1
      if @scores()[0] > 21 and @scores()[1] > 21
        @trigger 'bust'
    else if @scores() > 21
      @trigger 'bust'

  stand: ->
    @trigger 'stand'

  playDealer: ->
    # Flip over first card
    @models[0].flip();
    # Keep hitting if score is under than 17
    while @scores() < 17
      @hit()
    # Dealer is done playing & didn't bust
    if @scores() <= 21
      @stand()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    # Pick smallest score, if both are over 21
    if hasAce
      if score > 11
        [score]
      else [score + 10]
    else [score]