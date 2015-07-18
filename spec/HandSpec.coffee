assert = chai.assert

# DeckMock class for Hand Class Testing
class DeckMock
  pop: -> new Card
    rank: 4
    suit: 1



describe 'Hand', ->
  ace = null
  king = null
  ace2 = null
  king2 = null
  deckMock = null

  beforeEach ->
    deckMock = new DeckMock

    ace = new Card
      rank: 1
      suit: 1
    king = new Card
      rank: 0
      suit: 1
    ace2 = new Card
      rank: 1
      suit: 2
    king2 = new Card
      rank: 0
      suit: 2

  describe 'get best hand', ->
    it 'If we have an Ace and a King it should return 21', ->
      hand1 = new Hand([ace,king])
      assert.strictEqual hand1.getBestHand(), 21
    it 'If we have 2 Aces it should return 12', ->
      hand2 = new Hand([ace,ace2])
      assert.strictEqual hand2.getBestHand(), 12
    it 'If we have 2 Kings it should return 20', ->
      hand3 = new Hand([king,king2])
      assert.strictEqual hand3.getBestHand(), 20
  describe 'hand has ace', ->
    it 'Should return true if there\'s an ace in the hand', ->
      hand4 = new Hand([ace,king])
      assert.strictEqual hand4.hasAce(), true
    it 'Should return false if there\'s no ace in the hand', ->
      hand4 = new Hand([king2,king])
      assert.strictEqual hand4.hasAce(), false
    it 'Should return true if there\'re two aces in the hand', ->
      hand4 = new Hand([ace, ace2])
      assert.strictEqual hand4.hasAce(), true
  describe 'Check minScore', ->
    it 'Should return 10 if the ace is not revealed', ->
      hand4 = new Hand([ace,king])
      ace.flip()
      assert.strictEqual hand4.minScore(), 10
    it 'Should return 0 if the both cards are not revealed', ->
      hand4 = new Hand([ace,king])
      ace.flip()
      king.flip()
      assert.strictEqual hand4.minScore(), 0
  describe 'Check score', ->
    it 'Should return 11 & 21 if there is an ace and a king', ->
      hand4 = new Hand([ace,king])
      assert.equal hand4.scores()[0], 11
      assert.equal hand4.scores()[1], 21
    it 'Should return 20 & 20 if there are two kings', ->
      hand4 = new Hand([king2,king])
      assert.equal hand4.scores()[0], 20
      assert.equal hand4.scores()[1], 20
    it 'Should return 2 & 12 if there are two aces', ->
      hand4 = new Hand([ace, ace2])
      assert.equal hand4.scores()[0], 2
      assert.equal hand4.scores()[1], 12
  describe 'Trigger stand', ->
    it 'Should trigger stand if stand is called', ->
      hand = new Hand([ace,ace2])
      flag = false
      hand.on 'stand', -> flag = true 
      hand.stand()
      assert.equal flag, true
  describe 'Call Hit', ->
    it 'hit should add a new card', ->
      hand = new Hand([ace,ace2], deckMock)
      hand.hit()
      assert.strictEqual hand.last().get('rank'), 4
    it 'should trigger lose', ->
      hand = new Hand([king,king2], deckMock)
      flag = false
      hand.on 'lose', -> flag = true
      hand.hit()
      assert.strictEqual flag, true
