# CashiRu Mobile Apps
<img  height="137" alt="cashiru_landscape_bggreycompressed2" src="https://github.com/user-attachments/assets/bd346230-fe95-4819-a8c9-62142b897bf0" />


### Automated Test Results

```
✅ /CashiRu-mobile/test/unit/data/datasource/auth_local_datasource_test.dart: saveAuthData stores data in SharedPreferences
✅ /CashiRu-mobile/test/unit/data/datasource/auth_local_datasource_test.dart: getAuthData returns AuthResponseModel if data exists
✅ /CashiRu-mobile/test/unit/data/datasource/auth_local_datasource_test.dart: getAuthData returns null if no data
✅ /CashiRu-mobile/test/unit/data/datasource/auth_local_datasource_test.dart: isAuthenticated returns true if data exists
✅ /CashiRu-mobile/test/unit/data/datasource/auth_local_datasource_test.dart: isAuthenticated returns false if no data
✅ /CashiRu-mobile/test/unit/data/datasource/auth_local_datasource_test.dart: clearAuthData removes data from SharedPreferences
✅ /CashiRu-mobile/test/unit/data/datasource/auth_local_datasource_test.dart: getAuthData returns AuthResponseModel with user data
✅ /CashiRu-mobile/test/unit/data/datasource/auth_remote_datasource_test.dart: login returns Right(AuthResponseModel) on 200
✅ /CashiRu-mobile/test/unit/data/datasource/auth_remote_datasource_test.dart: login returns Left with validation message on 422
✅ /CashiRu-mobile/test/unit/data/datasource/auth_remote_datasource_test.dart: logout returns Right on 200 and clears local data
✅ /CashiRu-mobile/test/unit/data/datasource/auth_remote_datasource_test.dart: logout returns Left on error
✅ /CashiRu-mobile/test/unit/data/datasource/auth_remote_datasource_test.dart: logout returns Left on 401 unauthenticated
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: User model fromMap creates correct User
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: User model toMap outputs correct map
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: User model fromJson and toJson round-trip
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: User model fromMap handles nulls
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: AuthResponseModel fromMap creates correct AuthResponseModel
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: AuthResponseModel toMap outputs correct map
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: AuthResponseModel fromJson and toJson round-trip
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: AuthResponseModel fromMap handles null user
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_test.dart: AuthResponseModel fromMap handles missing fields
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_v2_test.dart: User model fromMap should parse correctly with full data
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_v2_test.dart: User model toMap should convert to correct map
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_v2_test.dart: User model User.fromMap throws FormatException when created_at is invalid
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_v2_test.dart: AuthResponseModel fromMap should parse correctly including nested User
✅ /CashiRu-mobile/test/unit/data/models/auth_response_model_v2_test.dart: AuthResponseModel toMap should serialize correctly with nested User
✅ /CashiRu-mobile/test/unit/data/models/category_response_model_test.dart: CategoryResponseModel fromJson should parse valid response correctly
✅ /CashiRu-mobile/test/unit/data/models/category_response_model_test.dart: CategoryResponseModel fromJson should handle null or missing data
✅ /CashiRu-mobile/test/unit/data/models/category_response_model_test.dart: Category toMap should return correct map structure
✅ /CashiRu-mobile/test/unit/data/models/category_response_model_test.dart: Category fromMap should parse valid map correctly
✅ /CashiRu-mobile/test/unit/data/models/order_response_model_test.dart: Order fromMap parses all fields correctly
✅ /CashiRu-mobile/test/unit/data/models/order_response_model_test.dart: Order fromMap handles null order_items
✅ /CashiRu-mobile/test/unit/data/models/order_response_model_test.dart: Order toMap outputs correct map
✅ /CashiRu-mobile/test/unit/data/models/order_response_model_test.dart: OrderItem fromMap parses nested product correctly
✅ /CashiRu-mobile/test/unit/data/models/order_response_model_test.dart: OrderItem fromMap handles null product
✅ /CashiRu-mobile/test/unit/data/models/order_response_model_test.dart: OrderItem toMap outputs correct map
✅ /CashiRu-mobile/test/unit/data/models/product_response_model_test.dart: Product.fromMap parses correctly with all fields present
✅ /CashiRu-mobile/test/unit/data/models/product_response_model_test.dart: Product.fromMap parses correctly when nullable fields are null
✅ /CashiRu-mobile/test/unit/data/models/product_sales_response_model_test.dart: ProductSales fromMap parses all fields and converts productPrice correctly
✅ /CashiRu-mobile/test/unit/data/models/product_sales_response_model_test.dart: ProductSales fromMap throws if product_price is not a valid number
✅ /CashiRu-mobile/test/unit/data/models/product_sales_response_model_test.dart: ProductSales fromJson parses JSON string correctly
✅ /CashiRu-mobile/test/unit/data/models/summary_response_model_test.dart: Summary.fromMap parses correctly when total_sold_quantity is int
✅ /CashiRu-mobile/test/unit/data/models/summary_response_model_test.dart: Summary.fromMap parses correctly when total_sold_quantity is string
✅ /CashiRu-mobile/test/unit/data/models/summary_response_model_test.dart: Summary.fromMap throws if total_sold_quantity is string but not a number

🎉 44 tests passed.
```