" definitions without {}
autocmd BufEnter * syn match texMathSymbol '\\mathbb A' contained conceal cchar=𝔸
autocmd BufEnter * syn match texMathSymbol '\\mathbb B' contained conceal cchar=𝔹
autocmd BufEnter * syn match texMathSymbol '\\mathbb C' contained conceal cchar=ℂ
autocmd BufEnter * syn match texMathSymbol '\\mathbb D' contained conceal cchar=𝔻
autocmd BufEnter * syn match texMathSymbol '\\mathbb E' contained conceal cchar=𝔼
autocmd BufEnter * syn match texMathSymbol '\\mathbb F' contained conceal cchar=𝔽
autocmd BufEnter * syn match texMathSymbol '\\mathbb G' contained conceal cchar=𝔾
autocmd BufEnter * syn match texMathSymbol '\\mathbb H' contained conceal cchar=ℍ
autocmd BufEnter * syn match texMathSymbol '\\mathbb I' contained conceal cchar=𝕀
autocmd BufEnter * syn match texMathSymbol '\\mathbb J' contained conceal cchar=𝕁
autocmd BufEnter * syn match texMathSymbol '\\mathbb K' contained conceal cchar=𝕂
autocmd BufEnter * syn match texMathSymbol '\\mathbb L' contained conceal cchar=𝕃
autocmd BufEnter * syn match texMathSymbol '\\mathbb M' contained conceal cchar=𝕄
autocmd BufEnter * syn match texMathSymbol '\\mathbb N' contained conceal cchar=ℕ
autocmd BufEnter * syn match texMathSymbol '\\mathbb O' contained conceal cchar=𝕆
autocmd BufEnter * syn match texMathSymbol '\\mathbb P' contained conceal cchar=ℙ
autocmd BufEnter * syn match texMathSymbol '\\mathbb Q' contained conceal cchar=ℚ
autocmd BufEnter * syn match texMathSymbol '\\mathbb R' contained conceal cchar=ℝ
autocmd BufEnter * syn match texMathSymbol '\\mathbb S' contained conceal cchar=𝕊
autocmd BufEnter * syn match texMathSymbol '\\mathbb T' contained conceal cchar=𝕋
autocmd BufEnter * syn match texMathSymbol '\\mathbb U' contained conceal cchar=𝕌
autocmd BufEnter * syn match texMathSymbol '\\mathbb V' contained conceal cchar=𝕍
autocmd BufEnter * syn match texMathSymbol '\\mathbb W' contained conceal cchar=𝕎
autocmd BufEnter * syn match texMathSymbol '\\mathbb X' contained conceal cchar=𝕏
autocmd BufEnter * syn match texMathSymbol '\\mathbb Y' contained conceal cchar=𝕐
autocmd BufEnter * syn match texMathSymbol '\\mathbb Z' contained conceal cchar=ℤ
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) A' contained conceal cchar=𝓐
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) B' contained conceal cchar=𝓑
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) C' contained conceal cchar=𝓒
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) D' contained conceal cchar=𝓓
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) E' contained conceal cchar=𝓔
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) F' contained conceal cchar=𝓕
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) G' contained conceal cchar=𝓖
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) H' contained conceal cchar=𝓗
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) I' contained conceal cchar=𝓘
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) J' contained conceal cchar=𝓙
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) K' contained conceal cchar=𝓚
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) L' contained conceal cchar=𝓛
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) M' contained conceal cchar=𝓜
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) N' contained conceal cchar=𝓝
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) O' contained conceal cchar=𝓞
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) P' contained conceal cchar=𝓟
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) Q' contained conceal cchar=𝓠
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) R' contained conceal cchar=𝓡
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) S' contained conceal cchar=𝓢
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) T' contained conceal cchar=𝓣
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) U' contained conceal cchar=𝓤
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) V' contained conceal cchar=𝓥
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) W' contained conceal cchar=𝓦
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) X' contained conceal cchar=𝓧
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) Y' contained conceal cchar=𝓨
autocmd BufEnter * syn match texMathSymbol '\\math\%(scr\|cal\) Z' contained conceal cchar=𝓩

" taken from the internet
autocmd BufEnter * syn match texMathSymbol /\\bra{\%([^}]*}\)\@=/ conceal cchar=⟨
autocmd BufEnter * syn match texMathSymbol /\%(\\bra{[^}]*\)\@<=}/ conceal cchar=|
autocmd BufEnter * syn match texMathSymbol /\\ket{\%([^}]*}\)\@=/ conceal cchar=|
autocmd BufEnter * syn match texMathSymbol /\%(\\ket{[^}]*\)\@<=}/ conceal cchar=⟩
autocmd BufEnter * syn match texMathSymbol /\\braket{\%([^}]*}\)\@=/ conceal cchar=⟨
autocmd BufEnter * syn match texMathSymbol /\%(\\braket{[^}]*\)\@<=}/ conceal cchar=⟩
autocmd BufEnter * syn match texMathSymbol /\\braket{\\braket{\%([^}]*}}\)\@=/ conceal cchar=⟪
autocmd BufEnter * syn match texMathSymbol /\%(\\braket{\\braket{[^}]*\)\@<=}}/ conceal cchar=⟫

" custom definitions
autocmd BufEnter * syn match texMathSymbol /\\\%(dim\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(det\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(lim\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(arg\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(sin\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(cos\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol /\\\%(tan\)\@=/ contained conceal
autocmd BufEnter * syn match texMathSymbol '\\not *' contained conceal cchar=/
autocmd BufEnter * syn match texMathSymbol ' *: *' contained conceal cchar=:
autocmd BufEnter * syn match texMathSymbol ' *\\cdot *' contained conceal cchar=·
autocmd BufEnter * syn match texMathSymbol '\\varnothing' contained conceal cchar=∅
autocmd BufEnter * syn match texMathSymbol '\\operatorname' contained conceal
autocmd BufEnter * syn match texMathSymbol '\\begin' contained conceal
autocmd BufEnter * syn match texMathSymbol '\\end' contained conceal
autocmd BufEnter * syn match texMathSymbol '\\begin{bmatrix}' contained conceal cchar=[
autocmd BufEnter * syn match texMathSymbol '\\begin{vmatrix}' contained conceal cchar=|
autocmd BufEnter * syn match texMathSymbol '\\end{bmatrix}' contained conceal cchar=]
autocmd BufEnter * syn match texMathSymbol '\\end{vmatrix}' contained conceal cchar=|
autocmd BufEnter * syn match texMathSymbol '\^\\intercal' contained conceal cchar=ᵀ
autocmd BufEnter * syn match texMathSymbol '\^\\times' contained conceal cchar=ˣ
autocmd BufEnter * syn match texMathSymbol '-' contained conceal cchar=—
autocmd BufEnter * syn match texMathSymbol '\\dot *' contained conceal cchar=˙
autocmd BufEnter * syn match texMathSymbol '\\acute *' contained conceal cchar=´
autocmd BufEnter * syn match texMathSymbol '\\check *' contained conceal cchar=ˇ
autocmd BufEnter * syn match texMathSymbol '\\dots' contained conceal cchar=…
autocmd BufEnter * syn match texMathSymbol ' *\\cdots *' contained conceal cchar=…
autocmd BufEnter * syn match texMathSymbol '\\text-' contained conceal cchar=-
autocmd BufEnter * syn match texMathSymbol '\\lbrace' contained conceal cchar={
autocmd BufEnter * syn match texMathSymbol '\\rbrace' contained conceal cchar=}
autocmd BufEnter * syn match texMathSymbol '\\mid' contained conceal cchar=|
autocmd BufEnter * syn match texMathSymbol ' *\\shortmid *' contained conceal cchar=∣
autocmd BufEnter * syn match texMathSymbol '\\lceil *' contained conceal cchar=⌈
autocmd BufEnter * syn match texMathSymbol ' *\\rceil' contained conceal cchar=⌉
autocmd BufEnter * syn match texMathSymbol '\\lfloor *' contained conceal cchar=⌊
autocmd BufEnter * syn match texMathSymbol ' *\\rfloor' contained conceal cchar=⌋
autocmd BufEnter * syn match texMathSymbol '\\delta *' contained conceal cchar=δ
autocmd BufEnter * syn match texMathSymbol '\\sigma' contained conceal cchar=σ
autocmd BufEnter * syn match texMathSymbol ' *\\smash *' contained conceal
autocmd BufEnter * syn match texMathSymbol '\\%' contained conceal cchar=%
autocmd BufEnter * syn match texMathSymbol '\\\*' contained conceal cchar=*
autocmd BufEnter * syn match texMathSymbol '_p' contained conceal cchar=ₚ
autocmd BufEnter * syn match texMathSymbol '_P' contained conceal cchar=ₚ
autocmd BufEnter * syn match texMathSymbol '_k' contained conceal cchar=ₖ
autocmd BufEnter * syn match texMathSymbol '_K' contained conceal cchar=ₖ
autocmd BufEnter * syn match texMathSymbol '_b' contained conceal cchar=₆
autocmd BufEnter * syn match texMathSymbol '_B' contained conceal cchar=₆
autocmd BufEnter * syn match texMathSymbol '_n' contained conceal cchar=ₙ
autocmd BufEnter * syn match texMathSymbol '_N' contained conceal cchar=ₙ
autocmd BufEnter * syn match texMathSymbol '\\omega' contained conceal cchar=ω

" non-math definitions
autocmd BufEnter * syn match Normal '&mdash;' conceal cchar=—
