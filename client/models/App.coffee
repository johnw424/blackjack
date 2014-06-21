#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    
    player = @get 'playerHand'
    dealer = @get 'dealerHand'
    
    player.on 'bust',  -> alert 'Dealer Wins'
    player.on 'stand', -> dealer.playDealer()
    dealer.on 'bust',  -> alert 'Player Wins'
    dealer.on 'stand', ->
      @trigger if player.scores() > dealer.scores()
        alert 'Player Wins'
      else if player.scores() < dealer.scores()
        alert 'Dealer Wins'
      else
        alert 'Push'