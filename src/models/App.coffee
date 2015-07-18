# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: -> 
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get ('playerHand')
    `
    window.player = playerHand;
    `
    @get ('playerHand') 
      .on 'stand', () => 
        dealerHand = @get ('dealerHand')
        dealerHand.first().flip()
        `
        console.log(dealerHand);
        console.log(this.get('playerHand'));
        window.dealer = dealerHand;
        `
        dealerHand
        
        dealerBestHand = dealerHand.getBestHand()
        playerBestHand = playerHand.getBestHand()
        if dealerBestHand == playerBestHand then @gameEnd('dealer')
        if dealerBestHand <= 21 and playerBestHand <= 21
          if dealerBestHand > playerBestHand then @gameEnd('dealer') else @gameEnd('player')
        else
          if dealerBestHand < playerBestHand then @gameEnd('dealer') else @gameEnd('player')

    @get ('playerHand')
      .on 'lose', () =>
        @gameEnd('dealer')