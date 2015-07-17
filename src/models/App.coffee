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

    if(window.player.scores() > 21) {
      alert("You lost!")
    } else {
      
    }