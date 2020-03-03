using BikeStores.API.Domain.Models.Response;
using BikeStores.API.Domain.Services;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BikeStores.API.Controllers
{
    [Route("api/[controller]")]
    public class BrandController : Controller
    {
        private readonly IBrandService _brandService;

        public BrandController(IBrandService brandService)
        {
            _brandService = brandService;
        }

        [HttpGet]
        public async Task<IEnumerable<BrandResponseModel>> GetAllAsync()
        {
            var brands = await _brandService.ListAsync();
            return brands;
        }
    }
}
