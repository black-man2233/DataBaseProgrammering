using Microsoft.AspNetCore.Mvc;
using MongoDB.Bson;
using RestRes.Models;
using RestRes.Services;
using RestRes.ViewModels;
using System;

namespace RestRes.Controllers
{
    public class RestaurantController : Controller
    {
        private readonly IRestaurantService _RestaurantService;
        private readonly IReservationService _ReservationService;

        public RestaurantController(IRestaurantService RestaurantService, IReservationService ReservationService)
        {
            _RestaurantService = RestaurantService;
            _ReservationService = ReservationService;
        }

        public IActionResult Index()
        {
            var viewModel = new RestaurantListViewModel
            {
                Restaurants = _RestaurantService.GetAllRestaurants(),
            };
            return View(viewModel);
        }
        public IActionResult Add()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Add(RestaurantAddViewModel restaurantAddViewModel)
        {
            if (ModelState.IsValid)
            {
                var newRestaurant = new Restaurant
                {
                    Name = restaurantAddViewModel.Restaurant.Name,
                    Borough = restaurantAddViewModel.Restaurant.Borough,
                    Cuisine = restaurantAddViewModel.Restaurant.Cuisine
                };

                _RestaurantService.AddRestaurant(newRestaurant);
                return RedirectToAction("Index");
            }

            return View(restaurantAddViewModel);
        }

        public IActionResult Edit(ObjectId id)
        {
            if (id == ObjectId.Empty)
            {
                return NotFound();
            }

            var selectedRestaurant = _RestaurantService.GetRestaurantById(id);
            if (selectedRestaurant == null)
            {
                return NotFound();
            }

            return View(selectedRestaurant);
        }
        [HttpPost]
        public IActionResult Edit(Restaurant restaurant)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    _RestaurantService.EditRestaurant(restaurant);
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", $"Error updating the restaurant: {ex.Message}");
                }
            }
            return View(restaurant);
        }
        public IActionResult Delete(ObjectId id)
        {
            if (id == ObjectId.Empty)
            {
                return NotFound();
            }

            var selectedRestaurant = _RestaurantService.GetRestaurantById(id);
            if (selectedRestaurant == null)
            {
                return NotFound();
            }

            return View(selectedRestaurant);
        }

        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed(ObjectId id)
        {
            var restaurant = _RestaurantService.GetRestaurantById(id);
            if (restaurant == null)
            {
                return NotFound();
            }

            try
            {
                _RestaurantService.DeleteRestaurant(restaurant);
                TempData["RestaurantDeleted"] = "Restaurant deleted successfully!";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewData["ErrorMessage"] = $"Error deleting the restaurant: {ex.Message}";
                return View(restaurant);
            }
        }
    }
}
