using BikeStores.API.Domain.Models.Request;
using BikeStores.API.Domain.Models.Response;
using BikeStores.API.Domain.Services;
using BikeStores.API.Extensions;
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

        [HttpPost]
        public async Task<IActionResult> PostAsync([FromBody] BrandRequestModel brand)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState.GetErrorMessages());

            var result = await _brandService.SaveAsync(brand);

            if (!result.Success)
                return BadRequest(result.Message);

            return Ok(result.Data);
        }
    }
}
