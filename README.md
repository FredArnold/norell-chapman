# Source files
`Definitions` contains the code from the paper, `Exercises` contains my solutions for the exercises, `Stuff` is me trying things out.

# Surprises
## inv
```agda
data Image_∋_ {A B : Set}(f : A -> B) : B -> Set where
  im : (x : A) -> Image f ∋ f x

inv : {A B : Set}(f : A -> B)(y : B) -> Image f ∋ y -> A
inv f .(f x) (im x) = x
```
Agda infers ```agda y = f x``` from ```agda (im x) : Image f ∋ y```
