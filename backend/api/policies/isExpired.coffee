module.exports = (req, res, next) ->
  sails.models.action
    .findOne hash: req.param 'hash'
    .populate 'createdBy'
    .then (action) ->
      if action?
        expired = process.env.VALIDITY * 60000 + action.createdAt
        if Date.now() < expired
          return next new Error "action expired at #{new Date expired}"
        if action.createdBy.email != req.user.email
          return next new Error 'mismatch action owner'
        next()
      else
        next new Error 'action not found'
    .catch next
