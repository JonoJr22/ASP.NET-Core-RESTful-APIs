using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BikeStores.API.Domain.Models.Request;
using BikeStores.API.Domain.Services;
using BikeStores.API.Extensions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BikeStores.API.Controllers
{
    [Route("api/[controller]")]
    public class CategoryController : Controller
    {
        private readonly ICategoryService _categoryService;

        public CategoryController(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllAsync()
        {
            var result = await _categoryService.ListAsync();

            if (!result.Success)
                return BadRequest(result.Message);

            return Ok(result.Data);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetAsync(int id)
        {
            var result = await _categoryService.CollectAsync(id);

            if (!result.Success)
                return BadRequest(result.Message);

            return Ok(result.Data);
        }

        [HttpPost]
        public async Task<IActionResult> PostAsync([FromBody] CategoryRequestModel category)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState.GetErrorMessages());

            var result = await _categoryService.SaveAsync(category);

            if (!result.Success)
                return BadRequest(result.Message);

            return Ok(result.Data);
        }
    }
}