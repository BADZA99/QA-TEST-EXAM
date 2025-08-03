from robot.api.deco import keyword, library
from pymongo import MongoClient
from pymongo.errors import ConnectionFailure, OperationFailure, DuplicateKeyError
from bson.objectid import ObjectId
from bson.errors import InvalidId
import json
import re

@library
class MongoDBLibrary:
    """Library for MongoDB operations in Robot Framework"""

    ROBOT_LIBRARY_SCOPE = 'SUITE'

    def __init__(self):
        self._client = None
        self._db = None

    @keyword('Connect To Database')
    def connect_to_database(self, uri, db_name):
        """Connect to MongoDB database"""
        try:
            self._client = MongoClient(uri)
            self._db = self._client[db_name]
            # Test connection
            self._client.admin.command('ping')
            return True
        except (ConnectionFailure, OperationFailure) as e:
            raise RuntimeError(f"Failed to connect to MongoDB: {str(e)}")

    @keyword('Disconnect From Database')
    def disconnect_from_database(self):
        """Disconnect from MongoDB database"""
        if self._client is not None:
            self._client.close()
            self._client = None
            self._db = None

    def _validate_product(self, data):
        """Validate product data"""
        required = ["title", "price", "description", "category"]
        if not all(key in data for key in required):
            missing = [f for f in required if f not in data]
            raise ValueError(f"Missing required field(s): {', '.join(missing)}")
        if not isinstance(data["price"], (int, float)):
            raise ValueError("Price must be a number")

    def _validate_user(self, data):
        """Validate user data"""
        required = ["email", "password"]
        if not all(key in data for key in required):
            missing = [f for f in required if f not in data]
            raise ValueError(f"Missing required field(s): {', '.join(missing)}")
        if not re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', data["email"]):
            raise ValueError("Invalid email format")

    def _validate_category(self, data):
        """Validate category data"""
        if "name" not in data:
            raise ValueError("Missing required field: name")
        if not data["name"].strip():
            raise ValueError("Category name cannot be empty")

    def _validate_order(self, data):
        """Validate order data"""
        required = ["product_id", "user_id", "quantity"]
        if not all(key in data for key in required):
            missing = [f for f in required if f not in data]
            raise ValueError(f"Missing required field(s): {', '.join(missing)}")
        if not isinstance(data["quantity"], (int, float)):
            raise ValueError("Quantity must be a number")

    def _convert_id(self, id_str):
        """Convert string ID to ObjectId"""
        try:
            if isinstance(id_str, str):
                id_str = id_str.strip('"\'')
            return ObjectId(id_str)
        except:
            raise ValueError(f"Invalid ObjectId format: {id_str}")

    def _check_connection(self):
        """Check if database connection exists"""
        if self._db is None:
            raise RuntimeError("Not connected to database")

    @keyword('Insert Product')
    def insert_product(self, product_json):
        """Insert a product into MongoDB"""
        self._check_connection()
        try:
            data = json.loads(product_json)
            self._validate_product(data)
            result = self._db.products.insert_one(data)
            return str(result.inserted_id)
        except ValueError as e:
            raise RuntimeError(str(e))
        except Exception as e:
            raise RuntimeError(f"Failed to insert product: {str(e)}")

    @keyword('Get Product By ID')
    def get_product_by_id(self, product_id):
        """Get a product by ID from MongoDB"""
        self._check_connection()
        try:
            obj_id = self._convert_id(product_id)
            result = self._db.products.find_one({"_id": obj_id})
            if result:
                result["_id"] = str(result["_id"])
            return result
        except ValueError:
            return None

    @keyword('Update Product')
    def update_product(self, product_id, new_data_json):
        """Update a product in MongoDB"""
        self._check_connection()
        try:
            obj_id = self._convert_id(product_id)
            data = json.loads(new_data_json)
            if "price" in data and not isinstance(data["price"], (int, float)):
                raise ValueError("Price must be a number")
            result = self._db.products.update_one(
                {"_id": obj_id},
                {"$set": data}
            )
            return result.modified_count
        except ValueError as e:
            raise RuntimeError(str(e))

    @keyword('Delete Product')
    def delete_product(self, product_id):
        """Delete a product from MongoDB"""
        self._check_connection()
        try:
            obj_id = self._convert_id(product_id)
            result = self._db.products.delete_one({"_id": obj_id})
            return result.deleted_count
        except ValueError as e:
            raise RuntimeError(str(e))

    # Similar patterns for other entities with their specific validations
    @keyword('Insert User')
    def insert_user(self, user_json):
        self._check_connection()
        try:
            data = json.loads(user_json)
            self._validate_user(data)
            result = self._db.users.insert_one(data)
            return str(result.inserted_id)
        except ValueError as e:
            raise RuntimeError(str(e))
        except Exception as e:
            raise RuntimeError(f"Failed to insert user: {str(e)}")

    @keyword('Get User By ID')
    def get_user_by_id(self, user_id):
        self._check_connection()
        try:
            obj_id = self._convert_id(user_id)
            result = self._db.users.find_one({"_id": obj_id})
            if result:
                result["_id"] = str(result["_id"])
            return result
        except ValueError:
            return None

    @keyword('Update User')
    def update_user(self, user_id, new_data_json):
        self._check_connection()
        try:
            obj_id = self._convert_id(user_id)
            data = json.loads(new_data_json)
            result = self._db.users.update_one(
                {"_id": obj_id},
                {"$set": data}
            )
            return result.modified_count
        except ValueError as e:
            raise RuntimeError(str(e))

    @keyword('Delete User')
    def delete_user(self, user_id):
        self._check_connection()
        try:
            obj_id = self._convert_id(user_id)
            result = self._db.users.delete_one({"_id": obj_id})
            return result.deleted_count
        except ValueError as e:
            raise RuntimeError(str(e))

    @keyword('Insert Category')
    def insert_category(self, category_json):
        self._check_connection()
        try:
            data = json.loads(category_json)
            self._validate_category(data)
            # Check for duplicate name
            if self._db.categories.find_one({"name": data["name"]}):
                raise ValueError(f"Category with name '{data['name']}' already exists")
            result = self._db.categories.insert_one(data)
            return str(result.inserted_id)
        except ValueError as e:
            raise RuntimeError(str(e))
        except Exception as e:
            raise RuntimeError(f"Failed to insert category: {str(e)}")

    @keyword('Get Category By ID')
    def get_category_by_id(self, category_id):
        self._check_connection()
        try:
            obj_id = self._convert_id(category_id)
            result = self._db.categories.find_one({"_id": obj_id})
            if result:
                result["_id"] = str(result["_id"])
            return result
        except ValueError:
            return None

    @keyword('Update Category')
    def update_category(self, category_id, new_data_json):
        self._check_connection()
        try:
            obj_id = self._convert_id(category_id)
            data = json.loads(new_data_json)
            result = self._db.categories.update_one(
                {"_id": obj_id},
                {"$set": data}
            )
            return result.modified_count
        except ValueError as e:
            raise RuntimeError(str(e))

    @keyword('Delete Category')
    def delete_category(self, category_id):
        self._check_connection()
        try:
            obj_id = self._convert_id(category_id)
            result = self._db.categories.delete_one({"_id": obj_id})
            return result.deleted_count
        except ValueError as e:
            raise RuntimeError(str(e))

    @keyword('Insert Order')
    def insert_order(self, order_json):
        self._check_connection()
        try:
            data = json.loads(order_json)
            self._validate_order(data)
            result = self._db.orders.insert_one(data)
            return str(result.inserted_id)
        except ValueError as e:
            raise RuntimeError(str(e))
        except Exception as e:
            raise RuntimeError(f"Failed to insert order: {str(e)}")

    @keyword('Get Order By ID')
    def get_order_by_id(self, order_id):
        self._check_connection()
        try:
            obj_id = self._convert_id(order_id)
            result = self._db.orders.find_one({"_id": obj_id})
            if result:
                result["_id"] = str(result["_id"])
            return result
        except ValueError:
            return None

    @keyword('Update Order')
    def update_order(self, order_id, new_data_json):
        self._check_connection()
        try:
            obj_id = self._convert_id(order_id)
            data = json.loads(new_data_json)
            if "quantity" in data and not isinstance(data["quantity"], (int, float)):
                raise ValueError("Quantity must be a number")
            result = self._db.orders.update_one(
                {"_id": obj_id},
                {"$set": data}
            )
            return result.modified_count
        except ValueError as e:
            raise RuntimeError(str(e))

    @keyword('Delete Order')
    def delete_order(self, order_id):
        self._check_connection()
        try:
            obj_id = self._convert_id(order_id)
            result = self._db.orders.delete_one({"_id": obj_id})
            return result.deleted_count
        except ValueError as e:
            raise RuntimeError(str(e))
