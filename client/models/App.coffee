#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    
    player = @get 'playerHand'
    dealer = @get 'dealerHand'
    
    player.on 'bust',  -> @trigger 'win:dealer'
    player.on 'stand', -> dealer.playDealer()
    dealer.on 'bust',  -> @trigger 'win:player'
    dealer.on 'stand', ->
      @trigger if player.scores() > dealer.scores()
        'win:player'
      else if player.scores() < dealer.scores()
        'win:dealer'
      else
        'push'
