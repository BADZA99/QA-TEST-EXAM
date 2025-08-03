# Exemple de schéma
{
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


{
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


{
  "_id": ObjectId(),
  "userId": ObjectId("..."),  // ou id numérique si tu veux rester proche de l'API
  "date": "2020-03-02T00:00:00.000Z",
  "products": [
    {
      "productId": ObjectId("..."),
      "quantity": 4
    },
    {
      "productId": ObjectId("..."),
      "quantity": 1
    }
  ]
}


{
  "_id": ObjectId(),
  "name": "men's clothing",
  "description": "Articles destinés aux hommes",
  "image": "URL d’une image représentative"
}

