# server side

Measurements = new Meteor.Collection("measurements")

Meteor.publish "measurements", ->
  Measurements.find {userId: this.userId}

Measurements.allow
  insert: (userId, measurement) ->
    measurement.userId == userId
  remove: (userId, measurement) ->
    measurement.userId == userId

Meteor.startup = ->
  # code to run on server startup
