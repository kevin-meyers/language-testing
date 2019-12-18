from pyswip import *

prolog = Prolog()
prolog.consult('noahs_problem.pl')
step = Functor('step', 1)
num_possible = Functor('possible_stairs', 2)



def staircase(top_stair, possible_steps):
    for s in possible_steps:
        prolog.assertz(f'step({s})')

    Possiblities = Variable()

    q = prolog.query(f'possible_stairs({top_stair}, Possiblities)')
    val = next(q)['Possiblities']
    q.close()

    for s in possible_steps:
        prolog.retract(f'step({s})')

    return val
