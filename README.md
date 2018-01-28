# Source files
`Definitions` contains the code from the paper, `Exercises` contains my solutions to the exercises, `Stuff` is me trying things out.

# Surprises
## inv
```agda
data Image_∋_ {A B : Set}(f : A -> B) : B -> Set where
  im : (x : A) -> Image f ∋ f x

inv : {A B : Set}(f : A -> B)(y : B) -> Image f ∋ y -> A
inv f .(f x) (im x) = x
```
The pattern matching of inv contains a function application! Somehow, this is much harder for me to accept than a simple value appearing twice in pattern matching (and being dotted).
