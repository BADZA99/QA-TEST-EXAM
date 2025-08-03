from pymongo import MongoClient
from bson import ObjectId

# Variables de connexion
DB_URI = "mongodb+srv://pndiaye:aTtbDOpeMNzOyBv2@cluster0.dfaeru6.mongodb.net/"
DB_NAME = "fakestore"

client = MongoClient(DB_URI)
db = client[DB_NAME]

# Exemple de produit
product = {
    "_id": ObjectId(),
    "title": "Fjallraven - Foldsack No. 1 Backpack",
    "price": 109.95,
    "description": "Your perfect pack...",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/image.jpg",
    "rating": {
        "rate": 3.9,
        "count": 120
    }
}

# Exemple d'utilisateur
user = {
    "_id": ObjectId(),
    "email": "john@gmail.com",
    "username": "johnd",
    "password": "hashedpassword",
    "name": {
        "firstname": "John",
        "lastname": "Doe"
    },
    "address": {
        "city": "kilcoole",
        "street": "7835 new road",
        "zipcode": "12926-3874",
        "geolocation": {
            "lat": "-37.3159",
            "long": "81.1496"
        }
    },
    "phone": "1-570-236-7033"
}

# Exemple de catégorie
category = {
    "_id": ObjectId(),
    "name": "men's clothing",
    "description": "Articles destinés aux hommes",
    "image": "https://fakestoreapi.com/img/men_clothing.jpg"
}

# Exemple de commande
order = {
    "_id": ObjectId(),
    "userId": user["_id"],
    "date": "2020-03-02T00:00:00.000Z",
    "products": [
        {"productId": product["_id"], "quantity": 4},
        {"productId": ObjectId(), "quantity": 1}
    ]
}

# Insertion des documents
db.products.insert_one(product)
db.users.insert_one(user)
db.categories.insert_one(category)
db.orders.insert_one(order)

print("Données insérées avec succès dans la base 'fakestore'.")

