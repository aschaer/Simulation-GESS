# MATLAB HS12 – Research Plan 

WORK IN PROGRESS

> * Group Name: (be creative!)
> * Group participants names: Arner Flurin, Demicheli Samuele, Schaer Alessandro, Solcà Gerson
> * Project Title: Mensa optimization by queue separation

## General Introduction

Every day it's the same old story:

The mensas are full, the queues keep growing and the wait seems to have no end.
Since we are directly interested, we asked ourselves if it's due to the mensa's configuration and/or the employees'
"efficency" and we thought of another approach;


"What if you had to choose the line before entering the mensa without having the possibility to change it? What if
the employees were 'perfect' workers?"

Other groups have already simulated a model of the actual mensa of the ETH, but we are interested on the effects of
a change in the mensa's structure and functionality. For the bottle-neck section we're probably going to use the
ideas of the other groups in order to be able to focus on the effect of the employees' efficiency.


(States your motivation clearly: why is it important / interesting to solve this problem?)
(Add real-world examples, if any)
(Put the problem into a historical context, from what does it originate? Are there already some proposed solutions?)

## The Model

We're going to assume a standard inflow of peolple, which varies in time, but it will be assumed the same for all
simulations we're going to run (probably a Gaussian distribution).

The variable parameters will be the "speed of the service", which can be approximated with function of time and will 
be our main control knob of the system, and the decision of the menu, i.e. how many customers are going to take the 
Menu 1 instead of the Menu 2 and 3 and viceversa.

The whole simulation is going to have as iteration step the idependent variable time.
Another idea is to 'save' in each individual the time (iteration steps), which has passed to recive the desired
food, and then to see how this times are distributed for different models of employee. The shorter the time, the 
happier the student.

(Define dependent and independent variables you want to study. Say how you want to measure them.) 
(Why is your model a good abstraction of the problem you want to study?) 
(Are you capturing all the relevant aspects of the problem?)


## Fundamental Questions

Is there a configuration which minimizes the walk-through-time?
* Should the employees adopt a certain "speed pattern"?
* Could a perfect-constant-worker solve the queue-problem?
* Is it better to have a big or a small space between the place where you get the food and the one where you pay for it?

How does the students' choices affect their own walk-through-time?

Will we ever be able to have a mensa without infite queues?

(At the end of the project you want to find the answer to these questions)
(Formulate a few, clear questions. Articulate them in sub-questions, from the more general to the more specific. )


## Expected Results

We obviously hope that there's a way (even if it's not realizable in practice) to reduce the noon queues, but we
also hope to not encounter problems in the formation of those in the simulation, since this has been a problem
in the past.

Probably, an "adaptive" speed of the employees could result a good compromise, but who knows? Time will tell


(What are the answers to the above questions that you expect to find before starting your research?)


## References 

As suggested by Prof. K. Donnay we will use the work done by F. Berney, M.F. Lagadec and P. Neitzel,
the one done by L. Nimeskern and A. Zwahlen (both May, 2011) and the one done by M. Vifian, M. Roggo and M. Aebli
(December, 2011).


(Add the bibliographic references you intend to use)
(Explain possible extension to the above models)
(Code / Projects Reports of the previous year)


## Research Methods

An Agent-Based Model was suggested by Prof. K. Donnay since the celluar automata approach does not lead to the 
desired queue formation, which corresponds to the reality. We're going to try wathever is needed in order to get
a realistic model of the considered system.

(Cellular Automata, Agent-Based Model, Continuous Modeling...) 
(If you are not sure here: 1. Consult your colleagues, 2. ask the teachers, 
3. remember that you can change it afterwards)


## Other

No datasets are going to be used, since all the desired information will be obtained by the simulation itself.
Starting and minimum values (e.g. the maximum serving speed) are going to be estimated by our everyday experience.

(mention datasets you are going to use)
