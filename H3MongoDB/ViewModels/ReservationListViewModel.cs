using RestRes.Models;
using MongoDB.Bson;
using System.Collections.Generic;

namespace RestRes.ViewModels
{
    public class ReservationListViewModel
    {
        public List<ReservationGroupViewModel> ReservationGroups { get; set; }
    }

    public class ReservationGroupViewModel
    {
        public ObjectId RestaurantId { get; set; }  
        public string RestaurantName { get; set; }
        public List<Reservation> Reservations { get; set; }
    }
}