module type FOO = 
  sig
    val foo: unit -> unit
  end

module Foo : FOO =
  struct
    let foo () = print_endline "foo"
  end

module Func (Base : FOO) =
  struct
    let foobar () = 
      Base.foo ();
      print_endline "bar"
  end

module FooBar = Func(Foo)

module Foo2 : FOO =
  struct
    let foo () = print_endline "Fooooo"
  end

module FooBar2 = Func(Foo2)
