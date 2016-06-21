module.exports =
  show: (req, res) ->    
    id = req.params.id
    console.log req.params,'item show params'
    Item.findOne(id).populateAll()
    .exec (err, data) ->
      console.log err, data, 'Item'
      res.json data if data
      res.serverError err if err

  list: (req, res) ->
    console.log req.query,'item list query'
    id = req.session.passport.user.id
    unless isEmpty req.query
      params = req.query
      paginate = 
        page: params.page
        limit: params.limit
      order = params.order
      if order.indexOf('-') > -1
        order = order + ' desc'
        order = order.replace('-','')
    console.log id,'item curr user'
    Item.find().where({user:id}).sort(order).paginate(paginate).populate('unit')
    .exec (err, result) ->
      console.log err, result, 'items'
      Item.count()
      .exec (err, count) ->
        console.log err, count, 'item count'
        result = 
          data: result
          count: count
        res.serverError err if err
        res.json result

  create: (req, res) ->
    data = req.body
    data.user = req.session.passport.user.id
    if data.price && data.price.constructor isnt Array
      priceArr = []
      priceArr.push data.price
      data.price = priceArr
    console.log data, 'item create data'
    Item.create data
    .exec (err, data) ->
      console.log err, data,'item'
      res.serverError err if err
      res.json data


  update: (req, res) ->
    # id = req.params.id  
    item = req.body
    console.log item, 'item update data'
    Item.update(item.id, item)
    .exec (err, data) ->
      console.log err,data,'item'
      res.serverError err if err
      res.json data[0] if data
    # Item.find(id)
    # .exec (err, data) ->
    #   console.log err, data,'errdata'
    #   res.serverError err if err
    #   if data 
    #     data = item

    #     Item.update(data.id, data)
    #     .exec (err, data) ->
    #       res.serverError err if err
    #       res.json data[0]

  delete: (req, res) ->
    id = req.params.id
    console.log id, 'item delete id'
    Item.destroy({id:id})
    .exec (err, data) ->
      console.log err, data, 'item deleted'
      res.serverError err if err
      res.json data[0] if data
