class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    card = @deck.pop()
    @add(card)
    if this.getBestHand() > 21 then @trigger('lose', @)
    return card

  stand: -> 
    @trigger('stand', @)


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  getBestHand: ->
    scoreArray = @scores()
    score0 = scoreArray[0]
    score1 = scoreArray[1]
    if score0 <= 21 and score1 <= 21
      if score0 > score1 then score0 else score1
    else
      if score0 < score1 then score0 else score1
