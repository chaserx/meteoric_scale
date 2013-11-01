# server side

Measurements = new Meteor.Collection("measurements")

Meteor.publish "measurements", ->
  Measurements.find {}

Measurements.allow
  insert: (doc) ->
    true

Meteor.startup = ->
  # code to run on server startup
