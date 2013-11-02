# client side

Measurements = new Meteor.Collection("measurements")

Meteor.autosubscribe ->
  Meteor.subscribe("measurements")

Template.hello.helpers
  skinny_term: ->
    skinny_terms = ['slim', 'tiny', 'thin', 'bones', 'Skeletor', 'twiggy']
    # from: http://coffeescriptcookbook.com/chapters/arrays/shuffling-array-elements
    shuffle = (skinny_terms) ->
    i = skinny_terms.length
    while --i > 0
      # ~~ is a common optimization for Math.floor
      j = ~~(Math.random() * (i + 1))
      t = skinny_terms[j]
      skinny_terms[j] = skinny_terms[i]
      skinny_terms[i] = t
    skinny_terms[0]

Template.measurements_list.helpers
  measurements: ->
    Measurements.find {}, {sort: {created_at: -1}}

  pretty_date_format: ->
    measurement = @
    moment(measurement.created_at).format('MMMM Do YYYY, h:mm:ss a')

Template.measurements_list.events
  "click .btn.remove_measurement": (event) ->
    measurement = @
    $(event.target).closest('tr').find('td').fadeOut 1000, ->
      # NOTE(chase): not sure why I had to use ._id instead of .id, but works.
      Measurements.remove measurement._id

Template.new_measurement.events
  "click .btn.save": (event) ->
    data =
      weight: $('.weight').val()
      created_at: Date.now()
    Measurements.insert data
