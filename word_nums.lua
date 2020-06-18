local function sgn(a)
    return (a < 0) and -1 or 1
end

do local signmeta = {
    __sub = function(a,b)
        if b.iscardinal then
            return a.baseval * b.baseval
        else
            error()
        end
    end}
function makesign(val)
    return setmetatable({baseval=val}, signmeta)
end end

do numeralmeta = {
    __sub = function(a,b)
        if type(a)=="number" then --We are 'b'
            return a + (b.baseval*sgn(a))
        elseif b.ismultiplier then
            return a.baseval * b.baseval
        else
            error()
        end
    end}
function makenumeral(val)
    return setmetatable({baseval=val, isnumeral=true, iscardinal=true}, numeralmeta)
end end

do cardinalmeta = {
    __sub = function(a,b)
        if type(a)=="number" then --We are 'b'
            return a + (b.baseval*sgn(a))
        elseif b.ismultiplier and b.baseval > 100 then
            return a.baseval * b.baseval
        else
            error()
        end
    end}
function makecardinal(val)
    return setmetatable({baseval=val, iscardinal=true}, cardinalmeta)
end end

do cardinalmultipliermeta = {
    __sub = function(a,b)
        if type(a)=="number" then --We are 'b'
            return a + (b.baseval*sgn(a))
        elseif b.isnumeral then
            return a.baseval + b.baseval
        elseif b.ismultiplier and b.baseval > 100 then
            return a.baseval * b.baseval
        else
            error()
        end
    end}
function makecardinalmultiplier(val)
    return setmetatable({baseval=val, iscardinal=true, iscardinalmultiplier=true}, cardinalmultipliermeta)
end end

do multipliermeta = {
    __sub = function(a,b)
        if type(a)=="number" then --We are 'b'
            local bott_3 = math.abs(a) % 1000
            if (b.baseval == 100) and (bott_3 >= 10) then error() end
            return ((math.abs(a) - bott_3) + (bott_3 * b.baseval)) * sgn(a)
        else
            error()
        end
    end}
function makemultiplier(val)
    return setmetatable({baseval=val, ismultiplier=true}, multipliermeta)
end end

positive = makesign(1)
negative = makesign(-1)

one = makenumeral(1)
two = makenumeral(2)
three = makenumeral(3)
four = makenumeral(4)
five = makenumeral(5)
six = makenumeral(6)
seven = makenumeral(7)
eight = makenumeral(8)
nine = makenumeral(9)

ten = makecardinal()
eleven = makecardinal(11)
twelve = makecardinal(12)
thirteen = makecardinal(13)
fourteen = makecardinal(14)
fifteen = makecardinal(15)
sixteen = makecardinal(16)
seventeen = makecardinal(17)
eighteen = makecardinal(18)
nineteen = makecardinal(19)

twenty = makecardinalmultiplier(20)
thirty = makecardinalmultiplier(30)
forty = makecardinalmultiplier(40)
fifty = makecardinalmultiplier(50)
sixty = makecardinalmultiplier(60)
seventy = makecardinalmultiplier(70)
eighty = makecardinalmultiplier(80)
ninety = makecardinalmultiplier(90)

hundred = makemultiplier(100)
thousand = makemultiplier(1000)
million = makemultiplier(1000000)
billion = makemultiplier(1000000000)

--[[print(negative-two)
print(six-thousand)
print(positive-fourteen)
print(positive-sixty-two)
print(negative-sixty-two)
print(one-thousand)
print(twelve-thousand-forty-two)
print(negative-four-hundred-sixty-two-thousand-one-hundred-eighty-one)
print(positive-twenty-two-million-eight-hundred-fifty-seven-thousand-nine-hundred-eighteen)
--]]