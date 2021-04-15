# BibTex2HugoAcademic

Two Perl scripts to generate publication folders and index.md files (bib2markdown.pl) and the cite.bib files (bib2citebibs.pl) needed for the [Hugo Academic theme](https://themes.gohugo.io/academic/). Works for me, but probably quite wobbly, and only tested on the BibText output by [TeXMed](https://www.bioinformatics.org/texmed/). These should both be run in the *root* folder of your website. They *should* refuse to overwrite existing files unless you tell them too.. but you'd be wise to check first. The resulting index.md will need some editing to make them pretty etc.

All the hard stuff is done by the [BibText::parser module](https://metacpan.org/pod/BibTeX::Parser) by [Boris Veytsman](http://borisv.lk.net/).
