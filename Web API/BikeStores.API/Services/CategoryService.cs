using BikeStores.API.Domain.Communication;
using BikeStores.API.Domain.Models.Request;
using BikeStores.API.Domain.Models.Response;
using BikeStores.API.Domain.Services;
using BikeStores.API.Domain.Utilities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
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

        public async Task<Response<CategoryResponseModel>> CollectAsync(int id)
        {
            try
            {
                var parameterList = new List<SqlParameter>
                {
                    new SqlParameter("@pnId", id)
                };

                var data = await _databaseUtility.ExecuteStoredProcedureAsync<CategoryResponseModel>("GetCategory", parameterList);
                var result = new Response<CategoryResponseModel>(data.First());

                return result;
            }
            catch (Exception ex)
            {
                var result = new Response<CategoryResponseModel>($"An error occured when collecting the category: {ex.Message}");

                return result;
            }
        }

        public async Task<Response<CategoryResponseModel>> SaveAsync(CategoryRequestModel category)
        {
            try
            {
                var categoryJson = JsonConvert.SerializeObject(category);

                var parameterList = new List<SqlParameter>
                {
                    new SqlParameter("@pjCategory", categoryJson)
                };

                var data = await _databaseUtility.ExecuteStoredProcedureAsync<CategoryResponseModel>("SaveCategory", parameterList);
                var result = new Response<CategoryResponseModel>(data.First());

                return result;
            }
            catch (Exception ex)
            {
                var result = new Response<CategoryResponseModel>($"An error occured when saving the brand: {ex.Message}");

                return result;
            }
        }

        public async Task<Response<CategoryResponseModel>> UpdateAsync(int id, CategoryRequestModel category)
        {
            try
            {
                var categoryJson = JsonConvert.SerializeObject(category);

                var parameterList = new List<SqlParameter>
                {
                    new SqlParameter("@pnId", id),
                    new SqlParameter("@pjCategory", categoryJson)
                };

                var data = await _databaseUtility.ExecuteStoredProcedureAsync<CategoryResponseModel>("UpdateCategory", parameterList);
                var result = new Response<CategoryResponseModel>(data.First());

                return result;
            }
            catch(Exception ex)
            {
                var result = new Response<CategoryResponseModel>($"An error occured when updating category: {ex.Message}");

                return result;  
            }
        }
    }
}
