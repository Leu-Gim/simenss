{.compile: "simenss.c".}

type
  PBlockQueue = ref TBlockQueue
  TBlockQueue = object
    n: int
  TDisplay = object
    pipe: PBlockQueue
proc address(d: TDisplay, n: int) = discard

proc write*(bq : PBlockQueue, fmtstr : cstring) : void {.cdecl, importc: "bqueue_write", varargs.}

template write*(d : var TDisplay, node : int, fmtstr: cstring, args : varargs[expr]) =
  d.address(node)
  d.pipe.write(fmtstr, args)

var d: TDisplay
d.pipe.new
d.write(2, "%d - %d", 3, 4)
