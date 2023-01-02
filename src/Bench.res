type t = {
  run: (. unit) => Js.Promise2.t<unit>,
  tasks: array<Task.t>,
}

type options

%%private(
  @obj
  external makeOptions: (
    ~time: option<float>=?,
    ~iterations: option<int>=?,
    ~now: option<unit => float>=?,
    ~warmupTime: option<float>=?,
    ~warmupIterations: option<int>=?,
    unit,
  ) => options = ""

  @new @module("tinybench")
  external make: options => t = "Bench"
)

let make = (~time=?, ~iterations=?, ~now=?, ~warmupTime=?, ~warmupIterations=?, ()) => {
  makeOptions(~time, ~iterations, ~now, ~warmupTime, ~warmupIterations, ())->make
}

@send
external add: (t, string, unit => unit) => t = "add"

@send
external addAsync: (t, string, unit => Js.Promise2.t<unit>) => t = "add"

@send
external run: t => Js.Promise.t<unit> = "run"

@get
external tasks: t => array<Task.t> = "tasks"
