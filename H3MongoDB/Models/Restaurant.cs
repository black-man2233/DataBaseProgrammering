using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using System.ComponentModel.DataAnnotations;

namespace RestRes.Models
{
    public class Restaurant
    {
        [BsonId]
        public ObjectId Id { get; set; }

        [Required(ErrorMessage = "You must provide a name")]
        [Display(Name = "Name")]
        public string? Name { get; set; }

        [Required(ErrorMessage = "You must add a cuisine type")]
        [Display(Name = "Cuisine")]
        public string? Cuisine { get; set; }

        [Required(ErrorMessage = "You must add the borough of the restaurant")]
        public string? Borough { get; set; }
    }
}