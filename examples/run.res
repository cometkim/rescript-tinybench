let bench =
  Bench.make(~time=100.0, ())
  ->Bench.add("switch 1", () => {
    let a = ref(1)
    let b = ref(2)
    let c = a.contents
    a := b.contents
    b := c
  })
  ->Bench.add("switch 2", () => {
    let a = ref(1)
    let b = ref(10)
    a := b.contents + a.contents
    b := a.contents - b.contents
    a := b.contents - a.contents
  })

let run = async () => {
  await bench.run(.)

  open Belt
  bench.tasks->Array.forEach(task => {
    switch task {
    | {name, result: Some(result)} => {
        Js.log(`Task name: ${name}`)
        Js.log(`Average Time (ps): ${Float.toString(result.mean *. 1000.)}`)
        Js.log(`Variance (ps): ${Float.toString(result.variance *. 1000.)}`)
        Js.log("")
      }

    | {name} => Js.log(`Task "${name}" has no results yet`)
    }
  })
}

run()->ignore
