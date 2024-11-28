using Microsoft.AspNetCore.Mvc;
using MongoDB.Bson;
using RestRes.Models;
using RestRes.Services;
using RestRes.ViewModels;
using System.Collections.Generic;
using System.Linq;

namespace RestRes.Controllers
{
    public class ReservationController : Controller
    {
        private readonly IReservationService _reservationService;

        public ReservationController(IReservationService reservationService)
        {
            _reservationService = reservationService;
        }

        public IActionResult Add(ObjectId restaurantId)
        {
            var restaurant = _reservationService.GetRestaurantById(restaurantId);

            if (restaurant == null)
            {
                return NotFound();
            }

            var viewModel = new ReservationAddViewModel
            {
                Reservation = new Reservation
                {
                    RestaurantId = restaurant.Id,
                    RestaurantName = restaurant.Name
                }
            };

            return View(viewModel);
        }

        public IActionResult AddWithRestaurantList()
        {
            var restaurants = _reservationService.GetAllRestaurants();

            var viewModel = new RestaurantListViewModel
            {
                Restaurants = restaurants
            };

            return View(viewModel);
        }

        [HttpPost]
        public IActionResult Add(ReservationAddViewModel reservationAddViewModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var newReservation = new Reservation
                    {
                        RestaurantName = reservationAddViewModel.Reservation.RestaurantName,
                        Date = reservationAddViewModel.Reservation.Date,
                        RestaurantId = reservationAddViewModel.Reservation.RestaurantId
                    };

                    _reservationService.AddReservation(newReservation);
                    return RedirectToAction("Index", "Reservation");
                }
                return View(reservationAddViewModel);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"An error occurred while adding the reservation: {ex.Message}");
                return View(reservationAddViewModel);
            }
        }
        public IActionResult Index()
        {
            var reservations = _reservationService.GetAllReservations();
    
            var restaurants = _reservationService.GetAllRestaurants();

            var groupedReservations = restaurants
                .Select(restaurant => new ReservationGroupViewModel
                {
                    RestaurantId = restaurant.Id,
                    RestaurantName = restaurant.Name,
                    Reservations = reservations
                        .Where(r => r.RestaurantId == restaurant.Id)
                        .ToList()
                })
                .ToList();

            return View(new ReservationListViewModel
            {
                ReservationGroups = groupedReservations
            });
        }
        public IActionResult Edit(ObjectId id)
        {
            if (id == ObjectId.Empty)
            {
                return NotFound();
            }

            var reservation = _reservationService.GetReservationById(id);
            if (reservation == null)
            {
                return NotFound();
            }

            return View(reservation);
        }

        [HttpPost]
        public IActionResult Edit(Reservation reservation)
        {
            if (ModelState.IsValid)
            {
                _reservationService.EditReservation(reservation);
                return RedirectToAction("Index");
            }

            return View(reservation);
        }

        public IActionResult Delete(ObjectId id)
        {
            if (id == ObjectId.Empty)
            {
                return NotFound();
            }

            var reservation = _reservationService.GetReservationById(id);
            if (reservation == null)
            {
                return NotFound();
            }

            return View(reservation);
        }

        [HttpPost, ActionName("Delete")]
        public IActionResult DeleteConfirmed(ObjectId id)
        {
            var reservation = _reservationService.GetReservationById(id);
            if (reservation == null)
            {
                return NotFound();
            }

            _reservationService.DeleteReservation(reservation);
            TempData["ReservationDeleted"] = "Reservation deleted successfully!";
            return RedirectToAction("Index");
        }
    }
}
