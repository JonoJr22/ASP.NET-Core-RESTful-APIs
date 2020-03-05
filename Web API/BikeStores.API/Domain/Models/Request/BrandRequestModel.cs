using System.ComponentModel.DataAnnotations;

namespace BikeStores.API.Domain.Models.Request
{
    public class BrandRequestModel
    {
        [Required]
        [MaxLength(255)]
        public string BrandName { get; set; }
    }
}
