class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="./img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    if @model.get 'revealed' then @template = _.template '<img src="./img/cards/<%= rankName %>-<%= suitName %>.png">'
    else @template = _.template '<img src="./img/card-back.png">'

    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

