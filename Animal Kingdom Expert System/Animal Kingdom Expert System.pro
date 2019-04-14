Database
xpositive(symbol, integer)
xnegative(symbol)

predicates

Nondeterm animal(string).
Nondeterm type(symbol).
Nondeterm type(symbol,integer).

nondeterm run_system.
nondeterm start_Animal.
nondeterm reset_database. %Clear facts
nondeterm positive(string,symbol). % i,i
nondeterm negative(string,symbol). %i,i
nondeterm ask(string,symbol,char). %i,i,i
nondeterm remember(symbol,char). %i,i


clauses

animal("cheetah"):-
type(mammal),
type(carnivore),
type(activeatnight),
type(livesinjungle),
type(climbstrees),
type(color,4), % tawny color
type(darkspots).

animal("tiger"):-
type(mammal),
type(carnivore),
type(activeatnight),
type(livesinjungle),
type(climbstrees),
type(color,4),
type(blackstripes).

animal("dog"):-
type(mammal),
type(carnivore),
type(coveredinfur),
type(ispet),
type(usedforguarding).

animal("cat"):-
type(mammal),
type(carnivore),
type(coveredinfur),
type(ispet),
type(climbstrees).

animal("bat"):-
type(mammal),
type(canfly),
type(hastwolegs),
type(haswings).

animal("giraffe"):-
type(ungulate),
type(color,4), % tawny color
type(longneck),
type(longlegs),
type(darkspots).

animal("zebra"):-
type(ungulate),
type(color,1), % white color
type(blackstripes).

animal("elephant"):-
type(ungulate),
type(color,3), % grey color
type(livesinafrica),
type(size,1), % LARGE SIZE 
type(hastrunk).

animal("sheep"):-
type(ungulate),
type(coveredinwool),
type(islivestock).

animal("ostrich"):-
type(bird),
type(color,5), % brown color
type(flies),
type(size,2), % BIG SIZE
type(runsfast),
type(tall),
type(longneck),
type(longlegs).

animal("penguin"):-
type(bird),
type(flies),
type(livesincoldplaces),
type(swims),
type(color,2), % black and white color
type(eatsfish).

animal("albatross"):-
type(bird),
type(color,5), % brown color
type(activeatnight),
type(flies).

animal("sparrow"):-
type(bird),
type(size,3), % SMALL SIZE
type(sings),
type(ispet).

animal("canary"):-
type(bird),
type(color,7), %yellow color
type(sings).


animal("parrot"):-
type(bird),
type(talks),
type(pet).

animal("peacock"):-
type(bird),
type(coloredtail),
type(longtail),
type(flies).

animal("robin"):-
type(bird),
type(slow),
type(color,8). % Red color


animal("crow"):-
type(bird),
type(claws),
type(color,9). % Black color


animal("eagle"):-
type(bird),
type(longwings),
type(livesinmountains),
type(carnivore).

animal("lizard"):-
type(reptile),
type(livesindesert).

animal("crocodile"):-
type(carnivore),
type(livesinwater),
type(size,2), % BIG SIZE
type(largemouth),
type(reptile).

animal("tortoise"):-
type(reptile),
type(livesinwater),
type(slow),
type(hasshell).

animal("snake"):-
type(reptile),
type(carnivore),
type(nolegs),
type(haspoisonteeth),
type(tall),
type(thick),
type(rubbery),
type(livesinholes),
type(shedskin),
type(fast).

animal("salmon"):-
type(fish),
type(color,10), % PINK COLOR
type(edible).

animal("dolphin"):-
type(fish),
type(noscales),
type(softskin),
type(friendly),
type(longbeak).

animal("whale"):-
type(fish),
type(noscales),
type(softskin),
type(size,1), % LARGE SIZE
type(backhole),
type(carnivore).

animal("shark"):-
type(fish),
type(carnivore),
type(noscales),
type(tringularfin),
type(color,6).


% Starts the system.
run_system:-
	write("*** 1. Animal Kingdom  Expert System  ***\n"), nl,
	start_Animal,
	write("Would you like anthor conclusion?(y/n)"), nl, readchar(Replay), write(Replay), nl, nl, Replay='y', reset_database,
	run_system.

% to write Yes at the end of the run.
run_system:-
	write("\n\nThanks!"),nl.

% starts asking the user questions and recording the answers.
start_Animal:-
	animal(Animal),!,
	write("\n<Animal> The Animal is ", Animal, ".\n"), nl.
% if no animals were found. 
start_Animal:-
	write("\n<Animal> Sorry, I am not able to recognize the Animal. Try again!"), nl.
% resets the database.
reset_database:-
	retractall(xpositive(_, _)), retractall(xnegative(_)).

	
%checks if the value was already in the positive database. 
%parameter1 : the question. (ignored)
%parameter2 : the type.
positive(_,Type):-
	xpositive(Type, _),!.

%checks if the value was already in the negative database, if not then asks the user the question.  
%parameter1 : the question.
%parameter2 : the type.
positive(Query,Type):-
	not(xnegative(Type)),
	ask(Query,Type,'y').


%checks if the value was already in the negative database. 
%parameter1 : the question. (ignored)
%parameter2 : the type.
negative(_,Type):-
	xnegative(Type),!.

%checks if the value was already in the positive database, if not then asks the user the question.  
%parameter1 : the question.
%parameter2 : the type.
negative(Query,Type):-
	not(xpositive(Type, _)),
	ask(Query,Type,'n').


%Asks question, gets answer,takes the first character , adds to the database and checks if it is the answer we want. 
%parameter1 : the question.
%parameter2 : the type.
%parameter3 : the value we compare with the answer we get from the user. 

ask(Query,Type,Reply):-
	write(Query),
	readln(R), frontchar(R,Z,_),nl,
	remember(Type,Z),
	Reply=Z.

% add to the positive database.
%parameter1 : the animal type.
%parameter2 : the character.
remember(Type,'y'):-
	assert(xpositive(Type, 0)).

% add to the negative database.
%parameter1 : the animal type.
%parameter2 : the character.
remember(Type,'n'):-
	assert(xnegative(Type)).
	
type(mammal):-
	positive("<?> Is the animal a mammal? (y/n)",mammal).
type(carnivore):-
	positive("<?> Is the animal a carnivore? (y/n)",carnivore).
type(activeatnight):-
	positive("<?> Is the animal active at night? (y/n)",activeatnight).
type(livesinjungle):-
	positive("<?> Is the animal lives in jungle? (y/n)",livesinjungle).
type(climbstrees):-
	positive("<?> Is the animal climbs trees? (y/n)",climbstrees).
type(darkspots):-
	positive("<?> Is the animal has a dark spots? (y/n)",darkspots).
type(blackstripes):-
	positive("<?> Is the animal has black stripes? (y/n)",blackstripes).
type(coveredinfur):-
	positive("<?> Is the animal covered in fur? (y/n)",coveredinfur).
type(ispet):-
	positive("<?> Is the animal a pet? (y/n)",ispet).
type(usedforguarding):-
	positive("<?> Is the animal used for guarding? (y/n)",usedforguarding).
type(canfly):-
	positive("<?> Is the animal can fly? (y/n)",canfly).
type(hastwolegs):-
	positive("<?> Is the animal has two legs? (y/n)",hastwolegs).
type(haswings):-
	positive("<?> Is the animal has wings? (y/n)",haswings).											
type(ungulate):-
	positive("<?> Is the animal ungulate? (y/n)",ungulate).	
type(longneck):-
	positive("<?> Is the animal has long neck? (y/n)",longneck).	
type(longlegs):-
	positive("<?> Is the animal has long legs? (y/n)",longlegs).	
type(livesinafrica):-
	positive("<?> Is the animal lives in Africa? (y/n)",livesinafrica).	
type(hastrunk):-
	positive("<?> Is the animal has trunk? (y/n)",hastrunk).	
type(coveredinwool):-
	positive("<?> Is the animal covered in wool? (y/n)",coveredinwool).	
type(islivestock):-
	positive("<?> Is the animal a livestock? (y/n)",islivestock).	
type(bird):-
	positive("<?> Is the animal a bird? (y/n)",bird).	
type(flies):-
	positive("<?> Is the animal flies? (y/n)",flies).	
type(runsfast):-
	positive("<?> Is the animal runs fast? (y/n)",runsfast).	
type(tall):-
	positive("<?> Is the animal tall? (y/n)",tall).
type(livesincoldplaces):-
	positive("<?> Is the animal lives in cold places? (y/n)",livesincoldplaces).
type(swims):-
	positive("<?> Is the animal swims? (y/n)",swims).
type(eatsfish):-
	positive("<?> Is the animal eats fish? (y/n)",eatsfish).
type(sings):-
	positive("<?> Is the animal sings? (y/n)",sings).
type(talks):-
	positive("<?> Is the animal talks? (y/n)",talks).
type(coloredtail):-
	positive("<?> Is the animal has colored tail? (y/n)",coloredtail).
type(longtail):-
	positive("<?> Is the animal has long tail? (y/n)",longtail).
type(slow):-
	positive("<?> Is the animal slow? (y/n)",slow).
type(claws):-
	positive("<?> Is the animal has claws? (y/n)",claws).
type(longwings):-
	positive("<?> Is the animal has long wings? (y/n)",longwings).
type(livesinmountains):-
	positive("<?> Is the animal runs lives in mountains? (y/n)",livesinmountains).
type(reptile):-
	positive("<?> Is the animal a reptile? (y/n)",reptile).
type(livesindesert):-
	positive("<?> Is the animal lives in desert? (y/n)",livesindesert).	
type(livesinwater):-
	positive("<?> Is the animal lives in water? (y/n)",livesinwater).
type(largemouth):-
	positive("<?> Is the animal has a large mouth? (y/n)",largemouth).
type(hasshell):-
	positive("<?> Is the animal has a shell? (y/n)",hasshell).
type(nolegs):-
	negative("<?> Is the animal has no legs? (y/n)",nolegs).
type(haspoisonteeth):-
	positive("<?> Is the animal has poison teeth? (y/n)",haspoisonteeth).
type(thick):-
	positive("<?> Is the animal thick? (y/n)",thick).
type(rubbery):-
	positive("<?> Is the animal rubbery? (y/n)",rubbery).
type(livesinholes):-
	positive("<?> Is the animal lives in holes? (y/n)",livesinholes).
type(shedskin):-
	positive("<?> Is the animal shed his skin? (y/n)",shedskin).
type(fast):-
	positive("<?> Is the animal fast? (y/n)",fast).
type(fish):-
	positive("<?> Is the animal a fish? (y/n)",fish).
type(edible):-
	positive("<?> Is the animal edible? (y/n)",edible).
type(noscales):-
	negative("<?> Is the animal has no scales? (y/n)",noscales).
type(softskin):-
	positive("<?> Is the animal has soft skin? (y/n)",softskin).
type(friendly):-
	positive("<?> Is the animal friendly? (y/n)",friendly).
type(longbeak):-
	positive("<?> Is the animal has long beak? (y/n)",longbeak).
type(backhole):-
	positive("<?> Is the animal has back hole? (y/n)",backhole).																																									
type(tringularfin):-
	positive("<?> Is the animal has tringular fin? (y/n)",tringularfin).


% in theses 2 cases, we add the value with the number because they are special cases. 

%check if the color and it's value already exist in the database, if not then add to the database the color symbol and it's number. 	
%parameter 1: symbol called color.
%parameter 2: the value which is a number. 

type(color, Color):- xpositive(color, Color),!.
type(color, Color):-
	not(xpositive(color, _)),
	write("<Colors> Choose one of the following colors:"), nl,
	write("1- White"), nl,
	write("2- Black And White"), nl,
	write("3- Gray"), nl,
	write("4- Tawny"), nl,
	write("5- Brown"), nl,
	write("6- Dark Gray "), nl,
	write("7- Yellow"), nl,
	write("8- Red"), nl,
	write("9- Black"), nl,
	write("10- Pink"), nl,
	readint(C),!, assert(xpositive(color, C)),
	Color = C.
	

%check if the size and it's value already exist in the database, if not then add to the database the size symbol and it's number. 
%parameter 1: symbol called size.
%parameter 2: the value which is a number. 

type(size, Size):- xpositive(size, Size),!.
type(size, Size):-
	not(xpositive(size, _)),
	write("<size> Choose one of the following sizes:"), nl,
	write("1- Large"), nl,
	write("2- Big"), nl,
	write("3- Small"), nl,
	readint(S),!, assert(xpositive(color, S)),
	Size = S.	

Goal

run_system.