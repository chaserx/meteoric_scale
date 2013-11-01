# client side

Template.hello.greeting = ->
  "Welcome to Meteoric Scale."

Template.hello.events = "click input": ->
  console.log "You pressed the button"

Measurements = new Meteor.Collection("measurements")

Meteor.autosubscribe ->
  Meteor.subscribe("measurements")

Template.measurements_list.helpers
  measurements: ->
    Measurements.find {}

Template.new_measurement.events = "click .btn.save": ->
    data = weight: $('.weight').val()
    Measurements.insert data
