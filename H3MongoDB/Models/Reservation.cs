using MongoDB.Bson;
using MongoDB.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using MongoDB.Bson.Serialization.Attributes;

namespace RestRes.Models
{
    public class Reservation
    {
        [BsonId]
        public ObjectId Id { get; set; }

        [BsonElement("restaurantId")]
        public ObjectId RestaurantId { get; set; }

        [Required(ErrorMessage = "The restaurant name is required.")]
        [StringLength(100, ErrorMessage = "Restaurant name can't be longer than 100 characters.")]
        public string? RestaurantName { get; set; }

        [Required(ErrorMessage = "The date and time are required to make this reservation")]
        [Display(Name = "Date")]
        public DateTime Date { get; set; }
    }
}