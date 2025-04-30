CREATE TABLE Ingredients(
    "id" INTERGER,
    "name" TEXT,
    "price_per_unit" REAL NOT NULL,
    "unit" TEXT,
    PRIMARY KEY("id")
);
CREATE TABLE Donuts(
    "id" INTEGER,
    "name" TEXT,
    "is_gluten_free" BOOLEAN,
    "price" REAL,
    PRIMARY KEY("id")
);
CREATE TABLE DonutIngredients(
    
    "donut_id" INTEGER,
    "ingredient_id" INTEGER,
    PRIMARY KEY("donut_id","ingredient_id")
    FOREIGN KEY ("donut_id") REFERENCES Donuts("id"),
    FOREIGN KEY("ingredient_id") REFERENCES Ingredients("id")
);
CREATE TABLE Customers(
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT
    PRIMARY KEY ("id")
);
CREATE TABLE Orders(
    "id" INTEGER,
    "customer_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES Customers("id")
)
CREATE TABLE DonutOrders(
    "order_id" INTEGER,
    "donut_id" INTEGER,
    "quantity" INTEGER,
    PRIMARY KEY ("order_id","donut_id")
    FOREIGN KEY ("order_id") REFERENCES Order("id")
    FOREIGN KEY ("donut_id") REFERENCES Donuts("id")
);