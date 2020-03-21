using System;
using System.ComponentModel.DataAnnotations;

namespace BikeStores.API.Domain.Models.Request
{
    public class CategoryRequestModel
    {
        [Required]
        [MaxLength(255)]
        public string CategoryName { get; set; }
    }
}
