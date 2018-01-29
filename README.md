# Source files
`Definitions` contains the code from the paper, `Exercises` contains my solutions to the exercises, `Stuff` is me trying things out.

# Surprises
## inv
```agda
inv : {A B : Set}(f : A -> B)(y : B) -> Image f ∋ y -> A
inv f .(f x) (im x) = x
```
The pattern matching of inv contains a function application! Somehow, this is much harder for me to accept than a simple value appearing twice in pattern matching (and being dotted).

## lookup
```agda
lookup : {A : Set}(xs : List A)(n : Nat) ->
         isTrue (n < length xs) -> A
lookup []        n       ()
lookup (x :: xs) zero    p = x
lookup (x :: xs) (suc n) p = lookup xs n p
```
In the recursive case, `p : isTrue (suc n < length (x :: xs))` gets passed to `lookup` as a proof of `isTrue (n < length xs)`. I was surprised that proofs could be reused like this, but looking more closely, `isTrue (suc n < length (x :: xs))` and `isTrue (n < length xs)` share their only inhabitant, `trivial`. Rewriting the definition of `lookup` as
```agda
lookup : {A : Set}(xs : List A)(n : Nat) ->
         isTrue (n < length xs) -> A
lookup []        n       ()
lookup (x :: xs) zero    trivial = x
lookup (x :: xs) (suc n) trivial = lookup xs n trivial
```
makes it a bit more obvious.

I have to admit, coming from Haskell, dummy values that exist to enable type level computations are still a bit foreign to me.

## lem-plus-zero
```agda
lem-plus-zero : (n : Nat) -> n + zero == n
lem-plus-zero zero = refl
lem-plus-zero (suc n) with n + zero | lem-plus-zero n
... | .n | refl = refl
```
Damn, I would not have found that myself.
