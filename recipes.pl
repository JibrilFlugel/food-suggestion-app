% Công thức món ăn
recipe('Salad Rau Tron', ['rau', 'dua leo', 'ca chua']).
recipe('Trung Chien', ['trung', 'hanh']).
recipe('Ga Ran', ['thit ga', 'bot']).
recipe('Pho Bo', ['thit bo', 'banh pho', 'rau thom', 'hanh', 'que']).
recipe('Bun Cha', ['thit heo', 'bun', 'rau song', 'nuoc mam', 'toi', 'ot']).
recipe('Com Chien Hai San', ['com', 'tom', 'muc', 'trung', 'hanh']).
recipe('Mi Xao Hai San', ['mi', 'tom', 'muc', 'rau cai', 'hanh', 'toi']).
recipe('Lau Thai', ['tom', 'muc', 'thit bo', 'nam', 'rau thom', 'sa', 'la chanh']).

% Thay thế nguyên liệu
replacement('thit ga', 'thit bo').
replacement('thit heo', 'thit bo').
replacement('nuoc mam', 'tuong').

ingredient_available(Ingredient, Ingredients) :-
    member(Ingredient, Ingredients).
ingredient_available(Ingredient, Ingredients) :-
    replacement(Ingredient, Alternative),
    member(Alternative, Ingredients).

all_ingredients_available([], _).
all_ingredients_available([H | T], Ingredients) :-
    ingredient_available(H, Ingredients),
    all_ingredients_available(T, Ingredients).

% Gợi ý món
suggest_recipe(Ingredients, Recipe) :-
    recipe(Recipe, Required),
    all_ingredients_available(Required, Ingredients).
