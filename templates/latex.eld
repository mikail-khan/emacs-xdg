latex-mode

(frac "\\frac{" p "}{" q "}")
(sqrt "\\sqrt{" p "}")
(sum "\\sum_{" p "}^{" q "}")
(int "\\int_{" p "}^{" q "} " r)
(lim "\\lim_{" p " \\to " q "} ")
(rr "\\mathbb{R}")
(nn "\\mathbb{N}")
(zz "\\mathbb{Z}")
(qq "\\mathbb{Q}")
(cc "\\mathbb{C}")

(thm
 "\\begin{theorem}\n"
 p
 "\n\\end{theorem}")

(proof
 "\\begin{proof}\n"
 p
 "\n\\end{proof}")

(align
 "\\begin{align*}\n"
 p
 "\n\\end{align*}")
