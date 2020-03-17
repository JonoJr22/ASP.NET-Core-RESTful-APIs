using BikeStores.API.Domain.Communication;
using BikeStores.API.Domain.Models.Response;
using BikeStores.API.Domain.Services;
using BikeStores.API.Domain.Utilities;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BikeStores.API.Services
{
    public class CategoryService : ICategoryService
    {
        private readonly IDatabaseUtility _databaseUtility;

        public CategoryService(IDatabaseUtility databaseUtility)
        {
            _databaseUtility = databaseUtility;
        }

        public async Task<Response<IEnumerable<CategoryResponseModel>>> ListAsync()
        {
            try
            {
                var data = await _databaseUtility.ExecuteStoredProcedureAsync<CategoryResponseModel>("GetCategories", null);
                var result = new Response<IEnumerable<CategoryResponseModel>>(data);

                return result;
            }
            catch (Exception ex)
            {
                var result = new Response<IEnumerable<CategoryResponseModel>>($"An error occured when listing the categories: {ex.Message}");

                return result;
            }
        }
    }
}
