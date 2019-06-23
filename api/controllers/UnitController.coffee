module.exports =
  list: (req, res) ->
    console.log req.query,'unit list query'
    unless isEmpty req.query
      params = req.query
      paginate = 
        page: params.page
        limit: params.limit
      order = params.order
      if order.indexOf('-') > -1
        order = order + ' desc'
        order = order.replace('-','')

    Unit.find().sort(order).paginate(paginate)
    .exec (err, result) ->
      console.log err, result, 'units'
      Unit.count()
      .exec (err, count) ->
        console.log err, count, 'units count'
        result = 
          data: result
          count: count
        res.serverError err if err
        res.json result

  create: (req, res) ->
    data = req.body
    console.log data, 'unit create data'
    data.unitName = data.unitName.toUpperCase()
    console.log data.unitName,'caps'
    Unit.create data
    .exec (err, data) ->
      console.log err,data,'unit'
      res.serverError err if err
      res.json data

  update: (req, res) ->
    # id = req.params.id  
    unit = req.body
    console.log unit, 'unit update data'
    Unit.update(unit.id, unit)
    .exec (err, data) ->
      console.log err, data, 'unit'
      res.serverError err if err
      res.json data[0] if data
    # Unit.findOne(id)
    # .exec (err, data) ->
    #   console.log err, data,'errdata'
    #   res.serverError err if err
      # data.unitName = unit.unitName
      # data.save (err,s) ->
      #   console.log err, s, 'updated'
      # Unit.update(data.id, data)
      # .exec (err, data) ->
      #   res.serverError err if err
      #   res.json data[0]

  delete: (req, res) ->
    id = req.params.id
    console.log id, 'unit delete id'
    Unit.destroy({id:id})
    .exec (err, data) ->
      console.log err, data,'unit deleted'
      res.serverError err if err
      res.json data[0] if data
