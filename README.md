# PiMath

[![Build Status](https://travis-ci.org/meggart/PiMath.jl.svg?branch=master)](https://travis-ci.org/meggart/PiMath.jl)

Some convenience functions to have better output when working with multiples of π Especially axis labelling in Gadfly is improved. 

## Usage example

````julia
using Gadfly
using PiMath
x=linspace(0,4pi,100)
plot(x=x,y=sin(x))
````

will show x-axis labels a multiples of π. For more examples have a look at the NoteBook

http://nbviewer.ipython.org/github/meggart/PiMath.jl/blob/1e730ffd12d68cd9ba36ad4df9fc927f84e59a34/NoteBook/PiMath.ipynb

