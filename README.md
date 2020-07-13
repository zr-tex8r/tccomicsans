tccomicsans Package
===================

LaTeX: To use comicsans package with modern Comic Sans MS fonts

You can use the [comicsans] package (authored by Scott Pakin)
together with the set of Comic Sans MS fonts installed on Windows 10.

### System requirement

  * TeX format: LaTeX.
  * TeX engine: pdfTeX / pTeX / upTeX.
  * DVI driver (in DVI mode): dvipdfmx.
  * Dependent packages:
      - [comicsans]
  * Comic Sans MS fonts, version 5.x (shipped with Windows 8 or later)

[comicsans]: https://www.ctan.org/pkg/comicsans

### Installation

  - `*.sty` → $TEXMF/tex/latex/tccomicsans
  - `*.map` → $TEXMF/fonts/map/pdftex/tccomicsans
  - `enc/*.enc` → $TEXMF/fonts/enc/dvips/tccomicsans

NOTE: The [comicsans] package itself needs to be installed, but the extra
files required by the comicsans are not relevant to this package. This
package only requires the Comic Sans MS of version 5.x.

### License

This package is distributed under the MIT License.


The tccomicsans Package
-----------------------

### Package Loading

    \usepackage[<option>...]{tccomicsans}

Available options:

  * Driver options: `dvipdfmx` and `nodvidriver` are supported. When
    either `dvipdfmx` is specified or the PDF mode is in effect, then
    the map file is automatically loaded, and thus you don’t need to
    set up the map file.
  * `main`: Loads the comicsans package. This sets the main font of the
    document to Comic Sans MS.
  * `nomain` (default): Negation of `main`.  
    NOTE: When `nomain` is in effect, all comicsans options plus `math`
    will be of no effect since comicsans is not loaded. You can still
    use Comic Sans MS by using the `\comic` command.
  * `math` (default): The math settings of comicsans remain enabled.
  * `nomath`: The math settings of comicsans are disabled.

The following options are passed to the comicsans package:

  * `ulemph`
  * `boldemph`
  * `largesymbols`
  * `plusminus`

### Usage

  * A family `comic` which represents Comic Sans MS is defined.
  * `\comic`: Swicthes the family to `comic`.
  * `\textcomic{<text>}`: Prints text using `comic`.
  * When `main` is in effect, all the function of the comicsans package
    is available.


Revision History
----------------

  * Version 0.2  〈2020/07/13〉
      - The first public version.

--------------------
Takayuki YATO (aka. "ZR")  
https://github.com/zr-tex8r
