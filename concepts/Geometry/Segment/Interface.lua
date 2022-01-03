return
  {
    GetStart = request('GetStart'),
    MoveStart = request('MoveStart'),
    SetStart = request('SetStart'),

    GetLength = request('GetLength'),

    GetFinish = request('GetFinish'),
    MoveFinish = request('MoveFinish'),
    SetFinish = request('SetFinish'),

    -- private
    StartPoint = new(request('!.concepts.Geometry.Point.Interface')),
    FinishPoint = new(request('!.concepts.Geometry.Point.Interface')),
  }
