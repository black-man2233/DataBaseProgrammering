using MongoDB.Bson;
using MongoDB.Driver;
using RestRes.Models;

namespace RestRes.Services
{
    public class ReservationService : IReservationService
    {
        private readonly IMongoCollection<Reservation> _reservationsCollection;
        private readonly IMongoCollection<Restaurant> _restaurantsCollection;

        public ReservationService(IMongoDatabase mongoDatabase)
        {
            _reservationsCollection = mongoDatabase.GetCollection<Reservation>("reservations");
            _restaurantsCollection = mongoDatabase.GetCollection<Restaurant>("restaurants");
        }

        public void AddReservation(Reservation newReservation)
        {
            var restaurant = _restaurantsCollection.Find(r => r.Id == newReservation.RestaurantId).FirstOrDefault();
            if (restaurant == null)
            {
                throw new ArgumentException($"The restaurant with ID {newReservation.RestaurantId} cannot be found.");
            }
            newReservation.RestaurantName = restaurant.Name;

            _reservationsCollection.InsertOne(newReservation);
        }

        public void DeleteReservation(Reservation reservation)
        {
            var filter = Builders<Reservation>.Filter.Eq(r => r.Id, reservation.Id);
            _reservationsCollection.DeleteOne(filter);
        }

        public void EditReservation(Reservation updatedReservation)
        {
            var filter = Builders<Reservation>.Filter.Eq(r => r.Id, updatedReservation.Id);
            var update = Builders<Reservation>.Update.Set(r => r.Date, updatedReservation.Date);

            _reservationsCollection.UpdateOne(filter, update);
        }

        public IEnumerable<Reservation> GetAllReservations()
        {
            return _reservationsCollection.Find(FilterDefinition<Reservation>.Empty).SortBy(r => r.Date).ToList();
        }

        public Reservation? GetReservationById(ObjectId id)
        {
            var filter = Builders<Reservation>.Filter.Eq(r => r.Id, id);
            return _reservationsCollection.Find(filter).FirstOrDefault();
        }
        
        
        public IEnumerable<Restaurant> GetAllRestaurants()
        {
            return _restaurantsCollection.Find(FilterDefinition<Restaurant>.Empty).ToList();
        }

        public Restaurant? GetRestaurantById(ObjectId restaurantId)
        {
            var filter = Builders<Restaurant>.Filter.Eq(r => r.Id, restaurantId);
            return _restaurantsCollection.Find(filter).FirstOrDefault();
        }
    }
}
