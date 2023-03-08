module cQASM
using PikaParser: seq, token, satisfy, many, some, tie, first, make_grammar, flatten

rules = Dict(
    :space => satisfy(c -> c ∈ (' ', '\t')),
    :digit => satisfy(isdigit),
    :natural => some(:digit),
    :float => seq(:natural, :token('.'), many(:natural)),
    :letter => satisfy(isascii),
    :qname => seq(token("q["), natural, token(']')),
    :bname => seq(token("b["), natural, token(']')),
    :name => tie(seq(isletter, many(satisfy(c -> isletter(c) || isdigit(c))))), # TODO 
    :id => first(:name, :qname, :bname),
    # comments
    :comment => seq(token('#'), many(satisfy(isprint))),
    # keywords
    :version => seq(token("version"), :space, :float),
    :qubits => seq(token("qubits"), :space, :natural),
    :map => seq(token("map"), :space, :id, many(:space), token(','), many(:space), :id),
    # quantum gates
    :i => seq(token("i"), some(:space), :id),
    :x => seq(token("x"), some(:space), :id),
    :y => seq(token("y"), some(:space), :id),
    :z => seq(token("z"), some(:space), :id),
    :h => seq(token("h"), some(:space), :id),
    :rx => seq(token("rx"), some(:space), :id, many(:space), :token(','), many(:space), :float),
    :ry => seq(token("ry"), some(:space), :id, many(:space), :token(','), many(:space), :float),
    :rz => seq(token("rz"), some(:space), :id, many(:space), :token(','), many(:space), :float),
    :x90 => seq(token("x90"), some(:space), :id),
    :y90 => seq(token("y90"), some(:space), :id),
    :mx90 => seq(token("mx90"), some(:space), :id),
    :my90 => seq(token("my90"), some(:space), :id),
    :s => seq(token("s"), some(:space), :id),
    :sdag => seq(token("sdag"), some(:space), :id),
    :t => seq(token("t"), some(:space), :id),
    :tdag => seq(token("tdag"), some(:space), :id),
    :cnot => seq(token("cnot"), some(:space), :id, many(:space), :token(','), many(space), :id),
    :toffoli => seq(
        token("toffoli"),
        some(:space),
        :id,
        many(:space),
        :token(','),
        many(space),
        :id,
        many(:space),
        token(','),
        many(:space),
        :id,
    ),
    :cz => seq(token("cz"), some(:space), :id, many(:space), :token(','), many(space), :id),
    :swap => seq(token("swap", some(:space), :id, many(:space), :token(','), many(:space), :id)),
    :crk => seq(
        token("crk"),
        some(:space),
        :id,
        many(:space),
        :token(','),
        many(space),
        :id,
        many(:space),
        token(','),
        many(:space),
        :natural,
    ),
    :cr => seq(
        token("cr"),
        some(:space),
        :id,
        many(:space),
        :token(','),
        many(space),
        :id,
        many(:space),
        token(','),
        many(:space),
        :float,
    ),
    :cx => seq(token("c-x"), some(:space), :id, many(:space), :token(','), many(space), :id),
    :cy => seq(token("c-z"), some(:space), :id, many(:space), :token(','), many(space), :id),
    # state preparation and measurement
    :prep_x => seq(token("prep_x"), some(:space), :id),
    :prep_y => seq(token("prep_y"), some(:space), :id),
    :prep_z => seq(token("prep_z"), some(:space), :id),
    :measure_x => seq(token("measure_x"), some(:space), :id),
    :measure_y => seq(token("measure_y"), some(:space), :id),
    :measure_z => seq(token("measure_z"), some(:space), :id),
    :measure_all => token("measure_all"),
    :measure_parity => seq(
        token("measure_parity"),
        some(:space),
        :id,
        token(','),
        first('x', 'y', 'z'),
        token(','),
        :id,
        token(','),
        first('x', 'y', 'z'),
    ),
    # other
    :not => seq(token("not"), some(:space), :id),
    :display => token("display"),
)

end