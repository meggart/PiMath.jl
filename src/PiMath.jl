module PiMath
import Showoff
import Gadfly
import Base.+, Base.-, Base.*, Base./, Base.<, Base.<=

immutable MulOfPi{T} <: Real
    f::T
end
immutable PiRange{S} <: Range{S}
    r::LinSpace{S} #This should be a Range object
end

function Showoff.showoff{T}(xs::AbstractArray{MulOfPi{T}},style=:none)
    return [string(x, "π") for x in Showoff.showoff([x.f for x in xs],style)]
end
function Showoff.showoff(xs::AbstractArray{MulOfPi},style=:none)
    return [string(x, "π") for x in Showoff.showoff([x.f for x in xs],style)]
end

Base.getindex(x::PiRange,i::Integer)=MulOfPi(getindex(x.r,i))
Base.getindex(x::PiRange,i::Colon)=PiRange(getindex(x.r,i))
Base.getindex(x::PiRange,i::Range)=PiRange(getindex(x.r,i))
Base.length(x::PiRange)=length(x.r)
Base.step(x::PiRange)=MulOfPi(step(x.r))
Base.isempty(x::PiRange)=isempty(x.r)
Base.first(x::PiRange) = MulOfPi(first(x.r))
Base.last(x::PiRange) = MulOfPi(last(x.r))
Base.start(x::PiRange) = start(x.r)
Base.done(x::PiRange, i::Int) = done(x.r,i)
Base.next(x::PiRange, i::Int) = begin a,b=next(x.r,i); (MulOfPi(a),b) end

Base.show{T<:Rational}(io::IO,x::MulOfPi{T})=print(io,x.f.num==1 ? "" : x.f.num,"π", x.f.den==1 ? "" : string("/",x.f.den))
Base.show{T<:Real}(io::IO,x::MulOfPi{T})=print(io,x.f,"π")
Base.isfinite(x::MulOfPi)=isfinite(x.f)
Base.convert{T}(::Type{MulOfPi{T}}, x::Real)=MulOfPi(convert(T,x/convert(Float64,pi)))
Base.convert(::Type{MulOfPi}, x::Real)=error("")

+(a::MulOfPi,b::MulOfPi)=MulOfPi(a.f+b.f)
-(a::MulOfPi)=MulOfPi(-a.f)
-(a::MulOfPi,b::MulOfPi)=MulOfPi(a.f-b.f)
*(a::Bool,b::Irrational{:π})=a ? zero(Float64) : convert(Float64,Irrational{:π})
*{T}(a::Bool,b::MulOfPi{T})=a ? MulOfPi(zero(T)) : MulOfPi(one(T))
*(a::MulOfPi,b::Union{Integer,AbstractFloat})=MulOfPi(a.f*b)
*(b::Union{Integer,AbstractFloat,Rational},a::MulOfPi)=MulOfPi(a.f*b)
*(a::Union{Integer,AbstractFloat,Rational},b::Irrational{:π})=MulOfPi(a)
*(b::Irrational{:π},a::Union{Integer,AbstractFloat})=MulOfPi(a)
*(a::MulOfPi,b::MulOfPi)=convert(Float64,a)*convert(Float64,b)
/(a::MulOfPi,b::Union{Integer,AbstractFloat})=MulOfPi(a.f/b)
/(a::MulOfPi,b::MulOfPi)=a.f/b.f
/(b::Irrational{:π},a::Union{Integer,AbstractFloat})=MulOfPi(inv(a))
<(a::MulOfPi,b::MulOfPi)=a.f<b.f
<=(a::MulOfPi,b::MulOfPi)=a.f<=b.f

Base.convert{S}(::Type{MulOfPi{S}},x::Irrational{:π})=MulOfPi(1)
Base.convert(::Type{Bool}, x::MulOfPi)=convert(Bool,x.f)
Base.convert{T<:AbstractFloat,S}(::Type{T},x::MulOfPi{S})=begin a,b=promote(x.f,pi);convert(T,a*b) end
Base.convert{T<:Integer,S}(::Type{T},x::MulOfPi{S})=begin a,b=promote(x.f,pi);convert(T,a*b) end
Base.convert{T<:Rational,S}(::Type{T},x::MulOfPi{S})=begin a,b=promote(x.f,pi);convert(T,a*b) end
Base.convert(::Type{MulOfPi},x::Real)=MulOfPi(x/pi)
Base.promote_rule{S}(::Type{Irrational{:π}},::Type{MulOfPi{S}})=MulOfPi{S}
Base.promote_rule{T<:AbstractFloat,S<:Any}(::Type{MulOfPi{S}},::Type{T})=T
Base.promote_rule{T<:Union{Integer,Rational},S<:Any}(::Type{MulOfPi{S}},::Type{T})=Float64


function Gadfly.optimize_ticks(x_min::MulOfPi, x_max::MulOfPi; kwargs...)
    ticks, viewmin, viewmax = Gadfly.optimize_ticks(x_min.f, x_max.f;kwargs...)
    return [MulOfPi(t) for t in ticks],MulOfPi(viewmin),MulOfPi(viewmax)
end

Base.linspace(start::MulOfPi,stop::MulOfPi,len::Real)=PiRange(linspace(start.f,stop.f,len))
Base.linspace{T<:AbstractFloat}(start::T,stop::MulOfPi,len::Real)=PiRange(linspace(start,stop.f,len))
Base.linspace{T<:Integer}(start::T,stop::MulOfPi,len::Real)=PiRange(linspace(start,stop.f,len))
Base.linspace{T<:AbstractFloat}(start::MulOfPi,stop::T,len::Real)=PiRange(linspace(start.f,stop,len))
Base.linspace{T<:Integer}(start::MulOfPi,stop::T,len::Real)=PiRange(linspace(start.f,stop,len))


end # module
