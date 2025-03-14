return {
  -- normal environments
	s("mj", {
    t({"<div class=\"mathjax\">","\t"}),
    i(1),
    t({"","</div>"}),
  }), 
  -- equation
  s("eq", {
    t({"<div class=\"mathjax\">\\begin{equation}","\t"}),
    i(1),
    t({"","\\end{equation}</div>"}),
  }),
  s("align",{
    t({"<div class=\"mathjax\">\\begin{align}","\t"}),
    i(1,"$ amsmath"),
    t({"","\\end{align}</div>"}),
  }),
  -- big symbols
  s("frac", {
    t("\\frac{"),
    i(1, "@numerator@"),
    t("}{"),
    i(2, "@denominator@"),
    t("}"),
  }),
  s("sum",{
    t("\\sum_{"),
    i(1),
    t("}^{"),
    i(2),
    t("}"),
  }),
  s("prod",{
    t("\\prod_{"),
    i(1),
    t("}^{"),
    i(2),
    t("}"),
  }),
  s("int",{
    t("\\int_{"),
    i(1),
    t("}^{"),
    i(2),
    t("}"),
  }),
  -- differential
  s("dd",{
    t("\\frac{\\mathrm{d}"),
    i(2),
    t("}{\\mathrm{d}"),
    i(1),
    t("}"),
    i(3),
  }),
   s("pp",{
    t("\\frac{\\partial "),
    i(2),
    t("}{\\partial "),
    i(1),
    t("}"),
    i(3),
   }),
   -- vector
   s("bf",{
    t("\\mathbf{"),
    i(1),
    t("}"),
   }), 
   -- small tick
  s(";d",{
    t("\\mathrm{d}"),
  }),
  s(";e",{
    t("\\mathrm{e}^{"),
    i(1),
    t("}"),
  }),
  s(";i",{
    t("\\mathrm{i}"),
  }),
  s(";b",{
    t("\\bm{"),
    i(1,"$bm"),
    t("}"),
  }),
   
}
