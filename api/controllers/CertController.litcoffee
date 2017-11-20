    actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

    module.exports =
      sign: (req, res) ->
        values = actionUtil.parseValues req
        sails.models.cert
          .createCert
            csr: values.csr
            createdBy: req.user.email
          .then res.created
          .catch res.negotitate
      revoke: (req, res) ->
        values = actionUtil.parseValues req
        pk = actionUtil.requirePk req
        Model = actionUtil.parseModel req
        Model
          .findOne id: pk
          .then (cert) ->
            if req.user.email == cert.createdBy or req.user.email in sails.config.admin
              Model
                .update id: pk,
                  revokedAt: new Date()
                  revokedReason: values.revokedReason
                .toPromise()
            else
              res.forbidden "#{req.user.email} is forbidden to revoke specified certificate"
          .then (cert) ->
            res.ok cert
          .catch sails.log.error
