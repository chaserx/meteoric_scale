# client side

Measurements = new Meteor.Collection("measurements")

Meteor.autosubscribe ->
  Meteor.subscribe("measurements")

Template.hello.helpers
  skinny_term: ->
    skinny_terms = ['slim', 'tiny', 'thin', 'bones', 'Skeletor', 'twiggy']
    skinny_terms[Math.floor(Math.random()*skinny_terms.length)]

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
      userId: Meteor.userId()
      weight: $('.weight').val()
      created_at: Date.now()
    Measurements.insert data
    $(".start-hidden").toggle()

$ ->
  $(".container").on 'click', ".show-form", ->
    $(".start-hidden").toggle()

  $(".container").on 'click', ".hide-form", ->
    $(".start-hidden").toggle()

  toggleChevron = (e) ->
    $(e.target).prev(".panel-heading").find("span.indicator").toggleClass "glyphicon-chevron-down glyphicon-chevron-up"

  $("#accordion").on 'hidden.bs.collapse', toggleChevron

  $("#accordion").on 'shown.bs.collapse', toggleChevron

