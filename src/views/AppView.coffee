class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="newgame-button">Play again</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .newgame-button': -> 
      deck = @model.get 'deck' 
      @model.get 'playerHand' 
        .reset()
        .add(deck.pop())
        .add(deck.pop())
      @model.get 'dealerHand' 
        .reset()
        .add(deck.pop().flip())
        .add(deck.pop())
      @render()


  initialize: ->
    @render()
    @model.gameEnd = (winner) ->
      alert ("#{winner} won")

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
