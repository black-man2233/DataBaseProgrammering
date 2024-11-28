using MongoDB.Bson;
using MongoDB.Driver;
using RestRes.Models;

namespace RestRes.Services
{
    public class RestaurantService : IRestaurantService
    {
        private readonly IMongoCollection<Restaurant> _restaurantsCollection;

        public RestaurantService(IMongoDatabase mongoDatabase)
        {
            _restaurantsCollection = mongoDatabase.GetCollection<Restaurant>("restaurants");
        }

        public void AddRestaurant(Restaurant restaurant)
        {
            _restaurantsCollection.InsertOne(restaurant);
        }

        public void DeleteRestaurant(Restaurant restaurant)
        {
            var filter = Builders<Restaurant>.Filter.Eq(r => r.Id, restaurant.Id);
            _restaurantsCollection.DeleteOne(filter);
        }

        public void EditRestaurant(Restaurant restaurant)
        {
            var filter = Builders<Restaurant>.Filter.Eq(r => r.Id, restaurant.Id);
            var update = Builders<Restaurant>.Update
                .Set(r => r.Name, restaurant.Name)
                .Set(r => r.Cuisine, restaurant.Cuisine)
                .Set(r => r.Borough, restaurant.Borough);

            _restaurantsCollection.UpdateOne(filter, update);
        }

        public IEnumerable<Restaurant> GetAllRestaurants()
        {
            return _restaurantsCollection.Find(FilterDefinition<Restaurant>.Empty).ToList();
        }

        public Restaurant? GetRestaurantById(ObjectId id)
        {
            var filter = Builders<Restaurant>.Filter.Eq(r => r.Id, id);
            return _restaurantsCollection.Find(filter).FirstOrDefault();
        }
    }
}