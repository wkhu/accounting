module.exports =
  list: (req, res) ->
    unless isEmpty req.query
      params = req.query
      console.log 'params', params
      id = params.id
      paginate = 
        page: params.page
        limit: params.limit

      order = params.order
      if order.indexOf('-') > -1
        console.log order, 'type:',typeof(order)
        if order.indexOf('category') > -1
          order = order + '.name'
        order = order + ' desc'
        order = order.replace('-','')
        console.log order.indexOf('category') > -1,'haha'
      

    console.log order,'order'
    Expense.find().where({sheet:id}).sort(order).paginate(paginate).populate('category')
    .exec (err, data) ->
      Expense.count()
      .exec (err, count) ->
        result = 
          data: data
          count: count
        res.serverError err if err
        res.json result

  create: (req, res) ->
    console.log 'create'
    data = req.body
    console.log data
    Expense.create data
    .exec (err, data) ->
      res.serverError err if err
      res.json data


  # update: (req, res) ->
  #   id = req.params.id  
  #   trans = req.body
  #   console.log trans, 'trans'
  #   Transaction.findOne(id)
  #   .exec (err, data) ->
  #     res.serverError err if err
  #     if data 
  #       hist = 
  #         date: Date.now()
  #         userId: if req.session.passport.hasOwnProperty('user') then req.session.passport.user.id else null
  #         amount: +trans.amount
  #         action: +trans.action

  #       switch data.type
  #         when 0
  #           data.balance -= +trans.amount
  #           if data.balance is 0
  #             data.status = 1
  #           # hist.account = trans.account
  #         when 1
  #           if +trans.action is 0
  #             hist.action = 0
  #             data.totalAmount += +trans.amount
  #           else if +trans.action is 1
  #             hist.action = 1
  #             data.totalAmount -= +trans.amount
  #         else
  #           console.log 'Type not listed'
  #       data.history.push hist
  #       console.log data

  #       Transaction.update(data.id, data)
  #       .exec (err, data) ->
  #         res.serverError err if err
  #         res.json data[0]

  delete: (req, res) ->
    id = req.params.id
    console.log id, 'id'
    Expense.destroy({id:id})
    .exec (err, data) ->
      res.serverError err if err
      res.json data[0] if data
