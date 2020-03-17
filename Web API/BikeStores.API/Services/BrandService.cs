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
    public class BrandService : IBrandService
    {
        private readonly IDatabaseUtility _databaseUtility;

        public BrandService(IDatabaseUtility databaseUtility)
        {
            _databaseUtility = databaseUtility;
        }

        public async Task<Response<IEnumerable<BrandResponseModel>>> ListAsync()
        {
            try
            {
                var data = await _databaseUtility.ExecuteStoredProcedureAsync<BrandResponseModel>("GetBrands", null);
                var result = new Response<IEnumerable<BrandResponseModel>>(data);
                
                return result;
            }
            catch (Exception ex)
            {
                var result = new Response<IEnumerable<BrandResponseModel>>($"An error occured when listing the brands: {ex.Message}");

                return result;
            }
        }

        public async Task<Response<BrandResponseModel>> CollectAsync(int id)
        {
            try
            {
                var listParameter = new List<SqlParameter>
                {
                    new SqlParameter("@pnId", id)
                };

                var data = await _databaseUtility.ExecuteStoredProcedureAsync<BrandResponseModel>("GetBrand", listParameter);
                var result = new Response<BrandResponseModel>(data.First());

                return result;
            }
            catch (Exception ex)
            {
                var result = new Response<BrandResponseModel>($"An error occured when collecting the brand: {ex.Message}");

                return result;
            }
        }

        public async Task<Response<BrandResponseModel>> SaveAsync(BrandRequestModel brand)
        {
            try
            {
                var brandJson = JsonConvert.SerializeObject(brand);

                var listParameter = new List<SqlParameter>
                {
                    new SqlParameter("@pjBrand", brand)
                };

                var data = await _databaseUtility.ExecuteStoredProcedureAsync<BrandResponseModel>("SaveBrand", listParameter);
                var result = new Response<BrandResponseModel>(data.First());

                return result;
            }
            catch (Exception ex)
            {
                var result = new Response<BrandResponseModel>($"An error occured when saving the brand: {ex.Message}");

                return result;
            }
        }

        public async Task<Response<BrandResponseModel>> UpdateAsync(int id, BrandRequestModel brand)
        {
            try
            {
                var brandJson = JsonConvert.SerializeObject(brand);

                var listParameter = new List<SqlParameter>
                {
                    new SqlParameter("@pnId", id),
                    new SqlParameter("@pjBrand", brandJson)
                };

                var data = await _databaseUtility.ExecuteStoredProcedureAsync<BrandResponseModel>("UpdateBrand", listParameter);
                var result = new Response<BrandResponseModel>(data.First());
                
                return result;
            }
            catch (Exception ex)
            {
                var result = new Response<BrandResponseModel>($"An error occured when updating the brand: {ex.Message}");

                return result;
            }
        }

        public async Task<Response<BrandResponseModel>> RemoveAsync(int id)
        {
            try
            {
                var listParameter = new List<SqlParameter>
                {
                    new SqlParameter("pnId", id)
                };

                var data = await _databaseUtility.ExecuteStoredProcedureAsync<BrandResponseModel>("RemoveBrand", listParameter);
                var result = new Response<BrandResponseModel>(data.First());

                return result;
            }
            catch (Exception ex)
            {
                var result = new Response<BrandResponseModel>($"An error occured when removing the brand: {ex.Message}");

                return result;
            }
        }
    }
}
