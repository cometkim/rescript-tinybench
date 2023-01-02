type result = {
  error: option<{.}>,
  totalTime: float,
  min: float,
  max: float,
  hz: float,
  period: float,
  samples: array<float>,
  mean: float,
  variance: float,
  sd: float,
  sem: float,
  df: float,
  critical: float,
  moe: float,
  rme: float,
  p75: float,
  p99: float,
  p995: float,
  p999: float,
}

type t = {
  name: string,
  result: option<result>,
}

type fn = unit => unit

@get
external getFn: t => fn = "fn"

type asyncFn = unit => Js.Promise2.t<unit>

@get
external getAsyncFn: t => asyncFn = "fn"
