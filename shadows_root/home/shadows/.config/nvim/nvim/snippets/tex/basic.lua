return {
  -- normal environments
	s("bg", {
    t("\\begin{"),
    i(1, "env"),
    t({ "}", "\t" }),
    i(2),
    t({ "", "\\end{" }),
    rep(1),
    t("}"),
  }), 
  -- equation
  s("eq", {
    t("\\begin{equation}\\label{"),
    i(1),
    t({"}","\t"}),
    i(2),
    t({"","\\end{equation}"}),
  }),
  s("mul", {
    t("\\begin{multline}\\label{"),
    i(1),
    t({"}","\t"}),
    i(2),
    t({"","\\end{multline}"}),
  }),
  s("gather",{
    t({"\\begin{gather}","\t"}),
    i(1),
    t({"","\\end{gather}"}),
  }),
  s("align",{
    t({"\\begin{align}","\t"}),
    i(1),
    t({"","\\end{align}"}),
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
  s(";h",{
    t("\\hat{"),
    i(1,"$hat"),
    t("}"),
  }),
   
}


